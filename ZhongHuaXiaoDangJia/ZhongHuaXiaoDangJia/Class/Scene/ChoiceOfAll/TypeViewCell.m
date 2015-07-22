//
//  TypeViewCell.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "TypeViewCell.h"
#import "FoodModel.h"

@implementation TypeViewCell

- (void)dealloc
{
    [_typeView release];
    [_showImageView release];
    [_nameLabel release];
    self.foodModel = nil;
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

    _typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    _typeView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_typeView];
    
    _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 2, 40, 30)];
    _showImageView.backgroundColor = [UIColor clearColor];
    [_typeView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 60, 10)];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [_typeView addSubview:_nameLabel];
    

}


- (void)setFoodModel:(FoodModel *)foodModel
{
    if (_foodModel != foodModel) {
        [_foodModel release];
        _foodModel = [foodModel retain];
    }

    _nameLabel.text = foodModel.childCatalogName;

}




@end
