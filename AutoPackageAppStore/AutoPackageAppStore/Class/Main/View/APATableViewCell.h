//
//  APATableViewCell.h
//  AutoPackageAppStore
//
//  Created by ZHUYN on 2018/4/3.
//  Copyright © 2018年 zynabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APAAppInfo.h"

@interface APATableViewCell : UITableViewCell

@property (nonatomic, strong) APAAppInfo *appInfo;

+ (APATableViewCell *)tableViewCell:(UITableView *)tableView;

@end
