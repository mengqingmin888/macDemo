//
//  ButtonView.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//首页的
-(instancetype)initWithFrame:(CGRect)frame loadView:(NSString*)imageName labelName:(NSString*)labelName changeImage:(NSString*)changeName
{
    self=[self initWithFrame:frame];
    if (self) {
        //        self.backgroundColor=[UIColor redColor];
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:changeName] forState:UIControlStateSelected];
        _button.frame=CGRectMake(0,0, 64, 44);
        [self addSubview:_button];
        
        UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,24, 64, 20)];
        textLabel.text=labelName;
        textLabel.textAlignment=1;
        textLabel.textColor=[UIColor whiteColor];
        textLabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:textLabel];
    }
    return self;
}

//详情的
- (instancetype)initWithFrame:(CGRect)frame labelName:(NSString*)labelName loadView:(NSString*)imageName changeImage:(NSString*)changeName
{
    self=[self initWithFrame:frame];
    if (self) {
        //        self.backgroundColor=[UIColor redColor];
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:changeName] forState:UIControlStateSelected];
        _button.frame=CGRectMake(0,0, 320/3, 44);
        [self addSubview:_button];
        
        UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,24, 320/3, 20)];
        textLabel.text=labelName;
        textLabel.textAlignment=1;
        textLabel.textColor=[UIColor whiteColor];
        textLabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:textLabel];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
