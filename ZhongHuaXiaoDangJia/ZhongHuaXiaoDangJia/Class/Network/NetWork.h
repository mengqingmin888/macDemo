//
//  NetWork.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-29.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppDelegate.h"

@class NetWork;

typedef void(^DownloadBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);

@interface NetWork : NSObject


+ (NetWork *)shareInstance;


- (void)loadingDataWithUrlString:(NSString *)urlString urlExpireInSeconds:(NSTimeInterval)timeInterval download:(DownloadBlock)download;

@end
