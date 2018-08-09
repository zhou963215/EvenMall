//
//  LoginNewViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/8/6.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "LoginNewViewController.h"
#import "CountdownBtn.h"

#import "PersonalInformationModel.h"
@interface LoginNewViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet CountdownBtn *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreedBtn;

@end

@implementation LoginNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationView.hidden = YES;
    _codeBtn.totalSecond = 60;
    [_codeBtn addTarget:self action:@selector(countdownClick) forControlEvents:UIControlEventTouchUpInside];
    WEAKSELF(wk)
    [_codeBtn processBlock:^(NSUInteger second) {
        [wk.codeBtn setBackgroundImage:[UIImage imageNamed:@"login_yzm_n"] forState:UIControlStateNormal];
        wk.codeBtn.title = [NSString stringWithFormat:@"重发  ( %lis )", second] ;
    } onFinishedBlock:^(BOOL finish){  // 倒计时完毕
        
        [wk.codeBtn setBackgroundImage:[UIImage imageNamed:@"login_yzm_s"] forState:UIControlStateNormal];
        wk.codeBtn.title = @"获取验证码";
    }];


}


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
   
    
    
}

- (void)countdownClick{
    
    [self.view endEditing:YES];
    
    if (_phoneTF.text.length!=11) {
        
        [_codeBtn stopTime];
        [_codeBtn setBackgroundImage:[UIImage imageNamed:@"login_yzm_n"] forState:UIControlStateNormal];

        [ZHHud initWithMessage:@"请输入正确手机号码"];
    }
    [[ZHNetWorking sharedZHNetWorking]POSTAES:9001 parameters:@{@"phone" : @"18625986891"} success:^(id  _Nonnull responseObject) {
        
        
        NSDictionary * dict =responseObject;
        
        if ([dict[@"resultCode"]intValue] == 200) {
            
            
            [ZHHud initWithMessage:@"发送成功"];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        
        
    }];
    
}




-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _phoneTF) {
        
        if (range.location>9 && string.length>0) {
            
            _codeBtn.enabled  = YES;
            [_codeBtn setBackgroundImage:[UIImage imageNamed:@"login_yzm_s"] forState:UIControlStateNormal];
            
        }else{
            
            _codeBtn.enabled  = NO;

            [_codeBtn setBackgroundImage:[UIImage imageNamed:@"login_yzm_n"] forState:UIControlStateNormal];

        }
        
        
    }
    if (textField ==_codeTF&&_phoneTF.text.length == 11) {
        
        if (range.location>4&&string.length>0) {
            
            _loginBtn.enabled = YES;
            [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_submt_s"] forState:UIControlStateNormal];
            
        }else{
            
            _loginBtn.enabled = NO;
            [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_submit_n"] forState:UIControlStateNormal];
        }
        
     
        
        
    }
    
    
   
    return YES;
}





- (IBAction)loginClick:(id)sender {
    
    [self.view endEditing:YES];
    
    
    if (self.phoneTF.text.length !=11) {
        
        
        [ZHHud initWithMessage:@"请输入正确的手机号码"];
        return;
    }
    if (self.codeTF.text.length <3) {
        
        
        [ZHHud initWithMessage:@"请输入正确的验证码"];
        return;
    }
    
    
    
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTAES:2005 parameters:@{@"phone" : self.phoneTF.text, @"smsCode" : self.codeTF.text} success:^(id  _Nonnull responseObject) {
        

        
        NSLog(@"%@",responseObject);
        PersonalInformationModel * model = [PersonalInformationModel modelWithDictionary:responseObject];
        [PublicVoid userDefaultsWith:@"token" value:model.data.token];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
        
    }];
    
    
    
    
}
- (IBAction)deledateClick:(id)sender {
    
    
}
- (IBAction)agreedClick:(id)sender {
    
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
