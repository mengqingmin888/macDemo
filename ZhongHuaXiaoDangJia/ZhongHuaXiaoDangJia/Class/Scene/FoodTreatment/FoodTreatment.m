//
//  FoodTreatment.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FoodTreatment.h"

@implementation FoodTreatment

- (void)dealloc
{
    self.officeId = nil;
    self.officeName = nil;
    self.diseaseNames = nil;
    self.imagePath = nil;
    self.diseaseId = nil;
    self.diseaseName = nil;
    self.diseaseDescribe = nil;
    self.fitEat = nil;
    self.lifeSuit = nil;
    self.imageName = nil;
    self.vegetableId = nil;
    self.name = nil;
    self.imagePathThumbnails = nil;
    self.clickCount = nil;
    
    
    
    [super dealloc];
    
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{



}

@end
