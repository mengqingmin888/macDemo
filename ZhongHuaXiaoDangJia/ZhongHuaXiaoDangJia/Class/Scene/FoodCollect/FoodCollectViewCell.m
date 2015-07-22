//
//  FoodCollectViewCell.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FoodCollectViewCell.h"

@implementation FoodCollectViewCell

- (void)dealloc
{
    [_diseaseView release];
    [_showImageView release];
    [_nameLabel release];
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

//集合视图每一个cell布局
- (void)setupSubviews
{
    
// 根视图添加到contentView
    _diseaseView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 154, 100)];
    _diseaseView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_diseaseView];
    //菜品图片
    _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 148, 94)];
    //    _showImageView.backgroundColor = [UIColor greenColor];
    [_diseaseView addSubview:_showImageView];
    //菜名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 102, 100, 22)];
    [_diseaseView addSubview:_nameLabel];
    _nameLabel.font = [UIFont systemFontOfSize:15];

//创建View不添加到根视图上，当点击删除按钮时，再将视图添加到，菜品图片的上层，用于让用户知道是处于删除状态。
    _deleteImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,148,94)];
    
//    [_showImageView addSubview:_deleteImageView];
    
    
}

@end
