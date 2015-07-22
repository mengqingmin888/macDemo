//
//  HomePageView.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>

//Block函数
typedef void(^CreatImageViewBlock)(id object);

#import "ButtonView.h"

@interface HomePageView : UIView

@property(nonatomic,copy)CreatImageViewBlock sucessBlock;

//数组
@property (nonatomic,retain) NSMutableArray * dataArray;

//滚动视图
@property (nonatomic,retain) UIScrollView * imageScroll;


//日期
@property (nonatomic,retain,readonly) UILabel * dateLabel;

//农历
@property (nonatomic,retain,readonly) UILabel * lunarCalendarLabel;

//生肖年
@property (nonatomic,retain,readonly) UILabel * yearLabel;

//“宜”图片
@property (nonatomic,retain,readonly) UIImageView * yiImageView;

//宜
@property (nonatomic,retain,readonly) UILabel * alertInfoFittingLabel;

//“忌”图片
@property (nonatomic,retain,readonly) UIImageView * jiImageView;

//忌讳
@property (nonatomic,retain,readonly) UILabel * alertInfoAvoidLabel;


//菜肴名称
@property (nonatomic,retain,readonly) UILabel * nameLabel;

//菜名拼音
@property (nonatomic,retain,readonly) UILabel * englishNameLabel;


//菜肴图片
@property (nonatomic,retain) UIImageView * FoodImageView;


//PageControl
@property (nonatomic,retain,readonly) UIPageControl * pageControl;


//底部背景框
@property (nonatomic,retain) UIImageView * bottomImageView;


//对症食疗按钮
@property (nonatomic,retain) ButtonView * TreatmentButton;

//最新推出按钮
@property (nonatomic,retain) ButtonView * NewFoodButton;

//最受欢迎按钮
@property (nonatomic,retain) ButtonView * BestFavoriteButton;

//当月菜单按钮
@property (nonatomic,retain) ButtonView * MenuOfMonthButton;

//万道美食按钮
@property (nonatomic,retain) ButtonView * MuchFoodButton;





@end
