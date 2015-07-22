//
//  DiseaseViewCell.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "DiseaseViewCell.h"

@implementation DiseaseViewCell

- (void)dealloc
{
    [_diseaseView release];
    [_showImageView release];
    [_nameLabel release];
    [_collectImageView release];
    [_clickCountLabel release];
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
    _nameLabel.font = [UIFont systemFontOfSize:10];
//收藏图标
    _collectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的收藏3.png"]];
    _collectImageView.frame = CGRectMake(102, 105, 13, 13);
    [_diseaseView addSubview:_collectImageView];
//  收藏数量
    _clickCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 105, 50, 12)];
    [_diseaseView addSubview:_clickCountLabel];
    _clickCountLabel.font = [UIFont systemFontOfSize:12];
    
    
}

@end
