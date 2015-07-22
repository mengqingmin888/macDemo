//
//  DiseaseViewCell.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DiseaseViewCell : UICollectionViewCell

//集合视图中显示菜品的View
@property(nonatomic,retain,readonly)UIImageView  *diseaseView;
//展示菜品图片的View
@property(nonatomic,retain,readonly)UIImageView  *showImageView;
//展示菜品名称的Label
@property(nonatomic,readonly,retain)UILabel  *nameLabel;

//收藏量小图标
@property(nonatomic,retain,readonly)UIImageView  *collectImageView;
//展示菜品的收藏量
@property(nonatomic,retain,readonly)UILabel  *clickCountLabel;



@end
