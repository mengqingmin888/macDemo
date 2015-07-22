//
//  FoodCollectViewCell.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCollectViewCell : UICollectionViewCell

//集合视图中显示菜品的View
@property(nonatomic,retain,readonly)UIImageView  *diseaseView;
//展示菜品图片的View
@property(nonatomic,retain,readonly)UIImageView  *showImageView;
//展示菜品名称的Label
@property(nonatomic,readonly,retain)UILabel  *nameLabel;
//删除图层View
@property(nonatomic,retain,readonly)UIImageView  * deleteImageView;


@end