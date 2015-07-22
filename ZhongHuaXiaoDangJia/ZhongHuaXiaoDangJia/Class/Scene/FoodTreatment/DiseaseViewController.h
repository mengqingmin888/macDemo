//
//  DiseaseViewController.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodTreatment;
@class FoodModel;

@interface DiseaseViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,retain)FoodTreatment  * foodTreatment;

//病症简介View
@property(nonatomic,retain,readonly)UIImageView  * introductionView;
//病症简介Label
@property(nonatomic,retain,readonly)UILabel  * introductionLabel;
//病症简介标题
@property(nonatomic,retain,readonly)UILabel  *diseaseLabel;

//病症详情背景图
@property(nonatomic,retain,readonly)UIImageView  *detailView;
//关闭病症详情按钮
@property(nonatomic,retain,readonly)UIButton  * closeButton;
//病症详情标题
@property(nonatomic,retain,readonly)UILabel   * titleLabel;
//病症详情显示Label
@property(nonatomic,retain,readonly)UILabel  *contentLabel;
//病症详情显示scrollView
@property(nonatomic,retain,readonly)UIScrollView  *contentScrollView;


@property(nonatomic,retain)FoodModel  * foodModel;


@end
