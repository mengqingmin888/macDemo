//
//  FoodDetailView.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-19.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ButtonView.h"

@interface FoodDetailView : UIView

//菜肴图片
@property (nonatomic,retain) UIImageView * FoodImageView;

//菜肴名称
@property (nonatomic,retain,readonly) UILabel * nameLabel;

//菜名拼音
@property (nonatomic,retain,readonly) UILabel * englishNameLabel;

//分割线
@property (nonatomic,retain,readonly) UIImageView * fenGeXianImage;

//竖线1
@property (nonatomic,retain,readonly) UIImageView * shugangImage1;

//竖线2
@property (nonatomic,retain,readonly) UIImageView * shugangImage2;

//竖线3
@property (nonatomic,retain,readonly) UIImageView * shugangImage3;

//竖线4
@property (nonatomic,retain,readonly) UIImageView * shugangImage4;

//竖线5
@property (nonatomic,retain,readonly) UIImageView * shugangImage5;


//“烹饪时间”
@property (nonatomic,retain,readonly) UILabel * shijianLabel;

//“口味”
@property (nonatomic,retain,readonly) UILabel * kouweiLabel;

//“烹饪方法”
@property (nonatomic,retain,readonly) UILabel * fangfaLabel;

//“功效”
@property (nonatomic,retain,readonly) UILabel * gongxiaoLabel;

//“适合人群”
@property (nonatomic,retain,readonly) UILabel * renqunLabel;


//烹饪时间
@property (nonatomic,retain,readonly) UILabel * timeLengthLabel;

//口味
@property (nonatomic,retain,readonly) UILabel * tasteLabel;

//烹饪方法
@property (nonatomic,retain,readonly) UILabel * cookingMethodLabel;

//功效
@property (nonatomic,retain,readonly) UILabel * effectLabel;

//适合人群
@property (nonatomic,retain,readonly) UILabel * fittingCrowdLabel;


//底部背景框
@property (nonatomic,retain) UIImageView * bottomImageView;



//做法按钮
@property (nonatomic,retain) ButtonView * stepButton;

//相关常识按钮
@property (nonatomic,retain) ButtonView * correlationButton;

//相宜相克按钮
@property (nonatomic,retain) ButtonView * goodAndBadButton;






@end
