//
//  HomePageView.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "HomePageView.h"
#import "FoodModel.h"

#import "UIImageView+WebCache.h"
@implementation HomePageView

- (void)dealloc
{
    [_imageScroll release];
    [_dateLabel release];
    [_lunarCalendarLabel release];
    [_alertInfoFittingLabel release];
    [_alertInfoAvoidLabel release];
    [_yearLabel release];
    [_yiImageView release];
    [_jiImageView release];
    [_pageControl release];
    
    [_nameLabel release];
    [_englishNameLabel release];
    [_FoodImageView release];
    [_bottomImageView release];
    
    [_TreatmentButton release];
    [_NewFoodButton release];
    [_BestFavoriteButton release];
    [_MenuOfMonthButton release];
    [_MuchFoodButton release];
    
    
    
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
    _imageScroll= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height-44-64 ) ];
    _imageScroll.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"占位图.png"]];
    [self addSubview:_imageScroll];
    _imageScroll.pagingEnabled = YES;
    
    
    //设置滚动区域
    //_imageScroll.contentSize = CGSizeMake(320*8,460);
    
    //菜肴图片
    [self setupImageView];
    
    //PageControl分页
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(15, kScreen_height-44-64-15 , kScreen_width - 30, 10)];
    [self addSubview:_pageControl];
    
    
    //日期
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10/568.0 * kScreen_height , 85, 15/568.0 * kScreen_height)];
    //_dateLabel.text = @"2014-9-18";
    _dateLabel.textColor = [UIColor whiteColor];
    _dateLabel.textAlignment = 1;
    _dateLabel.font = [UIFont systemFontOfSize:14.0];
    if (kScreen_height > 500) {
        _dateLabel.font = [UIFont systemFontOfSize:14.0];
    }
    if (kScreen_height < 500) {
        _dateLabel.font = [UIFont systemFontOfSize:13.0];
    }
    [self addSubview:_dateLabel];
    
    //农历日期
    _lunarCalendarLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 50/568.0 * kScreen_height , 85, 15/568.0 * kScreen_height)];
    _lunarCalendarLabel.textColor = [UIColor whiteColor];
    //_lunarCalendarLabel.text = @"农历八月十五";
    _lunarCalendarLabel.textAlignment = 1;
    _lunarCalendarLabel.font = [UIFont systemFontOfSize:14.0];
    if (kScreen_height > 500) {
        _lunarCalendarLabel.font = [UIFont systemFontOfSize:14.0];
    }
    if (kScreen_height < 500) {
        _lunarCalendarLabel.font = [UIFont systemFontOfSize:13.0];
    }
    [self addSubview:_lunarCalendarLabel];
    
    //生肖年
    _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 25/568.0 * kScreen_height , 25, 25/568.0 * kScreen_height)];
    _yearLabel.textColor = [UIColor whiteColor];
    _yearLabel.textAlignment = 1;
    //_yearLabel.text = @"马";
    _yearLabel.font = [UIFont systemFontOfSize:25.0];
    if (kScreen_height > 500) {
        _yearLabel.font = [UIFont systemFontOfSize:25.0];
    }
    if (kScreen_height < 500) {
        _yearLabel.font = [UIFont systemFontOfSize:20.0];
    }
    [self addSubview:_yearLabel];
    
    
    //“宜”图片
    _yiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(105, 10/568.0 * kScreen_height , 20/568.0 * kScreen_height, 20/568.0 * kScreen_height)];
    _yiImageView.image = [UIImage imageNamed:@"首页-宜"];
    [self addSubview:_yiImageView];
    
    //宜
    _alertInfoFittingLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 10/568.0 * kScreen_height , 175, 30/568.0 * kScreen_height)];
    _alertInfoFittingLabel.textColor = [UIColor whiteColor];
    //_alertInfoFittingLabel.text = @"芡实（利水渗湿）；沙参（强心润肺）；橙子（宽胸开结）";
    _alertInfoFittingLabel.numberOfLines = 0;
    if (kScreen_height > 500) {
        _alertInfoFittingLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    }
    if (kScreen_height < 500) {
        _alertInfoFittingLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
    }
    
    [self addSubview:_alertInfoFittingLabel];
    
    //“忌”图片
    _jiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(105, 45/568.0 * kScreen_height , 20/568.0 * kScreen_height, 20/568.0 * kScreen_height)];
    _jiImageView.image = [UIImage imageNamed:@"首页-忌"];
    [self addSubview:_jiImageView];
    
    //忌讳
    _alertInfoAvoidLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 40/568.0 * kScreen_height , 175, 30/568.0 * kScreen_height)];
    _alertInfoAvoidLabel.textColor = [UIColor whiteColor];
    //_alertInfoAvoidLabel.text = @"炸薯条(多食不利健康)";
    if (kScreen_height > 500) {
        _alertInfoAvoidLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    }
    if (kScreen_height < 500) {
        _alertInfoAvoidLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
    }
    [self addSubview:_alertInfoAvoidLabel];
    
    
    //菜名
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 75/568.0 * kScreen_height , 260, 25/568.0 * kScreen_height)];
    _nameLabel.textColor = [UIColor whiteColor];
    //_nameLabel.text = @"松仁山药炒玉米";
    _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19.0];
    [self addSubview:_nameLabel];
    
    //菜名拼音
    _englishNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 102/568.0 * kScreen_height , 260, 12/568.0 * kScreen_height)];
    _englishNameLabel.textColor = [UIColor whiteColor];
    //_englishNameLabel.text = @"Song ren shan yao chao yu mi";
    _englishNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
    if (kScreen_height > 500) {
        _englishNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
    }
    if (kScreen_height < 500) {
        _englishNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0];
    }
    
    [self addSubview:_englishNameLabel];
    
    
    
    //底部背景图片
    _bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreen_height -44-64, self.bounds.size.width, 44)];
    _bottomImageView.image = [UIImage imageNamed:@"首页-底部背景1"];
    //[self addSubview:_bottomImageView];
    
    
    
    //对症食疗按钮
    _TreatmentButton = [[ButtonView alloc]initWithFrame:CGRectMake(0, kScreen_height -44-64, kScreen_width/5, 44) loadView:@"首页-对症治疗" labelName:@"对症食疗" changeImage:@"首页-对症治疗-选"];
    [self addSubview:_TreatmentButton];
    
    //最新推出按钮
    _NewFoodButton = [[ButtonView alloc]initWithFrame:CGRectMake(kScreen_width/5, kScreen_height-44-64, kScreen_width/5, 44) loadView:@"首页-摇一摇" labelName:@"最新推出" changeImage:@"首页-摇一摇-选"];
    [self addSubview:_NewFoodButton];
    
    
    //最受欢迎按钮
    _BestFavoriteButton = [[ButtonView alloc]initWithFrame:CGRectMake(kScreen_width/5 * 2, kScreen_height-44-64, kScreen_width/5, 44) loadView:@"首页-热门推荐" labelName:@"最受欢迎" changeImage:@"首页-热门推荐-选"];
    [self addSubview:_BestFavoriteButton];
    
    //当月菜单按钮
    _MenuOfMonthButton = [[ButtonView alloc]initWithFrame:CGRectMake(kScreen_width/5 * 3, kScreen_height-44-64, kScreen_width/5, 44) loadView:@"首页-每月美食" labelName:@"每月美食" changeImage:@"首页-每月美食-选"];
    [self addSubview:_MenuOfMonthButton ];
    
    //万道美食按钮
    _MuchFoodButton = [[ButtonView alloc]initWithFrame:CGRectMake(kScreen_width/5 * 4, kScreen_height-44-64, kScreen_width/5, 44) loadView:@"首页-美女" labelName:@"万道美食" changeImage:@"首页-美女-选"];
    [self addSubview:_MuchFoodButton];
    
    
}


- (void)setupImageView
{
    self.sucessBlock =^(id object)
    {
        int x=0;
        for (int i=0; i<[_dataArray count]; i++) {
            FoodModel * model = _dataArray[i];
            self.FoodImageView = [[UIImageView alloc]init];
            
            self.FoodImageView.frame = CGRectMake(x, 0, 320, kScreen_height - 44- 64);
            
            self.FoodImageView.image = [UIImage imageNamed:@"占位图"];
            
            NSURL * url = [[NSURL alloc]initWithString:model.imagePathLandscape];
            
            [self.FoodImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"占位图"]];
            
            x=x+320;
            [self.imageScroll addSubview:self.FoodImageView];
            
//            [url release];
            
        }
        self.imageScroll.contentSize=CGSizeMake(x,self.bounds.size.height-44);
    };
    
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
