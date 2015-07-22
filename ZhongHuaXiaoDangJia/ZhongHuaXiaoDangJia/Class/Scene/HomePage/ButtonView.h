//
//  ButtonView.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonView : UIView

@property(nonatomic,retain)UIButton * button;

//首页的
- (instancetype)initWithFrame:(CGRect)frame loadView:(NSString*)imageName labelName:(NSString*)labelName changeImage:(NSString*)changeName;

//详情的
- (instancetype)initWithFrame:(CGRect)frame labelName:(NSString*)labelName loadView:(NSString*)imageName changeImage:(NSString*)changeName;


@end
