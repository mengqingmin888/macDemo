//
//  CorrelationView.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-20.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CorrelationView : UIView

@property (nonatomic,retain) UIScrollView * scrollView;


//白色背景图片
@property (nonatomic,retain,readonly) UIImageView * whiteImage;

//食材图片
@property (nonatomic,retain) UIImageView * correlationImageView;

//胶带图片
@property (nonatomic,retain) UIImageView * yellowImageView;


//食材简介
@property (nonatomic,retain) UILabel * nutritionAnalysisLabel;

//分割线
@property (nonatomic,retain) UIImageView * xuXianImageView;

//"制作指导"
@property (nonatomic,retain) UILabel * zhiDaoLabel;

//制作指导
@property (nonatomic,retain) UILabel * productionDirectionLabel;


@end
