//
//  FoodModel.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

- (void)dealloc
{
    [_vegetable_id release];          //菜式编号
    [_name release];                 //菜式名称
    [_englishName release];          //菜式拼音名称
    [_fittingRestriction release];    //原料
    [_method release];                //调料
    [_imagePathLandscape release];    //图片
    [_imagePathPortrait release];     //详情图片
    [_imagePathThumbnails release];   //列表图片
    [_vegetableCookingId release];    //烹饪ID
    [_materialVideoPath release];     //材料视频
    [_productionProcessPath release]; //制作视频
    [_timeLength release];            //烹饪时间
    [_taste release];                  //口味
    [_cookingMethod release];         //烹饪方法
    [_effect release];                //功效
    [_fittingCrowd release];          //适合人群
    [_agreementAmount release];       //点赞
    [_clickCount release];            //收藏数量
    [_downloadCount release];         //踩
    
    [_order_id release];              //步骤编号
    [_describe release];              //详细步骤
    [_imagePath release];             //步骤图片
    
    [_imageCorrelation release];      //相关事宜图片
    [_nutritionAnalysis release];     //食材简介
    [_productionDirection release];   //制作指导
    
    [_materialName release];           //食材名
    [_materialImage release];          //食材小图
    [_MaterialFoodName release];       //相宜食材名
    [_MaterialFoodImage release];      //相宜食材小图
    [_contentDescription release];//相宜食材好处

    [_caralogName release];
    [_childCatalogName release];
    [_imagePathName release];
    [_vegetableCatalogId release];
    [_catalogId release];
    [_vegetableChildCatalogId release];
    
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.vegetable_id forKey:@"vegetable_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.englishName forKey:@"englishName"];
    [aCoder encodeObject:self.fittingRestriction forKey:@"fittingRestriction"];
    [aCoder encodeObject:self.method forKey:@"method"];
    [aCoder encodeObject:self.imagePathLandscape forKey:@"imagePathLandscape"];
    [aCoder encodeObject:self.imagePathPortrait forKey:@"imagePathPortrait"];
    [aCoder encodeObject:self.imagePathThumbnails forKey:@"imagePathThumbnails"];
    [aCoder encodeObject:self.vegetableCookingId forKey:@"vegetableCookingId"];
    [aCoder encodeObject:self.timeLength forKey:@"timeLength"];
    [aCoder encodeObject:self.taste forKey:@"taste"];
    [aCoder encodeObject:self.cookingMethod forKey:@"cookingMethod"];
    [aCoder encodeObject:self.effect forKey:@"effect"];
    [aCoder encodeObject:self.fittingCrowd forKey:@"fittingCrowd"];
    [aCoder encodeObject:self.agreementAmount forKey:@"agreementAmount"];
    [aCoder encodeObject:self.clickCount forKey:@"clickCount"];
    [aCoder encodeObject:self.downloadCount forKey:@"downloadCount"];
    [aCoder encodeBool:self.isFavorite forKey:@"isFavorite"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
         self.vegetable_id = [aDecoder decodeObjectForKey:@"vegetable_id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.englishName = [aDecoder decodeObjectForKey:@"englishName"];
        self.fittingRestriction = [aDecoder decodeObjectForKey:@"fittingRestriction"];
        self.method = [aDecoder decodeObjectForKey:@"method"];
        self.imagePathLandscape = [aDecoder decodeObjectForKey:@"imagePathLandscape"];
        self.imagePathPortrait = [aDecoder decodeObjectForKey:@"imagePathPortrait"];
        self.imagePathThumbnails = [aDecoder decodeObjectForKey:@"imagePathThumbnails"];
        self.vegetableCookingId = [aDecoder decodeObjectForKey:@"vegetableCookingId"];
        self.timeLength = [aDecoder decodeObjectForKey:@"timeLength"];
        self.taste = [aDecoder decodeObjectForKey:@"taste"];
        self.cookingMethod = [aDecoder decodeObjectForKey:@"cookingMethod"];
        self.effect = [aDecoder decodeObjectForKey:@"effect"];
        self.fittingCrowd = [aDecoder decodeObjectForKey:@"fittingCrowd"];
        self.agreementAmount = [aDecoder decodeObjectForKey:@"agreementAmount"];
        self.clickCount = [aDecoder decodeObjectForKey:@"clickCount"];
        self.downloadCount = [aDecoder decodeObjectForKey:@"downloadCount"];
        self.isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
        
        
        
    }

    return self;
}



@end
