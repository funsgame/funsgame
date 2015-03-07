//
//  RegistVC.m
//  KinHop
//
//  Created by weibin on 14/12/18.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "RegistVC.h"
#import "UserProtocolVC.h"

//#import <SMS_SDK/SMS_SDK.h>
//#import <SMS_SDK/CountryAndAreaCode.h>

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
static NSString *const kAlertNameExist = @"用户名已存在，换一个";
static NSString *const kAlertNameNull = @"请设定一个用户名";

static NSString *const kAlertPwordFormat = @"密码长度为6－20个字符";
static NSString *const kAlertPwordNull = @"请输入密码";

static NSString *const kAlertMobileNull = @"请填写手机号码";
static NSString *const kAlertMobileFormat = @"请填写有效的手机号码";
static NSString *const kAlertMobileExist = @"您的手机号已注册过了，请登录";

static NSString *const kAlertCodeFormat = @"请输入6位验证码";
static NSString *const kAlertCodeError = @"验证码有误，请重新获取";
static NSString *const kAlertCodeNull = @"请输入验证码";

@interface RegistVC ()<UITextFieldDelegate>
{
    UIView *_headView;
    UITextField *_telephoneField;
    UITextField *_nameField;
    UITextField *_psdField;
    UITextField *_verifyField;
    UITextField *_refereeField;           // 推荐人
    
    CountDownButton *_countDownButton;    // 倒计时按钮
    UIButton *_registBtn;
    BOOL _isBackSuperView;
}
@property (nonatomic, strong) UITableView *registTableView;

@end

@implementation RegistVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"注册";
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
    
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:@"登录" imageName:nil target:self action:@selector(loginClick:)];
    
    _registTableView = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), nil, nil, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
    _registTableView.showsVerticalScrollIndicator = NO;
    _registTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _registTableView.backgroundColor = kJHSColorDarkWhite;
    [DataHelper setExtraCellLineHidden:_registTableView];
    
    _headView = InsertView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), kColorClear);
    _registTableView.tableHeaderView = _headView;
    
    UIView *bgView = InsertView(_headView, CGRectMake(0, 0, kScreenWidth, 50 * 5), kColorWhite);

    UILabel *teleLabel = InsertLabel(_headView, CGRectMake(kLeftDis, 0, 50, kHeight), NSTextAlignmentLeft, @"手机号", kFontSize15, kJHSColorBlack, NO);

    _telephoneField = [[MyTextField alloc]initWithFrame:
                      CGRectMake(teleLabel.right + 10, 0, kScreenWidth - 80, kHeight)];
    _telephoneField.delegate = self;
    _telephoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _telephoneField.font = kFontSize15;
    _telephoneField.textColor = kJHSColorBlack;
    _telephoneField.keyboardType = UIKeyboardTypeNumberPad;
    _telephoneField.backgroundColor = kColorWhite;
    _telephoneField.placeholder = @"请输入您的手机号";
    if (ISIOS7) {
        _telephoneField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_telephoneField];
    
    [DataHelper setEmptyLeftViewForTextField:_telephoneField withFrame:CGRectMake(0, 0, 15, _telephoneField.height)];
    
    InsertView(bgView, CGRectMake(kLeftDis, _telephoneField.bottom - kLine, kScreenWidth - kLeftDis, kLine), kJHSColorLightBlack);
    
    UILabel *nameLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _telephoneField.bottom, 50, kHeight), NSTextAlignmentLeft, @"用户名", kFontSize15, kJHSColorBlack, NO);
    
    _nameField = [[MyTextField alloc]initWithFrame:
                     CGRectMake(nameLabel.right + 10, _telephoneField.bottom, kScreenWidth - 80, kHeight)];
    _nameField.delegate = self;
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameField.font = kFontSize15;
    _nameField.textColor = kJHSColorBlack;
    _nameField.keyboardType = UIKeyboardTypeASCIICapable;
    _nameField.backgroundColor = kColorWhite;
    _nameField.placeholder = @"6-20个字符";
    if (ISIOS7) {
        _nameField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_nameField];
    
    [DataHelper setEmptyLeftViewForTextField:_nameField withFrame:CGRectMake(0, 0, 15, _nameField.height)];
    
    InsertView(bgView, CGRectMake(kLeftDis, _nameField.bottom - kLine, kScreenWidth - kLeftDis, kLine), kJHSColorLightBlack);
    
    UILabel *psdLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _nameField.bottom, 50, kHeight), NSTextAlignmentLeft, @"密码", kFontSize15, kJHSColorBlack, NO);
    
    _psdField = [[MyTextField alloc]initWithFrame:
                  CGRectMake(psdLabel.right + 10, _nameField.bottom, kScreenWidth - 80, kHeight)];
    
    _psdField.delegate = self;
    _psdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _psdField.font = kFontSize15;
    _psdField.textColor = kJHSColorBlack;
    _psdField.keyboardType = UIKeyboardTypeASCIICapable;
    _psdField.backgroundColor = kColorWhite;
    _psdField.placeholder = @"请输入密码";
    _psdField.secureTextEntry = YES;
    if (ISIOS7) {
        _psdField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_psdField];
    
    [DataHelper setEmptyLeftViewForTextField:_psdField withFrame:CGRectMake(0, 0, 15, _psdField.height)];
    
    InsertView(bgView, CGRectMake(kLeftDis, _psdField.bottom - kLine, kScreenWidth - kLeftDis, kLine), kJHSColorLightBlack);

    UILabel *veriLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _psdField.bottom, 50, kHeight), NSTextAlignmentLeft, @"验证码", kFontSize15, kJHSColorBlack, NO);

    _verifyField = [[MyTextField alloc]initWithFrame:
                 CGRectMake(veriLabel.right + 10, _psdField.bottom, 140, kHeight)];
    
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
    
    [DataHelper setEmptyLeftViewForTextField:_verifyField withFrame:CGRectMake(0, 0, 15, _verifyField.height)];
    
    // 倒计时
    _countDownButton = [CountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownButton.frame = CGRectMake(220, _verifyField.top + 8, 90, 34);

    _countDownButton.normalTitle = @"发送验证码";
    kSelfWeak;
    _countDownButton.buttonClickedBlock = ^{
        [weakSelf sendPostToGetValidateCode];
    };
    [bgView addSubview:_countDownButton];
    
    InsertView(bgView, CGRectMake(kLeftDis, _verifyField.bottom - kLine, kScreenWidth - kLeftDis, kLine), kJHSColorLightBlack);
    
    UILabel *refereeLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _verifyField.bottom, 50, kHeight), NSTextAlignmentLeft, @"推荐人", kFontSize15, kJHSColorBlack, NO);

    _refereeField = [[MyTextField alloc]initWithFrame:
                    CGRectMake(refereeLabel.right + 10, _verifyField.bottom, kScreenWidth - 80, kHeight)];
    _refereeField.delegate = self;
    _refereeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _refereeField.font = kFontSize15;
    _refereeField.textColor = kJHSColorBlack;
    _refereeField.keyboardType = UIKeyboardTypeASCIICapable;
    _refereeField.backgroundColor = kColorWhite;
    _refereeField.placeholder = @"推荐人用户名(选填)";
    if (ISIOS7) {
        _verifyField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_refereeField];
    
    [DataHelper setEmptyLeftViewForTextField:_refereeField withFrame:CGRectMake(0, 0, 15, _refereeField.height)];
    
     _registBtn = InsertButtonRoundedRect(_headView, CGRectMake(14, bgView.bottom + 20, kScreenWidth - 28, 44), 99, @"注册", self, @selector(registClick:));
    
    _registBtn.titleLabel.font = kFontSizeBold18;
    [_registBtn setTitleColor: kColorWhite forState:UIControlStateNormal];
    [_registBtn setBackgroundColor:kJHSColorRed];
    _registBtn.layer.cornerRadius = 3;
    _registBtn.clipsToBounds = YES;
    
    UILabel *bottomLabel = InsertLabel(_headView, CGRectMake(25, _registBtn.bottom + 10, 100, 20), NSTextAlignmentLeft, @"点击注册即同意", kFontSize12, kColorBlack, NO);
    
    UIButton *bottomBtn = InsertButtonRoundedRect(_headView, CGRectMake(bottomLabel.right - 20, bottomLabel.top + 1, 120, 20), 99, @"《金合社用户协议》", self, nil);
    
    bottomBtn.titleLabel.font = kFontSize12;
    
    InsertButtonRoundedRect(_headView, CGRectMake(25, _registBtn.bottom + 5, kScreenWidth - 100, 30), 100, nil, self, @selector(bottomClick:));
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];

}

- (void)loginClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registClick:(UIButton *)sender
{
    if (![self checkInfo])
    {
        return;
    }
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
    
    return YES;
}

- (void)bottomClick:(UIButton *)sender
{
    UserProtocolVC *vc = [[UserProtocolVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 发送请求获取验证码
- (void)sendPostToGetValidateCode
{
//shareSDK短信验证码
//    [SMS_SDK getVerificationCodeBySMSWithPhone:_telephoneField.text
//                                          zone:@"86"
//                                        result:^(SMS_SDKError *error)
//     {
//         if (!error)
//         {
//             //             [self presentViewController:verify animated:YES completion:^{
//             //                 ;
//             //             }];
//         }
//         else
//         {
//             UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
//                                                           message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
//                                                          delegate:self
//                                                 cancelButtonTitle:NSLocalizedString(@"sure", nil)
//                                                 otherButtonTitles:nil, nil];
//             [alert show];
//         }
//         
//     }];
//
    [self.view endEditing:YES];
    
    // 判断手机号码
    if (![self checkIsPhoneNumber:_telephoneField.text])
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

// 检测输入的是否为手机号码
- (BOOL)checkIsPhoneNumber:(NSString *)phoneNumber
{
    if ([NSString isNull:phoneNumber])
    {
        [iToast alertWithTitle:kAlertMobileNull];
        return NO;
    }
    else if (![phoneNumber isMobile])
    {
        [iToast alertWithTitle:kAlertMobileFormat];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)loadFinishForSMS:(StatusModel *)data
{
//    [SVProgressHUD dismiss];
//    if (1 == data.resultStatus) {
////        int isExists = ((UserModel *)data.list).isExists;
////        if (isExists == 1) {
////            [iToast alertWithTitle:kAlertMobileExist];
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
            if([string isSpacialCharacter])
            {
                [iToast alertWithTitle:kAlertNameSpecial];
                return NO;
            }
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
                    // 网络请求判断是否已被注册
//                    [UserModel determineUniquenessValue:_nameField.text type:@"3" target:self success:^(StatusModel *data) {
//                        if (data.resultStatus == 1)
//                        {
////                            UserModel *userModel = data.list;
////                            if (userModel.isExists == 1)
////                            {
////                                [_nameField becomeFirstResponder];
////                                [iToast alertWithTitle:kAlertNameExist];
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
            else if (textField == _telephoneField)
            {
                // 手机号码 格式是否符合
                if (![textField.text isMobile])
                {
                    [iToast alertWithTitle:kAlertMobileFormat];
                    [_telephoneField becomeFirstResponder];
                    
                    return NO;
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
