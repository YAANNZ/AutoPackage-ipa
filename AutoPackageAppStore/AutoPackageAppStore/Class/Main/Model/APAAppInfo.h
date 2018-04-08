//
//  APAAppInfo.h
//  AutoPackageAppStore
//
//  Created by ZHUYN on 2018/4/3.
//  Copyright © 2018年 zynabc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APAAppVersionInfo;
@interface APAAppInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, strong) APAAppVersionInfo *master_release;
@property (nonatomic, assign) BOOL isOld;

@end

@interface APAAppVersionInfo : NSObject

@property (nonatomic, copy) NSString *versionStr;
@property (nonatomic, copy) NSString *buildStr;
@property (nonatomic, copy) NSString *created_at;

@end
