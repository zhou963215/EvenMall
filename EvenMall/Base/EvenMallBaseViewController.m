//
//  EvenMallBaseViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/6/13.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "EvenMallBaseViewController.h"

@interface EvenMallBaseViewController ()

@end

@implementation EvenMallBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent=NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationView setTitle:self.title];
    if (self.navigationController.viewControllers.count > 1) {
        WEAKSELF(wk);
        
        [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"nav_back"] clickCallBack:^(UIView *view) {
            
            [wk backLastView];
            NSLog(@"返回");
        }];
        
    }
    
    [self.navigationView setNavigationBackgroundColor:[UIColor orangeColor]];
    [self setUpForDismissKeyboard];
}

// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

// 支持竖屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)setUpForDismissKeyboard{
    
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    
    UITapGestureRecognizer * singleTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnywhereToDismissKeyBoard:)];
    
    NSOperationQueue * mainQueue = [NSOperationQueue mainQueue];
    
    WEAKSELF(wk);
    
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        [wk.view addGestureRecognizer:singleTapGR];
    }];
    
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        [wk.view removeGestureRecognizer:singleTapGR];
    }];
    
}


- (void)tapAnywhereToDismissKeyBoard:(UIGestureRecognizer *)gestureRecognizer{
    
    
    [self.view endEditing:YES];
    
}
- (void)backButton{
    
    
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 60, 40);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 46);
    
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
}

- (void)backLastView{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hiddenLeft{
    
    self.navigationItem.leftBarButtonItem = nil;
    
}

- (void)dealloc{
    
    EDULog(@"%@----dealloc",[self class]);
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
