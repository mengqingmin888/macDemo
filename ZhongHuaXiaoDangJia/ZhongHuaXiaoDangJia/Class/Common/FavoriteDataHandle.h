//
//  FavoriteDataHandle.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoodModel;


@interface FavoriteDataHandle : NSObject


@property(nonatomic,retain)NSMutableArray  *foodModelArray;

+(FavoriteDataHandle *)shareInstance;

//从数据库读取菜品收藏的数据源
- (void)setupFoodModelDataSource;

//获取收藏的菜品的个数
- (NSInteger)countOfFoodModel;

//获取某个菜品的对象
- (FoodModel *)foodModelForRow : (NSInteger)row;

//删除某个菜品的对象
- (void)deleteFoodModelForRow : (NSInteger)row;


@end