//
//  HomeModel.h
//  EvenMall
//
//  Created by xuechuan on 2018/8/8.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "EvenMallBaseModel.h"


@interface HomeCategoryModel : NSObject

@property (nonatomic, copy) NSString * catId;

@property (nonatomic, copy) NSString * catImg;

@property (nonatomic, copy) NSString * catName;

@property (nonatomic, copy) NSString * parCatId;

@property (nonatomic, copy) NSString * creTime;

@property (nonatomic, copy) NSString * catCode;

@property (nonatomic, copy) NSString * catOrder;

@end




@interface HomeBannerModel : NSObject

@property (nonatomic, copy) NSString * webUrl;//3

@property (nonatomic, copy) NSString * bannerOrder;//3

@property (nonatomic, copy) NSString * bannerCat;//3

@property (nonatomic, copy) NSString * bannerType;//3

@property (nonatomic, copy) NSString * bannerImg;//3

@property (nonatomic, copy) NSString * goodsId;//

@property (nonatomic, copy) NSString * bannerId;//

@property (nonatomic, copy) NSString * cre_time;//3


@end

@interface HomeGoodsModel : NSObject

@property (nonatomic, copy) NSString * goodsId;//

@property (nonatomic, assign) NSInteger  goodsNum;//

@property (nonatomic, copy) NSString * marketPrice;//

@property (nonatomic, copy) NSString * goodsThumbnail;//2

@property (nonatomic, copy) NSString * goodAdPic;//

@property (nonatomic, copy) NSString * vipPrice;//1

@property (nonatomic, copy) NSString * goodsName;//6

@property (nonatomic, copy) NSString * goodsTips;//

@property (nonatomic, assign) BOOL  isHot;//4

@property (nonatomic, assign) BOOL isAd;//5

@property (nonatomic, assign) BOOL isNew;//

@property (nonatomic, assign) BOOL isRecom;//

@property (nonatomic, copy) NSString * goodsCat;//

@property (nonatomic, copy) NSString * goodsState;//

@property (nonatomic, copy) NSString * salesNum;//

@property (nonatomic, copy) NSString * showTime;//

@property (nonatomic, copy) NSString * visitNum;//

@property (nonatomic, copy) NSString * goodsQuantity;//

@property (nonatomic, copy) NSString * cre_time;//3

@property (nonatomic, copy) NSString * cartQuantity;//3



@property (nonatomic, copy) NSString * webUrl;//3

@property (nonatomic, copy) NSString * bannerOrder;//3

@property (nonatomic, copy) NSString * bannerCat;//3

@property (nonatomic, copy) NSString * bannerType;//3

@property (nonatomic, copy) NSString * bannerImg;//3

@property (nonatomic, copy) NSString * remind;//3


@end


@interface HomeModel : EvenMallBaseModel



@property (nonatomic, copy) NSArray * banner;

@property (nonatomic, copy) NSArray * category;

@property (nonatomic, copy) NSArray * goodsList;

@property (nonatomic, copy) NSArray * outStock;

@end
