//
//  FavoriteDataHandle.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FavoriteDataHandle.h"
#import "FoodModel.h"
#import "DatabaseHandle.h"

@implementation FavoriteDataHandle

static FavoriteDataHandle  *handle = nil;


+(FavoriteDataHandle *)shareInstance
{
    if (handle == nil) {
        handle = [[FavoriteDataHandle alloc] init];
    }

    return handle;
}

//从数据库读取菜品收藏的数据源
- (void)setupFoodModelDataSource
{
    
    self.foodModelArray = [[[DatabaseHandle shareInstance] selectAllActivity] mutableCopy];

    
    
}

//获取收藏的菜品的个数'=9
- (NSInteger)countOfFoodModel
{

    return [_foodModelArray count];
}

//获取某个菜品的对象
- (FoodModel *)foodModelForRow : (NSInteger)row
{

    return _foodModelArray[row];
}

//删除某个菜品的对象
- (void)deleteFoodModelForRow : (NSInteger)row
{
//    从数据库删除
    [[DatabaseHandle shareInstance] deleteFood:[self foodModelForRow:row]];
//从数据源删除
    [_foodModelArray removeObjectAtIndex:row];

}


@end
