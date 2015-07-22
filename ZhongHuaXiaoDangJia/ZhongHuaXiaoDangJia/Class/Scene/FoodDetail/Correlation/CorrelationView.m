//
//  CorrelationView.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-20.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "CorrelationView.h"

@implementation CorrelationView

- (void)dealloc
{
    [_scrollView release];
    [_whiteImage release];
    [_correlationImageView release];
    [_yellowImageView release];
    [_nutritionAnalysisLabel release];
    [_xuXianImageView release];
    [_zhiDaoLabel release];
    [_productionDirectionLabel release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews
{
    
    //创建scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:(self.bounds) ];
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    [self addSubview:_scrollView];
    
    //设置滚动区域
    //_scrollView.contentSize = CGSizeMake(kScreen_width,kScreen_height);
    
    //白色背景图片
    _whiteImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 15 , 200, 140)];
    _whiteImage.image = [UIImage imageNamed:@"详情页-材料背景"];
    [_scrollView addSubview:_whiteImage];
    
    
    //食材图片
    _correlationImageView = [[UIImageView alloc]init];
    _correlationImageView.frame = CGRectMake(10, 11, 180, 118);
    _correlationImageView.image = [UIImage imageNamed:@""];
    //_correlationImageView.backgroundColor = [UIColor cyanColor];
    [_whiteImage addSubview:_correlationImageView];
    
    
    //胶带图片
    _yellowImageView = [[UIImageView alloc]init];
    _yellowImageView.frame = CGRectMake(100, 9 , 120, 17);
    _yellowImageView.image = [UIImage imageNamed:@"详情页-胶带"];
    [_scrollView addSubview:_yellowImageView];
    
    
    //食材简介
    _nutritionAnalysisLabel = [[UILabel alloc]init];
    //_nutritionAnalysisLabel.frame = CGRectMake(20, 170, 280, 100);
    _nutritionAnalysisLabel.numberOfLines = 0;
    //_nutritionAnalysisLabel.backgroundColor = [UIColor cyanColor];
    _nutritionAnalysisLabel.font = [UIFont systemFontOfSize:14.0];
    _nutritionAnalysisLabel.textColor = [UIColor colorWithRed:139/255.0 green:69/255.0 blue:19/255.0 alpha:1.0];
    [_scrollView addSubview:_nutritionAnalysisLabel];
    
    
    //分割线
    _xuXianImageView = [[UIImageView alloc]init];
    //_xuXianImageView.frame = CGRectMake(20, 279.5, 280, 1);
    _xuXianImageView.image = [UIImage imageNamed:@"详情-虚线1"];
    [_scrollView addSubview:_xuXianImageView];
    
    
    //"制作指导"
    _zhiDaoLabel = [[UILabel alloc]init];
    //_zhiDaoLabel.frame = CGRectMake(20, 290, 90, 20);
    _zhiDaoLabel.text = @"制作指导:";
    _zhiDaoLabel.textColor = [UIColor redColor];
    _zhiDaoLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    //_zhiDaoLabel.backgroundColor = [UIColor yellowColor];
    [_scrollView addSubview:_zhiDaoLabel];
    
    
    //制作指导
    _productionDirectionLabel = [[UILabel alloc]init];
    //_productionDirectionLabel.frame = CGRectMake(20, 310, 280, 100);
    _productionDirectionLabel.numberOfLines = 0;
    //_productionDirectionLabel.backgroundColor = [UIColor cyanColor];
    _productionDirectionLabel.textColor = [UIColor colorWithRed:139/255.0 green:69/255.0 blue:19/255.0 alpha:1.0];
    _productionDirectionLabel.font = [UIFont systemFontOfSize:14.0];
    [_scrollView addSubview:_productionDirectionLabel];
    
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
