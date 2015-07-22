//
//  FoodModel.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel : NSObject<NSCoding>


@property (nonatomic,retain) NSString * vegetable_id;           //菜式编号

@property (nonatomic,retain) NSString * vegetableId;           //菜式编号

@property (nonatomic,retain) NSString * name;                   //菜式名称

@property (nonatomic,retain) NSString * englishName;            //菜式拼音名称

@property (nonatomic,retain) NSString * fittingRestriction;     //原料

@property (nonatomic,retain) NSString * method;                 //调料

@property (nonatomic,retain) NSString * imagePathLandscape;     //首页图片

@property (nonatomic,retain) NSString * imagePathPortrait;      //详情图片

@property (nonatomic,retain) NSString * imagePathThumbnails;    //列表图片

@property (nonatomic,retain) NSString * vegetableCookingId;     //烹饪ID

@property (nonatomic,retain) NSString * materialVideoPath;      //材料视频

@property (nonatomic,retain) NSString * productionProcessPath;  //制作视频

@property (nonatomic,retain) NSString * timeLength;             //烹饪时间

@property (nonatomic,retain) NSString * taste;                  //口味

@property (nonatomic,retain) NSString * cookingMethod;          //烹饪方法

@property (nonatomic,retain) NSString * effect;                 //功效

@property (nonatomic,retain) NSString * fittingCrowd;           //适合人群

@property (nonatomic,retain) NSString * agreementAmount;        //点赞

@property (nonatomic,retain) NSString * clickCount;             //收藏数量

@property (nonatomic,retain) NSString * downloadCount;          //踩

#pragma mark ----------------- 详情_做法 -----------------

@property (nonatomic,retain) NSString * order_id;               //步骤编号

@property (nonatomic,retain) NSString * describe;               //详细步骤

@property (nonatomic,retain) NSString * imagePath;              //详情

#pragma mark ----------------- 详情_相关常识 -----------------

@property (nonatomic,retain) NSString * imageCorrelation;       //相关常识图片

@property (nonatomic,retain) NSString * nutritionAnalysis;      //食材简介

@property (nonatomic,retain) NSString * productionDirection;    //制作指导

#pragma mark ----------------- 详情_相宜相克 -----------------

@property (nonatomic,retain) NSString * materialName;            //食材名

@property (nonatomic,retain) NSString * materialImage;           //食材小图

@property (nonatomic,retain) NSString * MaterialFoodName;           //相宜(忌讳)食材名

@property (nonatomic,retain) NSString * MaterialFoodImage;           //相宜(忌讳)食材小图

@property (nonatomic,retain) NSString * contentDescription;       //相宜(忌讳)食材好处

#pragma mark ----------------- 是否收藏 -----------------

@property (nonatomic,assign) BOOL       isFavorite;//是否收藏


#pragma mark-------------------万道美食----------------------

@property (nonatomic,retain)NSString * caralogName;                //scrollview上的十个种类名

@property (nonatomic,retain)NSString * childCatalogName;           //弹出隐藏栏上八个菜名

@property (nonatomic,retain)NSString * imagePathName;             //八个菜名的图片

@property(nonatomic,retain)NSString  * vegetableCatalogId;   //分类Id

@property(nonatomic,retain)NSString  * catalogId;   //更小分类Id

@property(nonatomic,retain)NSString  * vegetableChildCatalogId ;  //更小分类的对应的接口Id

@end
