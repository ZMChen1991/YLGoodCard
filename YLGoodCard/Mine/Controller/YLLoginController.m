//
//  YLLoginController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLoginController.h"
#import "YLCondition.h"

@interface YLLoginController ()

@end

@implementation YLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    float width = self.view.frame.size.width - 2 * YLLeftMargin;
    UILabel *attention = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, YLLeftMargin + 64, width, 17)];
    attention.textColor = [UIColor grayColor];
    attention.text = @"无需注册，输入手机号码即可登录";
    attention.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:attention];
    
    UITextField *tel = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(attention.frame) + 5, width, 40)];
    tel.font = [UIFont systemFontOfSize:14];
    tel.placeholder = @"请输入您的手机号码";
    tel.layer.cornerRadius = 5;
    tel.layer.borderWidth = 0.6;
    tel.layer.borderColor = [UIColor grayColor].CGColor;
    tel.layer.masksToBounds = YES;
    [self.view addSubview:tel];
    
    UITextField *message = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(tel.frame) + YLTopMargin, width, 40)];
    message.font = [UIFont systemFontOfSize:14];
    message.placeholder = @"请输入您的短信验证码";
    message.layer.cornerRadius = 5;
    message.layer.borderWidth = 0.6;
    message.layer.borderColor = [UIColor grayColor].CGColor;
    message.layer.masksToBounds = YES;
    [self.view addSubview:message];

    YLCondition *loginBtn = [[YLCondition alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(message.frame) + YLTopMargin, width, 40)];
    loginBtn.type = YLConditionTypeBlue;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin,  CGRectGetMaxY(loginBtn.frame) + YLTopMargin, width, 17)];
    NSString *str = @"登录即视为同意《用户使用协议》及《隐私权条款》";
    NSAttributedString *str1 = [str changeString:@"《用户使用协议》及《隐私权条款》" color:YLColor(8.f, 169.f, 255.f)];
    text.attributedText = str1;
    text.font = [UIFont systemFontOfSize:12];
    text.textAlignment = NSTextAlignmentCenter;
//    text.backgroundColor = [UIColor redColor];
    [self.view addSubview:text];
}

- (void)login {
    
    
}

@end
