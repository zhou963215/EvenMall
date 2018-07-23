//
//  EDULoginFiledView.m
//  Xuechuanedu
//
//  Created by xuechuan on 2018/4/17.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import "EDULoginFiledView.h"
#import "CountdownBtn.h"
@interface EDULoginFiledView()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView * leftView;

@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, strong) UIButton * secretBtn;

@property (nonatomic, strong) CountdownBtn * countdownBtn;


@end

@implementation EDULoginFiledView


- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = RGB(244, 245, 246);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    
    return self;
}



- (void)setStyle:(FieldStyle)style{
    
    _style = style;
    
    switch (_style) {
        case DEFAULT:
            [self defaultView];
            break;
        case SECRET:
            [self secretView];
            break;
        case VCLIDATION:
            [self vclidationView];
            break;
        default:
            break;
    }
    
}
- (void)setIsSecret:(BOOL)isSecret{
    
    _isSecret = isSecret;
    _secretBtn.selected = !isSecret;
    self.textField.secureTextEntry = _isSecret;
    self.textField.clearsOnBeginEditing = NO;
}

- (void)setLeftImage:(UIImage *)leftImage{
    
    _leftImage = leftImage;
    
    self.leftView.image = _leftImage;
    
    
}

- (void)setPlacehold:(NSString *)placehold{
    
    _placehold = placehold ;
    self.textField.placeholder = _placehold;
    
}

- (void)defaultView{
    
    [self addSubview:self.leftView];
    [self addSubview:self.textField];
    
    WEAKSELF(wk);
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(10);
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(wk);
        
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.leftView.mas_right).offset(10);
        make.centerY.height.equalTo(wk);
        make.right.equalTo(wk).offset(-10);
        
    }];
    
}

- (void)secretView{
    
    [self addSubview:self.leftView];
    [self addSubview:self.textField];
    [self addSubview:self.secretBtn];
    WEAKSELF(wk);
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(10);
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(wk);
        
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.leftView.mas_right).offset(10);
        make.centerY.height.equalTo(wk);
        make.right.equalTo(wk.secretBtn).offset(10);
        
    }];
    
    [_secretBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(wk).offset(-10);
        make.top.bottom.equalTo(wk);
        make.width.mas_equalTo(@44);
    }];
    
}

- (void)vclidationView{
    
    
    [self addSubview:self.leftView];
    [self addSubview:self.textField];
    [self addSubview:self.countdownBtn];
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    WEAKSELF(wk);
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(10);
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(wk);
        
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.leftView.mas_right).offset(10);
        make.centerY.height.equalTo(wk);
        make.right.equalTo(lineView.mas_left).offset(-10);
        
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(1, 22));
        make.centerY.equalTo(wk);
        make.right.equalTo(wk.countdownBtn.mas_left).offset(-1);
        
    }];
   
    [_countdownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(120, 44));
        make.right.equalTo(wk);
        make.centerY.equalTo(wk);
        
    }];
    
    
}

- (UIImageView *)leftView{
    
    if (!_leftView) {
        
        _leftView = [[UIImageView alloc]init];
        
    }
    
    return _leftView;
}

- (UIButton *)secretBtn{
    
    if (!_secretBtn) {
        
        _secretBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_secretBtn setImage:[UIImage imageNamed:@"l_eyeable"] forState:UIControlStateNormal];
        [_secretBtn setImage:[UIImage imageNamed:@"l_s_eyeable"] forState:UIControlStateSelected];
        [_secretBtn addTarget:self action:@selector(secretSwitch:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return _secretBtn;
}

- (UITextField *)textField{
    
    if (!_textField) {
        
        _textField = [[UITextField alloc]init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = RGB(54, 61, 68);
        _textField.delegate = self;
        
    }
    
    return _textField;
}

- (CountdownBtn * )countdownBtn{
    
    if (!_countdownBtn) {
        _countdownBtn = [CountdownBtn countdownButton];
        _countdownBtn.title = @"发送验证码";
        _countdownBtn.titleLabelFont = [UIFont systemFontOfSize:14];
        [_countdownBtn setTitleColor:RGB(251, 89, 91) forState:UIControlStateNormal]; ;
        _countdownBtn.nomalBackgroundColor =  RGB(244, 245, 246);
        _countdownBtn.disabledBackgroundColor = RGB(244, 245, 246);
        _countdownBtn.totalSecond = 60;
        [_countdownBtn addTarget:self action:@selector(countdownClick) forControlEvents:UIControlEventTouchUpInside];
        WEAKSELF(wk)
        [_countdownBtn processBlock:^(NSUInteger second) {
            
            [wk.countdownBtn setTitleColor:RGB(195, 201, 208) forState:UIControlStateNormal]; ;
            wk.countdownBtn.title = [NSString stringWithFormat:@"重发  ( %lis )", second] ;
        } onFinishedBlock:^(BOOL finish){  // 倒计时完毕
            
            [wk.countdownBtn setTitleColor:RGB(251, 89, 91) forState:UIControlStateNormal]; ;
            wk.countdownBtn.title = @"获取验证码";
        }];
    }
    return _countdownBtn;
}
//密码可见切换
- (void)secretSwitch:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    self.textField.secureTextEntry = !self.textField.secureTextEntry;
    
}
//发送验证码

- (void)countdownClick{
    
//    [self.navigationController.view endEditing:YES];
    
    [self.textField becomeFirstResponder];
    NSLog(@"发送验证码----%@",self.phone);
    
    if (self.phone.length !=11) {

        [_countdownBtn stopTime];
        [ZHHud initWithMessage:@"请输入正确的手机号码"];
        return;
    }
//
//    NSString * usetype = _type == 1 ? @"reg" :@"retrieve";
    
   
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    self.value = textField.text;
    if (self.endEditBlock) {
        
        self.endEditBlock(self.value);
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.changTextBlock) {
        
        self.changTextBlock(range.location);
    }
    
    
    
    return YES;
}


@end
