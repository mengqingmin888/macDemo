//
//  NetWork.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-29.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "NetWork.h"

#import "Reachability.h"
#import <CommonCrypto/CommonDigest.h>
#import "KGStatusBar.h"

#define KDownloadDate @"DownloadDate"
#define kExpiresInSeconds @"ExpiresInSeconds"
#define kExpiryDate @"ExpiryDate"
#define kLocalURL @"LocalURL"

static NetWork * helper = nil;

@interface NetWork()
@property (nonatomic,retain)NSMutableDictionary * dataDic;
@property (nonatomic,retain)NSString * dataDicPath;
@property (nonatomic,retain)NSString * dataPath;
@property (nonatomic,retain)NSFileManager * fileManager;
@property (nonatomic,assign)NetworkStatus status;
@end

@implementation NetWork

+ (NetWork*)shareInstance
{
    if (!helper) {
        helper = [[NetWork alloc]init];
        
        
        //缓存路径
        NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        helper.dataPath = [cachesPath stringByAppendingPathComponent:@"data"];
        
        //缓存的字典路径
        helper.dataDicPath = [helper.dataPath stringByAppendingPathComponent:@"cacheData.dic"];
        
        //创建缓存路径
        helper.fileManager = [NSFileManager defaultManager];
        BOOL  result =  [helper.fileManager fileExistsAtPath:helper.dataPath];
        if (!result) {
            [helper.fileManager createDirectoryAtPath:helper.dataPath withIntermediateDirectories:YES attributes:nil error:nil];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            [dic writeToFile:helper.dataDicPath atomically:YES];
        }
        helper.dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:helper.dataDicPath];
        
    }
    return helper;
}


- (void)loadingDataWithUrlString:(NSString *)urlString urlExpireInSeconds:(NSTimeInterval)timeInterval download:(DownloadBlock)download
{
    //网络
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSParameterAssert([appDlg.hostReach isKindOfClass: [Reachability class]]);
    helper.status = [appDlg.hostReach currentReachabilityStatus];
    
    
    
    NSString * fileName = [[self class] SHA1WithStr:urlString];
    NSString * filePath = [self.dataPath stringByAppendingPathComponent:fileName];
    
    
    if (self.status == NotReachable) {
        //        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"网络已断开" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alertView show];
        
        [KGStatusBar showErrorWithStatus:@"网络连接错误..."];
        //NSLog(@"----无网络连接------");
        
        if ([self.fileManager fileExistsAtPath:filePath]) {
            NSData * readData = [NSData dataWithContentsOfFile:filePath];
            download(nil,readData,nil);
        }
    }else{
        
        NSDate * now = [NSDate date];
        
        
        
        NSDictionary * readDic = self.dataDic[fileName];
        
        NSDate * readExpiryDate = [readDic objectForKey:kExpiryDate];
        
        if ([now timeIntervalSinceDate:readExpiryDate] < 0.0 &&[self.fileManager fileExistsAtPath:filePath]) {
            
            NSString * fileDataPath = [readDic objectForKey:kLocalURL];
            NSData * data = [NSData dataWithContentsOfFile:fileDataPath];
            download(nil,data,nil);
            
        }else{
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            dispatch_async(queue, ^{
                
                //设置网络请求
                NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
                //建立同步连接
                NSURLResponse * response = nil;
                NSError * error = nil;
                
                NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                
                //NSLog(@"%@",error);
                //NSLog(@"%@",error.domain);
                //NSLog(@"%ld",error.code);
                //NSLog(@"%@",error.localizedDescription);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data != nil && data.length ==[response expectedContentLength]) {
                        NSMutableDictionary * fileDic =[NSMutableDictionary dictionary];
                        [fileDic setObject:now forKey:KDownloadDate];
                        [fileDic setObject:[NSNumber numberWithDouble:timeInterval] forKey:kExpiresInSeconds];
                        [fileDic setObject:[now dateByAddingTimeInterval:timeInterval]forKey:kExpiryDate];
                        [fileDic setObject:filePath forKey:kLocalURL];
                        [self.dataDic setObject:fileDic forKey:fileName];
                        [self.dataDic writeToFile:self.dataDicPath atomically:YES];
                        [data writeToFile:filePath atomically:YES];
                        
                    }
                    download(response,data,error);
                });
            });
            
            /*
             [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
             
             if (data != nil && data.length ==[response expectedContentLength]) {
             NSMutableDictionary * fileDic =[NSMutableDictionary dictionary];
             [fileDic setObject:now forKey:KDownloadDate];
             [fileDic setObject:[NSNumber numberWithDouble:timeInterval] forKey:kExpiresInSeconds];
             [fileDic setObject:[now dateByAddingTimeInterval:timeInterval]forKey:kExpiryDate];
             [fileDic setObject:filePath forKey:kLocalURL];
             [self.dataDic setObject:fileDic forKey:fileName];
             [self.dataDic writeToFile:self.dataDicPath atomically:YES];
             [data writeToFile:filePath atomically:YES];
             }
             download(response,data,connectionError);
             
             }];*/
            
        }
        
    }
    
}
- (void)dealloc
{
    self.dataDic = nil;
    self.dataPath = nil;
    self.fileManager = nil;
    [super dealloc];
}
/*
 +(void)loadingDataWithUrlString:(NSString *)urlString download:(DownloadBlock)download
 {
 AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 NSParameterAssert([appDlg.hostReach isKindOfClass: [Reachability class]]);
 
 NetworkStatus status = [appDlg.hostReach currentReachabilityStatus];
 
 NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
 NSString * dataPath = [cachesPath stringByAppendingPathComponent:@"data"];
 
 
 NSFileManager * fileManager = [NSFileManager defaultManager];
 //判断文件是否存在， 参数:文件的完整的路径， 返回值是 BOOL
 BOOL  result =  [fileManager fileExistsAtPath:dataPath];
 if (!result) {
 [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil];
 }
 
 
 if (status == NotReachable) {
 
 NSLog(@"----无网络连接------");
 
 NSString * filePath = [dataPath stringByAppendingPathComponent:[self SHA1WithStr:urlString]];
 
 if ([fileManager fileExistsAtPath:filePath]) {
 NSData * readData = [NSData dataWithContentsOfFile:filePath];
 download(nil,readData,nil);
 }
 }else{
 //     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 //        dispatch_async(queue, ^{
 //
 //            NSURL * url = [NSURL URLWithString:urlString];
 //            NSData * data = [NSData dataWithContentsOfURL:url];
 //
 //            dispatch_async(dispatch_get_main_queue(), ^{
 //                downloadSuccess(data);
 //
 //            });
 
 [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
 
 if (data != nil) {
 NSString * filePath = [dataPath stringByAppendingPathComponent:[self SHA1WithStr:urlString]];
 [data writeToFile:filePath atomically:YES];
 }
 download(response,data,connectionError);
 }];
 NSLog(@"----有网------");
 NSString * str = [self SHA1WithStr:urlString];
 NSLog(@"%@",str);
 }
 
 }
 */
#pragma mark 使用SHA1加密字符串
+ (NSString *)SHA1WithStr:(NSString *)str
{
    const char *cStr = [str UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:str.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

@end
