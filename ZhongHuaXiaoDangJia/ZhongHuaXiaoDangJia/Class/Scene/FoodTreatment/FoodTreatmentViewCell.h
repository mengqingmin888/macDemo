//
//  FoodTreatmentViewCell.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodTreatment;

@interface FoodTreatmentViewCell : UITableViewCell

//病症图片view
@property(nonatomic,retain,readonly)UIImageView   * treatmentView;
//病症名称label
@property(nonatomic,retain,readonly)UILabel   * treatmentLabel;
//病症分类label
@property(nonatomic,retain,readonly)UILabel   * treatmentCategoryLabel;

@property(nonatomic,retain)FoodTreatment  * foodTreatment;



@end
