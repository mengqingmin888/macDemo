//
//  FoodTreatment.h
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodTreatment : NSObject

//病症ID
@property(nonatomic,retain)NSString  * officeId;
//病症名称
@property(nonatomic,retain)NSString  * officeName;
//病症分类
@property(nonatomic,retain)NSString  * diseaseNames;
//病症相关图片地址
@property(nonatomic,retain)NSString  * imagePath;

//下一级
//疾病ID
@property(nonatomic,retain)NSString  * diseaseId;
//疾病名称
@property(nonatomic,retain)NSString  * diseaseName;
//疾病简介
@property(nonatomic,retain)NSString  * diseaseDescribe;
//饮食保健
@property(nonatomic,retain)NSString  * fitEat;
//生活保健
@property(nonatomic,retain)NSString  * lifeSuit;
//疾病相关图片地址
@property(nonatomic,retain)NSString  * imageName;

//菜品ID
@property(nonatomic,retain)NSString  * vegetableId;
//菜品名称
@property(nonatomic,retain)NSString  * name;
//菜品小图片地址
@property(nonatomic,retain)NSString  * imagePathThumbnails;
//收藏量
@property(nonatomic,retain)NSString  * clickCount;


@end
