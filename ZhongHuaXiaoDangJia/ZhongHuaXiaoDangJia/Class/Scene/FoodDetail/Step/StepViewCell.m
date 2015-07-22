//
//  StepViewCell.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-19.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "StepViewCell.h"

#import "FoodModel.h"

#import "UIImageView+WebCache.h"

@implementation StepViewCell

- (void)dealloc
{
    [_whiteImage release];
    [_stepImage release];
    [_numberImage release];
    [_order_idLabel release];
    [_describeLabel release];
    
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
    //白色背景图片
    _whiteImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 3, 260, 214)];
    _whiteImage.image = [UIImage imageNamed:@"详情页-材料背景"];
    [self.contentView addSubview:_whiteImage];
    
    //做法图片
    _stepImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 240, 155)];
    //_stepImage.image = [UIImage imageNamed:@"111.jpg"];
    [_whiteImage addSubview:_stepImage];
    
    //编号背景图片
    _numberImage = [[UIImageView alloc]initWithFrame:CGRectMake(2, 170, 25, 30)];
    _numberImage.image = [UIImage imageNamed:@"详情页-圆点"];
    [_whiteImage addSubview:_numberImage];
    
    
    //编号
    _order_idLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 178, 15, 15)];
    //_order_idLabel.text = @"01";
    _order_idLabel.textColor = [UIColor redColor];
    _order_idLabel.font = [UIFont systemFontOfSize:13.0];
    [_whiteImage addSubview:_order_idLabel];
    
    //详细做法
    _describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(33, 170, 215, 30)];
    //_describeLabel.text = @"先把锅给我洗干净，洗干净。知道吗，还不快洗干净?";
    _describeLabel.numberOfLines = 0;
    _describeLabel.font = [UIFont systemFontOfSize:12.0];
    [_whiteImage addSubview:_describeLabel];
    
}


//重写初始化方法
- (void)setShowFood:(FoodModel *)showFood
{
    if (_showFood != showFood) {
        [_showFood release];
        
        _showFood = [showFood retain];
    }
    
    //编号
    _order_idLabel.text = showFood.order_id;
    
    //详细步骤
    _describeLabel.text = showFood.describe;
    
    
    //图片
    NSURL * url = [NSURL URLWithString:showFood.imagePath];
    
    
    [_stepImage sd_setImageWithURL:url];
    
    
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
