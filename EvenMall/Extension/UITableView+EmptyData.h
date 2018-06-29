//
//  UITableView+EmptyData.h
//  Xuechuanedu
//
//  Created by xuechuan on 2018/5/28.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)
- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
