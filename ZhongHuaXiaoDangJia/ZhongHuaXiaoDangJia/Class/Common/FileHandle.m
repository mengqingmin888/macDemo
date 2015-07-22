//
//  FileHandle.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FileHandle.h"
#import "FoodModel.h"


@implementation FileHandle

static FileHandle  * fileHandle = nil;

+ (FileHandle *)shareInstance
{
    if (fileHandle == nil) {
        
        fileHandle = [[FileHandle alloc] init];
    }

    return fileHandle;
}

//cache路径
- (NSString  *)cachesPath
{

    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];

}

//清除缓存
- (void)cleanDownloadImages
{
 
    NSString  * imageManagerPath = [[self cachesPath] stringByAppendingPathComponent:@"ImageCache"];
    NSFileManager  * fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageManagerPath error:nil];
    
//    清除完成后，创建文件夹
    [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
    
}

//数据库存储的路径
- (NSString *)databaseFilePath : (NSString *)databaseName
{

    return [[self cachesPath] stringByAppendingPathComponent:databaseName];

}

//将对象归档
- (NSData *)dataOfArchiverObject : (id)object forKey : (NSString *)key
{
    
    NSMutableData  * data = [NSMutableData data];
    
    NSKeyedArchiver  * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:object forKey:key];
    
    [archiver finishEncoding];
    
    [archiver release];
    
    return data;
    
}

//将对象反归档
- (id)unarchiverObject : (NSData *)data forKey : (NSString *)key
{
    
    NSKeyedUnarchiver  * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    id object = [unarchiver decodeObjectForKey:key];
    
    [unarchiver finishDecoding];
    
    [unarchiver release];
    
    
    return object;
    
}



@end