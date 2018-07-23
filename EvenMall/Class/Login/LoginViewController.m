//
//  LoginViewController.m
//  EvenMall
//
//  Created by zhou on 2018/6/26.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "LoginViewController.h"
#import <WXApi.h>
#import "CountdownBtn.h"
#import "EDULoginFiledView.h"

@interface LoginViewController ()<UITextFieldDelegate>


@property (nonatomic, strong) UIButton * submitBtn;


@property (nonatomic, strong) EDULoginFiledView * userView;

@property (nonatomic, strong) EDULoginFiledView * messageCodeView;





@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView.titleLabel.text = @"登录";
    [self creatSubViews];
 
    
  

}





- (void)creatSubViews{
    
    
    WEAKSELF(wk);
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk.navigationView.mas_bottom).offset(100);
        make.height.mas_equalTo(@44);
        make.left.equalTo(wk.view).offset(37.5);
        make.right.equalTo(wk.view).offset(-37.5);
    }];
    
    [self.messageCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(wk.userView);
        make.top.equalTo(wk.userView.mas_bottom).offset(30);
        
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(wk.userView);
        make.top.equalTo(wk.messageCodeView.mas_bottom).offset(30);
    }];
   
  
}




//登录

- (void)submitLogin{
    
    [self.view endEditing:YES];
    
   
    
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}





-(EDULoginFiledView *)userView{
    
    if (!_userView) {
        
        _userView = [[EDULoginFiledView alloc]init];
        _userView.leftImage = [UIImage imageNamed:@"l_phone"];
        _userView.style = 0;
        _userView.placehold = @"请输入手机号码";
        WEAKSELF(wk);
      
        [self.view addSubview:_userView];
        _userView.endEditBlock = ^(NSString * phone) {
            
            wk.messageCodeView.phone = phone;
        };
    }
    
    return _userView;
}

- (EDULoginFiledView *)messageCodeView{
    
    if (!_messageCodeView) {
        
        _messageCodeView = [[EDULoginFiledView alloc]init];
        _messageCodeView.leftImage = [UIImage imageNamed:@"l_code"];
        _messageCodeView.style = VCLIDATION;
        _messageCodeView.placehold = @"验证码";
        [self.view addSubview:_messageCodeView];
        
        
    }
    return _messageCodeView;
}




- (UIButton *)submitBtn{
    
    
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"登录" forState:UIControlStateNormal];
        _submitBtn.enabled = NO;
        [_submitBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_submitBtn setBackgroundColor:UICOLORRGB(0xc3c9d0)];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(submitLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitBtn];
        
    }
    
    return _submitBtn;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
