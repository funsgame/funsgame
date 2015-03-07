//
//  FindBackPsdVC.m
//  KinHop
//
//  Created by weibin on 14/12/18.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "FindBackPsdVC.h"

#define kLeftDis 20
#define kHeight 50
#define kLine 0.5

// 字数常量
static NSInteger const limitNameMin = 6;
static NSInteger const limitNameMax = 20;
static NSInteger const limitPwordMin = 6;
static NSInteger const limitPwordMax = 20;
static NSInteger const limitCode = 6;

// 异常提示语
static NSString *const kAlertNameFormat = @"6-20个字符，支持中文\\英文\\数字\\下划线";
static NSString *const kAlertNameSpecial = @"暂不支持特殊符号";
static NSString *const kAlertNameNotExist = @"您的用户名还未注册";
static NSString *const kAlertNameNull = @"请设定一个用户名";

static NSString *const kAlertPwordFormat = @"密码长度为6－20个字符";
static NSString *const kAlertPwordNull = @"请输入密码";
static NSString *const kAlertPwordNotSame = @"输入密码不一致";

static NSString *const kAlertMobileNull = @"请填写手机号码";
static NSString *const kAlertMobileFormat = @"请填写有效的手机号码";
static NSString *const kAlertMobileNotExist = @"您的手机号还未注册";

static NSString *const kAlertCodeFormat = @"请输入6位验证码";
static NSString *const kAlertCodeError = @"验证码有误，请重新获取";
static NSString *const kAlertCodeNull = @"请输入验证码";

static NSString *const kAlertModifySucess = @"密码修改成功！请重新登录";

@interface FindBackPsdVC ()<UITextFieldDelegate>
{
    UIView *_headView;
    UITextField *_nameField;
    UITextField *_telephoneField;
    UITextField *_verifyField;
    UITextField *_psdField;
    UITextField *_cmtPsdField;
    
    CountDownButton *_countDownButton;    // 倒计时按钮
    UIButton *_commitBtn;
    BOOL _isBackSuperView;
}
@property (nonatomic, strong) UITableView *findPsdTableView;

@end

@implementation FindBackPsdVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"找回密码";
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:IQKeyboardDistanceFromTextField];
}

- (void)backToSuperView
{
    _isBackSuperView = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self textFieldReturn];
    
    [self initView];
}

- (void)initView
{
    self.view.backgroundColor = kJHSColorDarkWhite;
    
    _findPsdTableView = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), nil, nil, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
    _findPsdTableView.showsVerticalScrollIndicator = NO;
    _findPsdTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _findPsdTableView.backgroundColor = kJHSColorDarkWhite;
    [DataHelper setExtraCellLineHidden:_findPsdTableView];
    
    _headView = InsertView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), kColorClear);
    _findPsdTableView.tableHeaderView = _headView;
    
    UIView *bgView = InsertView(_headView, CGRectMake(0, 0, kScreenWidth, kHeight * 5), kColorWhite);
    
    UILabel *nameLabel = InsertLabel(_headView, CGRectMake(kLeftDis, 0, 50, kHeight), NSTextAlignmentLeft, @"用户名", kFontSize15, kJHSColorBlack, NO);

    _nameField = [[MyTextField alloc]initWithFrame:
                      CGRectMake(nameLabel.right + 10, 0, kScreenWidth - 80, kHeight)];
    _nameField.delegate = self;
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameField.font = kFontSize15;
    _nameField.textColor = kJHSColorBlack;
    _nameField.keyboardType = UIKeyboardTypeASCIICapable;
    _nameField.backgroundColor = kColorWhite;
    _nameField.placeholder = @"请输入您的用户名";
    if (ISIOS7) {
        _nameField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_nameField];
    
    [DataHelper setEmptyLeftViewForTextField:_nameField withFrame:CGRectMake(0, 0, 15, _nameField.height)];
    
    InsertView(bgView, CGRectMake(kLeftDis, _nameField.bottom - kLine, kScreenWidth - kLeftDis, kLine), kJHSColorLightBlack);
    
    UILabel *teleLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _nameField.bottom, 50, kHeight), NSTextAlignmentLeft, @"手机号", kFontSize15, kJHSColorBlack, NO);

    _telephoneField = [[MyTextField alloc]initWithFrame:
                  CGRectMake(teleLabel.right + 10, _nameField.bottom, kScreenWidth - 80, kHeight)];
    
    _telephoneField.delegate = self;
    _telephoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _telephoneField.font = kFontSize15;
    _telephoneField.textColor = kJHSColorBlack;
    _telephoneField.keyboardType = UIKeyboardTypeNumberPad;
    _telephoneField.backgroundColor = kColorWhite;
    _telephoneField.placeholder = @"请输入您绑定的手机号";
    if (ISIOS7) {
        _nameField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_telephoneField];
    
    [DataHelper setEmptyLeftViewForTextField:_telephoneField withFrame:CGRectMake(0, 0, 15, _telephoneField.height)];
    
    InsertView(bgView, CGRectMake(kLeftDis, _telephoneField.bottom - kLine, kScreenWidth - kLeftDis, kLine), kJHSColorLightBlack);
    
    UILabel *veriLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _telephoneField.bottom, 50, kHeight), NSTextAlignmentLeft, @"验证码", kFontSize15, kJHSColorBlack, NO);

    _verifyField = [[MyTextField alloc]initWithFrame:
                 CGRectMake(veriLabel.right + 10, _telephoneField.bottom, kScreenWidth - 180, kHeight)];
    
    _verifyField.delegate = self;
    _verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _verifyField.font = kFontSize15;
    _verifyField.textColor = kJHSColorBlack;
    _verifyField.keyboardType = UIKeyboardTypeNumberPad;
    _verifyField.backgroundColor = kColorWhite;
    _verifyField.placeholder = @"请输入验证码";
    if (ISIOS7) {
        _verifyField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_verifyField];
    
    // 倒计时
    _countDownButton = [CountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownButton.frame = CGRectMake(kScreenWidth - 100, _verifyField.top + 8, 90, 34);
    _countDownButton.normalTitle = @"发送验证码";
    kSelfWeak;
    _countDownButton.buttonClickedBlock = ^{
        [weakSelf sendPostToGetValidateCode];
    };
    [bgView addSubview:_countDownButton];
    
    [DataHelper setEmptyLeftViewForTextField:_verifyField withFrame:CGRectMake(0, 0, 15, _verifyField.height)];
    
    InsertView(bgView, CGRectMake(kLeftDis, _verifyField.bottom - kLine, kScreenWidth - kLeftDis, kLine), kJHSColorLightBlack);
    
    UILabel *psdLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _verifyField.bottom, 60, kHeight), NSTextAlignmentLeft, @"重置密码", kFontSize15, kJHSColorBlack, NO);
    
    _psdField = [[MyTextField alloc]initWithFrame:
                    CGRectMake(psdLabel.right + 10, _verifyField.bottom, kScreenWidth - 90, kHeight)];
    
    _psdField.delegate = self;
    _psdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _psdField.font = kFontSize15;
    _psdField.textColor = kJHSColorBlack;
    _psdField.keyboardType = UIKeyboardTypeASCIICapable;
    _psdField.backgroundColor = kColorWhite;
    _psdField.placeholder = @"请输入新密码";
    _psdField.secureTextEntry = YES;
    if (ISIOS7) {
        _psdField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_psdField];
    
    [DataHelper setEmptyLeftViewForTextField:_psdField withFrame:CGRectMake(0, 0, 5, _psdField.height)];
    
    InsertView(bgView, CGRectMake(kLeftDis, _psdField.bottom - kLine, kScreenWidth - kLeftDis, kLine), kJHSColorLightBlack);
    
    UILabel *cmtLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _psdField.bottom, 60, kHeight), NSTextAlignmentLeft, @"确认密码", kFontSize15, kJHSColorBlack, NO);
    
    _cmtPsdField = [[MyTextField alloc]initWithFrame:
                     CGRectMake(cmtLabel.right + 10, _psdField.bottom, kScreenWidth - 90, kHeight)];
    _cmtPsdField.delegate = self;
    _cmtPsdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _cmtPsdField.font = kFontSize15;
    _cmtPsdField.textColor = kJHSColorBlack;
    _cmtPsdField.keyboardType = UIKeyboardTypeASCIICapable;
    _cmtPsdField.backgroundColor = kColorWhite;
    _cmtPsdField.placeholder = @"请再次输入新密码";
    _cmtPsdField.secureTextEntry = YES;
    if (ISIOS7) {
        _cmtPsdField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_cmtPsdField];
    
    [DataHelper setEmptyLeftViewForTextField:_cmtPsdField withFrame:CGRectMake(0, 0, 5, _cmtPsdField.height)];
    
    _commitBtn = InsertButtonRoundedRect(_headView, CGRectMake(14, bgView.bottom + 20, kScreenWidth - 28, 50), 99, @"确认", self, @selector(commitClick:));
    
    _commitBtn.titleLabel.font = kFontSizeBold18;
    [_commitBtn setTitleColor: kColorWhite forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:kJHSColorRed];
    _commitBtn.layer.cornerRadius = 3;
    _commitBtn.clipsToBounds = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];

}

- (void)commitClick:(UIButton *)sender
{
    if (![self checkInfo])
    {
        return;
    }
}

// 发送请求获取验证码
- (void)sendPostToGetValidateCode
{
    [self.view endEditing:YES];
    
    // 判断手机号码
    if (![self checkTelephone])
    {
        return;
    }
    _countDownButton.time = 120;
    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeNone];
    
    /*
     // 获取短信验证码，并判断手机号是否绑定
     [UserModel getSMSverificationForMemberRegiteWithPhoneNumber:_phoneNumberTextField.text success:^(StatusModel *data) {
     if (data.flag == 1)
     {
     [SVProgressHUD dismiss];
     [iToast alertWithTitle:data.msg];
     _key = ((UserModel *)data.rs).key;
     [_getValidateCodeButton start];
     _validateCodeTextField.enabled = YES;
     }
     else
     {
     [SVProgressHUD showErrorWithStatus:data.msg];
     _getValidateCodeButton.enabled = YES;
     }
     }];
     */
    kSelfWeak;
    // 获取短信验证码，并判断手机号是否绑定
    [UserModel sendMobileCodeUserId:@"" mobile:_telephoneField.text codeType:@"6" target:self success:^(StatusModel *data) {
        [weakSelf loadFinishForSMS:data];
    }];
    // 1 网络请求将要开始，设置网络请求状态
    [_countDownButton showActivity];
}

- (BOOL)checkInfo
{
    if ([NSString isNull:_nameField.text])
    {
        [iToast alertWithTitle:kAlertNameNull];
        [_nameField becomeFirstResponder];
        return NO;
    }
    
    if ([NSString isNull:_telephoneField.text])
    {
        [iToast alertWithTitle:kAlertMobileNull];
        [_telephoneField becomeFirstResponder];
        return NO;
    }
    
    if ([NSString isNull:_verifyField.text])
    {
        [iToast alertWithTitle:kAlertCodeNull];
        [_verifyField becomeFirstResponder];
        return NO;
    }

    if ([NSString isNull:_psdField.text])
    {
        [iToast alertWithTitle:kAlertPwordNull];
        [_psdField becomeFirstResponder];
        return NO;
    }

    if ([NSString isNull:_cmtPsdField.text])
    {
        [iToast alertWithTitle:kAlertPwordNull];
        [_cmtPsdField becomeFirstResponder];
        return NO;
    }

    return YES;
}

// 检测输入的是否为手机号码
- (BOOL)checkTelephone
{
    if ([NSString isNull:_telephoneField.text])
    {
        [iToast alertWithTitle:kAlertMobileNull];
        [_telephoneField becomeFirstResponder];
        return NO;
    }
    else if (![_telephoneField.text isMobile])
    {
        [iToast alertWithTitle:kAlertMobileFormat];
        [_telephoneField becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)loadFinishForSMS:(StatusModel *)data
{
//    [SVProgressHUD dismiss];
//    if (1 == data.resultStatus) {
////        int isExists = ((UserModel *)data.result).isExists;
////        if (isExists != 1) {
////            [iToast alertWithTitle:kAlertMobileNotExist];
////            [_countDownButton stop];
////            return;
////        }
//        // 2.1 请求成功
//        [_countDownButton start];
//    } else {
//        if (data.resultStatus <= 0) {
//            [iToast alertWithTitle:kloadfailedNotNetwork];
//        }else{
//            [iToast alertWithTitle:data.exception];
//        }
//        // 2.2 请求失败
//        [_countDownButton stop];
//    }
}

#pragma mark - UITextField delegate
// 限制输入字符长度
- (void)textFiledEditChanged:(NSNotification *)obj
{
    if ([_nameField isFirstResponder])
    {
        // 限制长度，不包括汉字
        [Util limitIncludeChineseTextField:_nameField Length:limitNameMax];
        /*
         //限制为小写
         NSString *lowercase = [_userNameField.text lowercaseString];
         if (![lowercase isEqualToString:_userNameField.text]) {
         _userNameField.text = lowercase;
         }
         */
    }
    else if ([_psdField isFirstResponder])
    {
        //限制长度，不包括汉字
        [Util limitTextField:_psdField Length:limitPwordMax];
    }
    else if ([_telephoneField isFirstResponder])
    {
        [Util limitTextField:_telephoneField Length:kMax_Phone];
    }
    else if ([_verifyField isFirstResponder])
    {
        [Util limitTextField:_verifyField Length:limitCode];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 0)
    {
        if ([_nameField isFirstResponder])
        {
            // 用户名是否为合法帐号组成
            return ([string isLegalJHSAccountCharacterRegister] ? YES : NO);
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

// 添加结束编辑代理方法
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (!_isBackSuperView)
    {
        // 在当前视图操作时，才需要进行判断处理，否则不判断处理
        if (0 != textField.text.length)
        {
            if (textField == _nameField)
            {
                // 用户名 格式是否符合
                if (limitNameMin > textField.text.length || limitNameMax < textField.text.length)
                {
                    [iToast alertWithTitle:kAlertNameFormat];
                    [_nameField becomeFirstResponder];
                    
                    return NO;
                }
                else
                {
//                    // 网络请求判断用户名是否已被注册
//                    [UserModel determineUniquenessValue:_nameField.text type:@"3" target:self success:^(StatusModel *data) {
//                        if (data.resultStatus == 1)
//                        {
////                            UserModel *userModel = data.list;
////                            if (userModel.isExists != 1)
////                            {
////                                [_nameField becomeFirstResponder];
////                                [iToast alertWithTitle:kAlertNameNotExist];
////                                return ;
////                            }
//                        }
//                    }];
                    
                    return YES;
                }
            }
            else if (textField == _psdField)
            {
                // 密码 格式是否符合
                if (limitPwordMin > textField.text.length || limitPwordMax < textField.text.length)
                {
                    [iToast alertWithTitle:kAlertPwordFormat];
                    [_psdField becomeFirstResponder];
                    
                    return NO;
                }
            }
            else if (textField == _cmtPsdField)
            {
                // 密码 格式是否符合
                if (limitPwordMin > textField.text.length || limitPwordMax < textField.text.length)
                {
                    [iToast alertWithTitle:kAlertPwordFormat];
                    [_cmtPsdField becomeFirstResponder];
                    
                    return NO;
                }
                
                if (![_cmtPsdField.text isEqualToString:_psdField.text])
                {
                    [iToast alertWithTitle:kAlertPwordNotSame];
                    [_cmtPsdField becomeFirstResponder];
                    
                    return NO;
                }
            }
            else if (textField == _telephoneField)
            {
                // 手机号码 格式是否符合
                if (![textField.text isMobile])
                {
                    [iToast alertWithTitle:kAlertMobileFormat];
                    [_telephoneField becomeFirstResponder];
                    
                    return NO;
                }
                else
                {
                    // 网络请求判断手机是否已被注册
//                    [UserModel determineUniquenessValue:_telephoneField.text type:@"2" target:self success:^(StatusModel *data) {
//                        if (data.resultStatus == 1)
//                        {
////                            UserModel *userModel = data.list;
////                            if (userModel.isExists != 1)
////                            {
////                                [_telephoneField becomeFirstResponder];
////                                [iToast alertWithTitle:kAlertMobileNotExist];
////                                return ;
////                            }
//                        }
//                    }];
                    
                    return YES;
                }
            }
            else if (textField == _verifyField)
            {
                // 验证码 格式是否符合
                if (limitCode != textField.text.length)
                {
                    [iToast alertWithTitle:kAlertCodeFormat];
                    [_verifyField becomeFirstResponder];
                    
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

@end
