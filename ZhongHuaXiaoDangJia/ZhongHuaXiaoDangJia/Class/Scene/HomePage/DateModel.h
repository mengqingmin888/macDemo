//
//  DateModel.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject

//日期
@property (nonatomic,retain) NSString * GregorianCalendar;

//农历
@property (nonatomic,retain) NSString * LunarCalendar;

//生肖年
@property (nonatomic,retain) NSString * ChineseZodiacYear;

//适宜
@property (nonatomic,retain) NSString * alertInfoFitting;

//忌讳
@property (nonatomic,retain) NSString * alertInfoAvoid;



//年
@property (nonatomic,retain) NSString * year_id;

//月
@property (nonatomic,retain) NSString * month_id;

//日
@property (nonatomic,retain) NSString * day_id;



@end
