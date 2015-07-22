//
//  NewFoodCell.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodModel;
@interface NewFoodCell : UICollectionViewCell

//菜名
@property(nonatomic,retain,readonly)UILabel * nameLabel;

//收藏次数
@property(nonatomic,retain,readonly)UILabel * clickCountLabel;

//背景框
@property(nonatomic,retain,readonly)UIImageView * backView;

//显示菜品的图片
@property(nonatomic,retain,readonly)UIImageView * showImageView;

//收藏图片
@property(nonatomic,retain,readonly)UIImageView * clickImageView;

@property(nonatomic,retain)FoodModel * foodNewModal;

@end
