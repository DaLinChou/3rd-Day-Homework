//
//  ViewController.m
//  0709_UI_BaseViewController
//
//  Created by rimi on 15/7/9.
//  Copyright (c) 2015年 周林. All rights reserved.
//

#import "ViewController.h"
#import "IntroduceViewController.h"
@interface ViewController () <UITextFieldDelegate>
{
    UITextField * _accountText;
    UITextField * _passwordText;
    UIButton * _loginButton;
}
- (void) initializeUserInterface;

@end

@implementation ViewController

#pragma mark - 声明周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUserInterface];
}
/* 即将显示清空账号和密码框 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _accountText.text = @"";
    _passwordText.text = @"";
}

#pragma mark - 初始化用户界面
- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor colorWithRed:27 / 255.0 green:207 / 255.0 blue:204 / 255.0 alpha:1];
#pragma mark UIImageView
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.bounds = CGRectMake(0, 0, 120, 120);
    imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 150);
    // 设置图片视图的背景颜色
    imageView.backgroundColor = [UIColor grayColor];
    imageView.image = [UIImage imageNamed:@"headImage"];
    // 设置圆角
    imageView.layer.cornerRadius = 60;
    // 超出视图部分不显示
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
    
#pragma mark UITextFieldView
    // 账号文本框
    _accountText = [[UITextField alloc]init];
    _accountText.bounds = CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds), 30);
    _accountText.center = CGPointMake(CGRectGetMidX(_accountText.bounds), CGRectGetMaxY(imageView.frame) + 100);
    _accountText.placeholder = @"请输入QQ号/手机号/邮箱";
    _accountText.textAlignment = NSTextAlignmentCenter;
    [_accountText.layer setBorderColor:[UIColor blackColor].CGColor];
    [_accountText.layer setBorderWidth:0.251];
    _accountText.alpha = 0.5;
    _accountText.delegate = self;
    // 设置清除按钮显示时间
    _accountText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountText.returnKeyType = UIReturnKeyGo;
    [self.view addSubview:_accountText];
    
    // 密码文本框
    _passwordText = [[UITextField alloc]init];
    _passwordText.bounds = CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds), 30);
    _passwordText.center = CGPointMake(CGRectGetMidX(_accountText.bounds), CGRectGetMaxY(_accountText.frame) + 15);
    _passwordText.placeholder = @"密码";
    _passwordText.textAlignment = NSTextAlignmentCenter;
    [_passwordText.layer setBorderColor:[UIColor blackColor].CGColor];
    [_passwordText.layer setBorderWidth:0.251];
    _passwordText.alpha = 0.5;
    _passwordText.secureTextEntry = YES;
    _passwordText.delegate = self;
    _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordText.returnKeyType = UIReturnKeyGo;
    [self.view addSubview:_passwordText];
    
#pragma mark UIButton 
    // 登录按钮
    _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginButton.bounds = CGRectMake(0, 0, CGRectGetMidX(self.view.bounds), 30);
    _loginButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(_passwordText.frame) + 50);
    _loginButton.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:112 / 255.0 blue:253 / 255.0 alpha:1];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTintColor:[UIColor whiteColor]];
    [_loginButton addTarget:self action:@selector(respondsToButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
}

#pragma mark - responds event

- (void) respondsToButton : (UIButton *) sender {
    // 处理账号密码
    [self handleAccountAndPassword];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // 点return可登录
    [textField resignFirstResponder];
    [self handleAccountAndPassword];
    return YES;
}


#pragma mark - touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 触摸屏幕收回键盘
    [self.view endEditing:YES];
}

- (void)handleAccountAndPassword {
    if ([_accountText.text isEqualToString: @"admin"] && [_passwordText.text isEqualToString: @"123456"]) {
        // 密码正确则进入另一个视图
        IntroduceViewController * introduce_vc = [[IntroduceViewController alloc]init];
        
        [introduce_vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        
        [self presentViewController:introduce_vc animated:YES completion:nil];
    }
    // 未输入密码提示
    else if ([_accountText.text isEqualToString:@""] || [_passwordText.text isEqualToString:@"" ]){
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入账号或密码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        _accountText.text = @"";
        _passwordText.text = @"";
        
    } else {
        // 密码或账号错误提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"账号或密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        _accountText.text = @"";
        _passwordText.text = @"";
    }
}
@end
