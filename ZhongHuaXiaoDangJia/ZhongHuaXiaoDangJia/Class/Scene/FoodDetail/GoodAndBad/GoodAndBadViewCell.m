//
//  GoodAndBadViewCell.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-23.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "GoodAndBadViewCell.h"

#import "FoodModel.h"

#import "UIImageView+WebCache.h"

@implementation GoodAndBadViewCell

- (void)dealloc
{
    [_whiteView release];
    [_materialFoodImageView release];
    [_materialFoodNameLabel release];
    [_contentDescriptionLabel release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    //左侧白的方块
    _whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 1, 115, 43)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_whiteView];
    
    //食材图片
    _materialFoodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 43)];
    _materialFoodImageView.image = [UIImage imageNamed:@"占位图"];
    [_whiteView addSubview:_materialFoodImageView];
    
    //食材名字
    _materialFoodNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(57, 0, 55, 43)];
    _materialFoodNameLabel.text = @"猪排骨";
    _materialFoodNameLabel.textColor = [UIColor colorWithRed:215/255.0 green:130/255.0 blue:65/255.0 alpha:1.0];
    _materialFoodNameLabel.numberOfLines = 0;
    _materialFoodNameLabel.textAlignment = 1;
    _materialFoodNameLabel.font = [UIFont systemFontOfSize:15.0];
    [_whiteView addSubview:_materialFoodNameLabel];
    
    //食材功效
    _contentDescriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(135, 1, 165, 43)];
    _contentDescriptionLabel.text = @"呵呵呵呵呵呵呵呵呵呵呵呵";
    _contentDescriptionLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:230/255.0 blue:205/255.0 alpha:1.0];
    _contentDescriptionLabel.numberOfLines = 0;
    _contentDescriptionLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_contentDescriptionLabel];
    
}

//重写初始化方法
- (void)setShowFood:(FoodModel *)showFood
{
    if (_showFood != showFood) {
        [_showFood release];
        
        _showFood = [showFood retain];
    }
    
    //图片
    NSURL * url = [NSURL URLWithString:showFood.MaterialFoodImage];
    
    [_materialFoodImageView sd_setImageWithURL:url];
    
    //名字
    _materialFoodNameLabel.text = showFood.MaterialFoodName;
    
    //功效
    _contentDescriptionLabel.text = [NSString stringWithFormat:@"  %@",showFood.contentDescription];
    
    
}






- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
