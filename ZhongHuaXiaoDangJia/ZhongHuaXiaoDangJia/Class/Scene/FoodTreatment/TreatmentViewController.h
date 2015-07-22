//
//  TreatmentViewController.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodTreatmentViewController;

@interface TreatmentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)FoodTreatmentViewController  * footVC;
//前一个页面处理的数据得到的数组
@property(nonatomic,retain)NSMutableArray  * foodArray;
//前一个页面点击的cell的索引
@property(nonatomic,assign)NSUInteger   indexPathRow;

@end
