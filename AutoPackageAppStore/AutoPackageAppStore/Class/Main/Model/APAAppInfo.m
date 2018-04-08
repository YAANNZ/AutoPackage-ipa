//
//  APAAppInfo.m
//  AutoPackageAppStore
//
//  Created by ZHUYN on 2018/4/3.
//  Copyright © 2018年 zynabc. All rights reserved.
//

#import "APAAppInfo.h"

@implementation APAAppInfo

- (NSDictionary<NSString *,id> *)dictionaryWithValuesForKeys:(NSArray<NSString *> *)keys
{
    return @{@"master_release": [APAAppVersionInfo class]};
}

@end


@implementation APAAppVersionInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"versionStr": @"version",
             @"buildStr": @"build"
             };
}

@end
