//
//  NewFoodCell.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "NewFoodCell.h"


#import "FoodModel.h"


@implementation NewFoodCell
- (void)dealloc
{
    [_nameLabel release];
    [_backView release];
    [_clickCountLabel release];
    [_showImageView release];
    [_clickImageView release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    //背景框
    _backView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 154, 100)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backView];
    
    //显示菜品图片
    _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 148, 94)];
    //_showImageView.backgroundColor = [UIColor greenColor];
    [_backView addSubview:_showImageView];
    
    //菜名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 102, 100, 22)];
    _nameLabel.font = [UIFont systemFontOfSize:10.0];
    //_nameLabel.text = @"我是女色特务得分王";
    [self.contentView addSubview:_nameLabel];
    
    //收藏图片
    _clickImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的收藏3.png"]];
    _clickImageView.frame = CGRectMake(102, 105, 13, 13);
    [self.contentView addSubview:_clickImageView];
    
    //收藏label
    _clickCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 105, 50, 12)];
    //_clickCountLabel.text = @"11112";
    _clickCountLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_clickCountLabel];
    
}

- (void)setFoodNewModal:(FoodModel *)foodNewModal
{
    if (_foodNewModal != foodNewModal) {
        [_foodNewModal release];
        _foodNewModal = [foodNewModal retain];
    }
    //菜名
    _nameLabel.text = foodNewModal.name;
    //收藏数量
    _clickCountLabel.text = foodNewModal.clickCount;
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
