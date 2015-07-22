//
//  MenuViewController.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateModel;

@interface MenuViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain) DateModel * date;



@end
