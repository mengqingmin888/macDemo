//
//  TypeViewCell.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodModel;

@interface TypeViewCell : UICollectionViewCell

//点击菜品的大分类弹出的小分类
@property(nonatomic,retain,readonly)UIView  *typeView;
//显示分类相关的图片的View
@property(nonatomic,retain,readonly)UIImageView  * showImageView;
//显示分类的name
@property(nonatomic,retain,readonly)UILabel   * nameLabel;

@property(nonatomic,retain)FoodModel  * foodModel;


@end
