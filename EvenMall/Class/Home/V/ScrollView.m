//
//  ScrollView.m
//  仿头条滑动切换视图
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ScrollView.h"
#import "UIView+XMGExtension.h"

#import "HomeTypeModel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define BtnWidth ScreenWidth/_headArray.count

@implementation ScrollView

-(instancetype)init{
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
//        self.headArray = @[@"头条",@"娱乐",@"体育",@"上海",@"美女",@"社会",@"百度"];
        
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

-(void)setHeadArray:(NSMutableArray *)headArray{
    
    
    _headArray = headArray;
    HomeTypeDetailModel * model = [[HomeTypeDetailModel alloc]init];
    model.catName = @"热门";
    model.catId = @"0";
    
    
    [self createScrollSubView:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

}


-(void)createScrollSubView:(CGRect)frame{
    //滑动视图的颜色
    self.backgroundColor = [UIColor whiteColor];
    //滑动区域
//    self.contentSize = CGSizeMake(BtnWidth * _headArray.count, 0);
    //防止滑动时弹跳
//    self.bounces = NO;
    
    // 底部的红色指示器
    _indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = UICOLORRGB(0xfb595b);
    _indicatorView.height = 2;
    _indicatorView.tag = -1;
    _indicatorView.y = 33;
    [self createBtn];

    [self addSubview:_indicatorView];
    
   
}




#pragma amrk -循环创建button
-(void)createBtn{
    
    
    
    float butX = 0;
    float w = 87.5;
    for (int i=0; i<_headArray.count; i++) {
        
    
  
        HomeTypeDetailModel * model = _headArray[i];
        NSString *  str = model.catName;
      
        
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGRect frame_W = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(butX, 0, w, 40);
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:str forState:UIControlStateNormal];
        [button setTitleColor:UICOLORRGB(0x8d98a3) forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:UICOLORRGB(0x363d44) forState:UIControlStateNormal];
            
            [button.titleLabel sizeToFit];
            _indicatorView.width = frame_W.size.width/2;
            _indicatorView.centerX = button.center.x;
            [self buttonAction:button];
        }

        button.tag = i + 1000;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        butX +=w+10;
        [self addSubview:button];
    }
    self.contentSize = CGSizeMake(butX+10, 0);
}

-(void)buttonAction:(UIButton *)button{
    //获取button的tag
    _currentBtn = (int)button.tag-1000;
    //调用点击改变字体颜色的方法
    [self changeBtntitleColorWith:(int)(button.tag - 1000)];
    //代理方法
    if ([self.SeletedDelegate respondsToSelector:@selector(seletedControllerWith:)]) {
        [self.SeletedDelegate seletedControllerWith:button];
    }
}

-(void)changeBtntitleColorWith:(int)tag{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {//判断该subViews是否是button
            //是
            if (obj.tag == tag) {//subViews的tag与按钮的tag一样
                
                float offsetX = obj.centerX - self.bounds.size.width * 0.5;
                
                if (offsetX  < 0) {
                    
                    offsetX = 0 ;
                }
                if (offsetX > (self.contentSize.width - self.bounds.size.width)) {
                    
                    offsetX =  self.contentSize.width - self.bounds.size.width;
                }
                
                //改变颜色
                [obj setTitleColor:UICOLORRGB(0x363d44) forState:UIControlStateNormal];
                // 动画
                [UIView animateWithDuration:0.1 animations:^{
                    self.indicatorView.width = obj.titleLabel.frame.size.width/2;
                    self.indicatorView.centerX = obj.center.x;
                    [self setContentOffset:CGPointMake(offsetX, 0)];
                }];

                //----------------------------
                if (obj.frame.origin.x < ScreenWidth/2) {
                    [UIView animateWithDuration:0.5 animations:^{
                        [UIView animateWithDuration:0.25 animations:^{
                            self.indicatorView.width = obj.titleLabel.frame.size.width/2;
                            self.indicatorView.centerX = obj.center.x;
                        }];
                    }];
                }
                //----------------------------
                
                
                
                
                
            }else{//如果obj.tag != tag
                [obj setTitleColor:UICOLORRGB(0x8d98a3) forState:UIControlStateNormal];
                obj.titleLabel.font = [UIFont systemFontOfSize:16];
            }
        }
    }];
}


@end
