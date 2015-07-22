//
//  AppDelegate.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  DDMenuController;

@class Reachability;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,retain)Reachability * hostReach;

@property (retain, nonatomic) UIWindow *window;

@property(retain,nonatomic)DDMenuController  *menuController;

//创建根视图
- (void)setupViewController;

@end
