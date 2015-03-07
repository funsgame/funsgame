//
//  LoginVC.m
//  KinHop
//
//  Created by weibin on 14/12/18.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC.h"
#import "FindBackPsdVC.h"

#define kLeftDis 20
#define kHeight 50
#define kLine 0.5

// 字数常量
static NSInteger const limitNameMin = 6;
static NSInteger const limitNameMax = 20;
static NSInteger const limitPwordMin = 6;
static NSInteger const limitPwordMax = 20;

// 异常提示语
static NSString *const kAlertNameFormat = @"手机号或用户名格式不对";
static NSString *const kAlertNameNull = @"请填写手机号或用户名";
static NSString *const kAlertNameSpecial = @"暂不支持特殊符号";

static NSString *const kAlertPwordFormat = @"密码长度为6－20个字符";
static NSString *const kAlertPwordNull = @"请输入密码";

@interface LoginVC ()<UITextFieldDelegate>
{
    UIView *_headView;
    UITextField *_nameTextField;
    UITextField *_psdTextField;
    
    BOOL _isBackSuperView;
}
@property (nonatomic, strong) UITableView *loginTableView;

@end

@implementation LoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"登录";
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
    
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:@"注册" imageName:nil target:self action:@selector(registClick:)];
    
    _loginTableView = InsertTableView(self.view, CGRectMake(0, 16, kScreenWidth, kAllHeight), nil, nil, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
    _loginTableView.showsVerticalScrollIndicator = NO;
    _loginTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _loginTableView.backgroundColor = kJHSColorDarkWhite;
    [DataHelper setExtraCellLineHidden:_loginTableView];
    
    _headView = InsertView(self.view, CGRectMake(0, 0, kScreenWidth, 240), kColorClear);
    _loginTableView.tableHeaderView = _headView;
    
    UIView *bgView = InsertView(_headView, CGRectMake(0, 0, kScreenWidth, 101), kColorWhite);
    
    UILabel *nameLabel = InsertLabel(_headView, CGRectMake(kLeftDis, 0, 30, kHeight), NSTextAlignmentLeft, @"账号", kFontSize15, kJHSColorBlack, NO);
    
    _nameTextField = [[MyTextField alloc]initWithFrame:
                         CGRectMake(nameLabel.right + 10, 0, kScreenWidth - 60, kHeight)];
    _nameTextField.delegate = self;
    _nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameTextField.font = kFontSize15;
    _nameTextField.textColor = kJHSColorBlack;
    _nameTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _nameTextField.backgroundColor = kColorWhite;
    _nameTextField.placeholder = @"手机号 / 用户名";
    if (ISIOS7) {
        _nameTextField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_nameTextField];
    
    [DataHelper setEmptyLeftViewForTextField:_nameTextField withFrame:CGRectMake(0, 0, 15, _nameTextField.height)];
    
    InsertView(bgView, CGRectMake(kLeftDis, _nameTextField.bottom - kLine, kScreenWidth - 10, kLine), kJHSColorLightBlack);
    
    UILabel *pswLabel = InsertLabel(_headView, CGRectMake(kLeftDis, _nameTextField.bottom, 30, kHeight), NSTextAlignmentLeft, @"密码", kFontSize15, kJHSColorBlack, NO);

    _psdTextField = [[MyTextField alloc]initWithFrame:
                      CGRectMake(pswLabel.right + 10, _nameTextField.bottom, kScreenWidth - 60, kHeight)];
    
    _psdTextField.delegate = self;
    _psdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _psdTextField.font = kFontSize15;
    _psdTextField.textColor = kJHSColorBlack;
    _psdTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _psdTextField.backgroundColor = kColorWhite;
    _psdTextField.placeholder = @"请输入密码";
    _psdTextField.secureTextEntry = YES;
    if (ISIOS7) {
        _psdTextField.tintColor = kJHSColorBlack;
    }
    [bgView addSubview:_psdTextField];
    
    [DataHelper setEmptyLeftViewForTextField:_psdTextField withFrame:CGRectMake(0, 0, 15, _psdTextField.height)];
    
    UIButton *loginBtn = InsertButtonRoundedRect(_headView, CGRectMake(14, bgView.bottom + 20, kScreenWidth - 28, 50), 99, @"登录", self, @selector(loginClick:));
    
    loginBtn.titleLabel.font = kFontSizeBold18;
    [loginBtn setTitleColor: kColorWhite forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:kJHSColorRed];
    loginBtn.layer.cornerRadius = 3;
    loginBtn.clipsToBounds = YES;
    
    UIButton *forgetBtn = InsertButtonRoundedRect(_headView, CGRectMake(kScreenWidth - 80, loginBtn.bottom + 15, 60, 20), 99, @"忘记密码", self, @selector(forgetClick:));
    
    forgetBtn.titleLabel.font = kFontSize12;
    [forgetBtn setTitleColor:kColorBlue forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)registClick:(UIButton *)sender
{
    RegistVC *vc = [[RegistVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginClick:(UIButton *)sender
{
    if (![self checkInfo])
    {
        return;
    }
}

- (BOOL)checkInfo
{
    if ([NSString isNull:_nameTextField.text])
    {
        [iToast alertWithTitle:kAlertNameNull];
        [_nameTextField becomeFirstResponder];
        return NO;
    }
    
    if ([NSString isNull:_psdTextField.text])
    {
        [iToast alertWithTitle:kAlertPwordNull];
        [_psdTextField becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)forgetClick:(UIButton *)sender
{
    FindBackPsdVC *vc = [[FindBackPsdVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITextField delegate
// 限制输入字符长度
- (void)textFiledEditChanged:(NSNotification *)obj
{
    if ([_nameTextField isFirstResponder])
    {
        // 限制长度，不包括汉字
        [Util limitIncludeChineseTextField:_nameTextField Length:limitNameMax];
        /*
         //限制为小写
         NSString *lowercase = [_userNameField.text lowercaseString];
         if (![lowercase isEqualToString:_userNameField.text]) {
         _userNameField.text = lowercase;
         }
         */
    }
    else if ([_psdTextField isFirstResponder])
    {
        //限制长度，不包括汉字
        [Util limitTextField:_psdTextField Length:limitPwordMax];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 0)
    {
        if ([_nameTextField isFirstResponder])
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
    [_nameTextField resignFirstResponder];
    [_psdTextField resignFirstResponder];
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
            if (textField == _nameTextField)
            {
                // 用户名 格式是否符合
                if (limitNameMin > textField.text.length || limitNameMax < textField.text.length)
                {
                    [iToast alertWithTitle:kAlertNameFormat];
                    [_nameTextField becomeFirstResponder];
                    
                    return NO;
                }
            }
            else if (textField == _psdTextField)
            {
                // 密码 格式是否符合
                if (limitPwordMin > textField.text.length || limitPwordMax < textField.text.length)
                {
                    [iToast alertWithTitle:kAlertPwordFormat];
                    [_psdTextField becomeFirstResponder];
                    
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

@end
