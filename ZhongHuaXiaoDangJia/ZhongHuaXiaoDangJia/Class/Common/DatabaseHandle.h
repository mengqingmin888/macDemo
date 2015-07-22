//
//  DatabaseHandle.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoodModel;


@interface DatabaseHandle : NSObject


+(DatabaseHandle *)shareInstance;

//打开数据库
- (void)openDB;
//关闭数据库
- (void)closeDB;

//添加新的菜品
- (void)insertNewFood : (FoodModel *)foodModel;
//删除某个菜品
- (void)deleteFood : (FoodModel *)foodModel;
//获取某个菜品的对象
- (FoodModel *)selectFoodModelWithID : (NSString *)vegetable_id;
//获取所有菜品
- (NSArray *)selectAllActivity;
//判断菜品是否被收藏

- (BOOL)isFavoriteFoodModelWithID : (NSString *)vegetable_id;




@end
