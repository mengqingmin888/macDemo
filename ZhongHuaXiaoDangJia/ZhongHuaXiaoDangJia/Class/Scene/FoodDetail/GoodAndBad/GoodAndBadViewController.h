//
//  GoodAndBadViewController.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-19.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodModel;

@interface GoodAndBadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) FoodModel * goodAndBadFood;

@end
