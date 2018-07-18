//
//  HomeListModel.h
//  EvenMall
//
//  Created by xuechuan on 2018/7/16.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "EvenMallBaseModel.h"



@interface HomeListBannerModel : NSObject

@property (nonatomic, copy) NSString * banner_cat;

@property (nonatomic, copy) NSString * banner_id;

@property (nonatomic, copy) NSString * banner_img;

@property (nonatomic, copy) NSString * banner_orrder;

@property (nonatomic, assign) NSInteger  banner_type;

@property (nonatomic, copy) NSString * cre_time;

@property (nonatomic, copy) NSString * goods_id;

@property (nonatomic, copy) NSString * web_url;


@end


@interface HomeListCategoryModel : NSObject

@property (nonatomic, copy) NSString * catCode;

@property (nonatomic, copy) NSString * catId;

@property (nonatomic, copy) NSString * catName;

@property (nonatomic, copy) NSString * cre_time;

@property (nonatomic, copy) NSArray * goodsList;

@property (nonatomic, copy) NSString * parCatid;

@property (nonatomic, assign) NSInteger index;

@end


@interface HomeListGoodsModel : NSObject

@property (nonatomic, copy) NSString * goodsId;

@property (nonatomic, assign) NSInteger  goodsNum;

@property (nonatomic, copy) NSString * marketPrice;

@property (nonatomic, copy) NSString * goodsThumbnail;

@property (nonatomic, copy) NSString * goodAdPic;

@property (nonatomic, copy) NSString * vipPrice;

@property (nonatomic, copy) NSString * goodsName;

@property (nonatomic, copy) NSString * goodsTips;

@property (nonatomic, assign) BOOL  isHot;

@property (nonatomic, assign) BOOL isNew;

@property (nonatomic, assign) BOOL isRecom;

@property (nonatomic, copy) NSString * goodsCat;

@property (nonatomic, copy) NSString * goodsState;

@property (nonatomic, copy) NSString * salesNum;

@property (nonatomic, copy) NSString * showTime;

@property (nonatomic, copy) NSString * visitNum;

@property (nonatomic, copy) NSString * goodsQuantity;

@property (nonatomic, copy) NSString * cre_time;

@end



@interface HomeListModel : EvenMallBaseModel


@property (nonatomic, copy) NSArray * banner;

@property (nonatomic, copy) NSArray * category;


@end

