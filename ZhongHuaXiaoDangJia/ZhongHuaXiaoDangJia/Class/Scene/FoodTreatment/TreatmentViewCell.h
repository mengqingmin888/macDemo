//
//  DiseaseViewCell.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodTreatment;

@interface TreatmentViewCell : UITableViewCell

//病症图片view
@property(nonatomic,retain,readonly)UIImageView   * diseaseView;
//病症名称label
@property(nonatomic,retain,readonly)UILabel   * diseaseLabel;

@property(nonatomic,retain)FoodTreatment  * foodTreatment;


@end