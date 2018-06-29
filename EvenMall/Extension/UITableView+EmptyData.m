//
//  UITableView+EmptyData.m
//  Xuechuanedu
//
//  Created by xuechuan on 2018/5/28.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import "UITableView+EmptyData.h"
#import <MJRefresh/MJRefresh.h>
@implementation UITableView (EmptyData)


- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        self.mj_footer.hidden  = YES;
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.mj_footer.hidden  = NO;

        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}



@end
