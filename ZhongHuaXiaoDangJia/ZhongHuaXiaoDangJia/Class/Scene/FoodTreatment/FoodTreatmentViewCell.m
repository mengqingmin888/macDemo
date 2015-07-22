//
//  FoodTreatmentViewCell.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FoodTreatmentViewCell.h"
#import "FoodTreatment.h"

@implementation FoodTreatmentViewCell

- (void)dealloc
{
    [_treatmentView release];
    [_treatmentLabel release];
    [_treatmentCategoryLabel release];
    self.foodTreatment = nil ;
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

    
//    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    _treatmentView  =  [[UIImageView  alloc] initWithImage:[UIImage imageNamed:@"缺省背景图.png"]];
    _treatmentView.frame = CGRectMake(15,15, 50, 50);
//    _treatmentView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_treatmentView];


    _treatmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 200, 20)];
    _treatmentLabel.text = @"儿科";
    [self.contentView addSubview:_treatmentLabel];
    _treatmentLabel.font = [UIFont systemFontOfSize:15];
    _treatmentLabel.textColor = [UIColor brownColor];
    
    
    _treatmentCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 40, 200, 20)];
    _treatmentCategoryLabel.text = @"小儿感冒、小儿咳嗽";
    [self.contentView addSubview:_treatmentCategoryLabel];
    _treatmentCategoryLabel.font = [UIFont systemFontOfSize:10];
    _treatmentCategoryLabel.textColor =[UIColor brownColor];
    
}

- (void)setFoodTreatment:(FoodTreatment *)foodTreatment
{
    if (_foodTreatment != foodTreatment) {
        [_foodTreatment release];
        _foodTreatment = [foodTreatment retain];
    }
    
    _treatmentLabel.text = foodTreatment.officeName;
    _treatmentCategoryLabel.text = [NSString stringWithFormat:@"%@...",foodTreatment.diseaseNames];

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
