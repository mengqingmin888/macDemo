//
//  CategoryViewCell.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "CategoryViewCell.h"

#import "FoodModel.h"

@implementation CategoryViewCell

- (void)dealloc
{
    [_typeView release];
    [_showImageView release];
    [_nameLabel release];
    self.foodModel = nil;
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
    
    _typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [self.contentView addSubview:_typeView];
    _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 2, 40, 40)];
    [_typeView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 60, 10)];
    _nameLabel.font = [UIFont systemFontOfSize:12];
//    _nameLabel.backgroundColor = [UIColor greenColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = @"青菜类";
    _nameLabel.textColor = [UIColor whiteColor];
    [_typeView addSubview:_nameLabel];
    
    
}

- (void)setFoodModel:(FoodModel *)foodModel
{
    if (_foodModel != foodModel) {
        [_foodModel release];
        _foodModel = [foodModel retain];
    }
    
    _nameLabel.text = foodModel.caralogName;
    
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
