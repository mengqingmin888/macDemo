//
//  FoodDetailView.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-19.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FoodDetailView.h"

@implementation FoodDetailView

- (void)dealloc
{
    [_FoodImageView release];
    [_nameLabel release];
    [_englishNameLabel release];
    
    [_fenGeXianImage release];
    [_shugangImage1 release];
    [_shugangImage2 release];
    [_shugangImage3 release];
    [_shugangImage4 release];
    [_shugangImage5 release];
    
    
    [_shijianLabel release];
    [_kouweiLabel release];
    [_fangfaLabel release];
    [_gongxiaoLabel release];
    [_renqunLabel release];
    [_bottomImageView release];
    
    [_timeLengthLabel release];
    [_tasteLabel release];
    [_cookingMethodLabel release];
    [_effectLabel release];
    [_fittingCrowdLabel release];
    
    
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
    //菜肴图片
    _FoodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.bounds.size.height-44-64)];
    _FoodImageView.image = [UIImage imageNamed:@"占位图"];
    [self addSubview:_FoodImageView];
    
    
    
    //菜名
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15/568.0 * kScreen_height , 200, 25/568.0 * kScreen_height)];
    _nameLabel.textColor = [UIColor whiteColor];
    //_nameLabel.text = @"南瓜炒牛肉";
    _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.0];
    [self addSubview:_nameLabel];
    
    //菜名拼音
    _englishNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 42/568.0 * kScreen_height , 260, 12/568.0 * kScreen_height)];
    _englishNameLabel.textColor = [UIColor whiteColor];
    //_englishNameLabel.text = @"Nan gua chao niu rou";
    _englishNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    [self addSubview:_englishNameLabel];

    //分割线
    _fenGeXianImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60/568.0 * kScreen_height, 280, 1)];
    _fenGeXianImage.image = [UIImage imageNamed:@"我的收藏细线"];
    [self addSubview:_fenGeXianImage];
    
    //竖线1
    _shugangImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 65/568.0 * kScreen_height, 1, 30/568.0 * kScreen_height)];
    _shugangImage1.image = [UIImage imageNamed:@"粗线"];
    [self addSubview:_shugangImage1];
    
    //竖线2
    _shugangImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(75, 65/568.0 * kScreen_height, 1, 30/568.0 * kScreen_height)];
    _shugangImage1.image = [UIImage imageNamed:@"粗线"];
    [self addSubview:_shugangImage1];
    
    //竖线3
    _shugangImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(110, 65/568.0 * kScreen_height, 1, 30/568.0 * kScreen_height)];
    _shugangImage1.image = [UIImage imageNamed:@"粗线"];
    [self addSubview:_shugangImage1];
    
    //竖线4
    _shugangImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(165, 65/568.0 * kScreen_height, 1, 30/568.0 * kScreen_height)];
    _shugangImage1.image = [UIImage imageNamed:@"粗线"];
    [self addSubview:_shugangImage1];
    
    //竖线5
    _shugangImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(220, 65/568.0 * kScreen_height, 1, 30/568.0 * kScreen_height)];
    _shugangImage1.image = [UIImage imageNamed:@"粗线"];
    [self addSubview:_shugangImage1];
    
    
    
    //“烹饪时间”
    _shijianLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 65/568.0 * kScreen_height , 50, 15/568.0 * kScreen_height)];
    _shijianLabel.textColor = [UIColor whiteColor];
    _shijianLabel.text = @"烹饪时间";
    _shijianLabel.font = [UIFont systemFontOfSize:11.0];
    [self addSubview:_shijianLabel];
    
    //烹饪时间
    _timeLengthLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 80/568.0 * kScreen_height , 50, 15/568.0 * kScreen_height)];
    _timeLengthLabel.textColor = [UIColor whiteColor];
    //_timeLengthLabel.text = @"2分钟";
    _timeLengthLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    [self addSubview:_timeLengthLabel];
    
    
    
    
    //“口味”
    _kouweiLabel = [[UILabel alloc]initWithFrame:CGRectMake(77, 65/568.0 * kScreen_height , 50, 15/568.0 * kScreen_height)];
    _kouweiLabel.textColor = [UIColor whiteColor];
    _kouweiLabel.text = @"口味";
    _kouweiLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_kouweiLabel];
    
    //口味
    _tasteLabel = [[UILabel alloc]initWithFrame:CGRectMake(77, 80/568.0 * kScreen_height , 50, 15/568.0 * kScreen_height)];
    _tasteLabel.textColor = [UIColor whiteColor];
    //_tasteLabel.text = @"鲜";
    _tasteLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    [self addSubview:_tasteLabel];
    
    
    
    
    //“烹饪方法”
    _fangfaLabel = [[UILabel alloc]initWithFrame:CGRectMake(112, 65/568.0 * kScreen_height , 50, 15/568.0 * kScreen_height)];
    _fangfaLabel.textColor = [UIColor whiteColor];
    _fangfaLabel.text = @"烹饪方法";
    _fangfaLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_fangfaLabel];
    
    //烹饪方法
    _cookingMethodLabel = [[UILabel alloc]initWithFrame:CGRectMake(112, 80/568.0 * kScreen_height , 50, 15/568.0 * kScreen_height)];
    _cookingMethodLabel.textColor = [UIColor whiteColor];
    //_cookingMethodLabel.text = @"炒";
    _cookingMethodLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    [self addSubview:_cookingMethodLabel];
    
    
    
    
    //“功效”
    _gongxiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(167, 65/568.0 * kScreen_height , 50, 15/568.0 * kScreen_height)];
    _gongxiaoLabel.textColor = [UIColor whiteColor];
    _gongxiaoLabel.text = @"功效";
    _gongxiaoLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_gongxiaoLabel];
    
    //功效
    _effectLabel = [[UILabel alloc]initWithFrame:CGRectMake(167, 80/568.0 * kScreen_height , 50, 15/568.0 * kScreen_height)];
    _effectLabel.textColor = [UIColor whiteColor];
    //_effectLabel.text = @"增强免疫";
    _effectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    [self addSubview:_effectLabel];
    
    
    
    
    //“适合人群”
    _renqunLabel = [[UILabel alloc]initWithFrame:CGRectMake(222, 65/568.0 * kScreen_height , 60, 15/568.0 * kScreen_height)];
    _renqunLabel.textColor = [UIColor whiteColor];
    _renqunLabel.text = @"适合人群";
    _renqunLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_renqunLabel];
    
    //适合人群
    _fittingCrowdLabel = [[UILabel alloc]initWithFrame:CGRectMake(222, 80/568.0 * kScreen_height , 60, 15/568.0 * kScreen_height)];
    _fittingCrowdLabel.textColor = [UIColor whiteColor];
    //_fittingCrowdLabel.text = @"男性";
    _fittingCrowdLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    [self addSubview:_fittingCrowdLabel];
    
    
    //底部背景图片
    _bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreen_height-44-64, kScreen_width, 44)];
    _bottomImageView.image = [UIImage imageNamed:@"首页-底部背景1"];
    //[self addSubview:_bottomImageView];
    
    
    
    
    
    //做法按钮
    _stepButton = [[ButtonView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-44-64, self.bounds.size.width/3, 44) labelName:@"材料做法" loadView:@"详情-做法" changeImage:@"首页-做法-选"];
    [self addSubview:_stepButton];
    
    //相关常识按钮
    _correlationButton = [[ButtonView alloc]initWithFrame:CGRectMake(self.bounds.size.width/3, self.bounds.size.height-44-64, self.bounds.size.width/3, 44) labelName:@"相关常识" loadView:@"详情-相关常识" changeImage:@"首页-相关常识-选"];
    [self addSubview:_correlationButton ];
    
    //相宜相克按钮
    _goodAndBadButton = [[ButtonView alloc]initWithFrame:CGRectMake(self.bounds.size.width/3 * 2, self.bounds.size.height-44-64, self.bounds.size.width/3, 44) labelName:@"相宜相克" loadView:@"详情-相宜相克" changeImage:@"首页-相宜相克-选"];
    [self addSubview:_goodAndBadButton];
    
    
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
