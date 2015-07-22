//
//  XiaoDangJiaAPIUrl.h
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#ifndef ZhongHuaXiaoDangJia_XiaoDangJiaAPIUrl_h
#define ZhongHuaXiaoDangJia_XiaoDangJiaAPIUrl_h


#pragma mark ----------- 对症食疗API---------------

//第一级
#define   FoodTreatmentAPI  @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tbloffice!getOffice.do?is_traditional=0"
//第二级
#define   FoodDiseaseAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tbldisease!getDisease.do?officeId="
//第三级
#define   DiseaseAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tbldisease!getVegetable.do?diseaseId="
//第四级进入详情
#define  DetailsAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getTblVegetables.do?vegetable_id="


#pragma mark ------------登陆注册-----------------

#define  LoginAPI  @"http://42.121.13.106:8080/HandheldKitchen/api/users/tbluser!register.do?username=Was&password=1234567&phoneNumber=15265853254&is_traditional=0&channel=wanpu%20store"



#pragma mark ---------------最新推出----------------



#define  NewFoodAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getNewTblVegetable.do?page=1&pageRecord=12&phonetype=2&user_id=&is_traditional=0"

#pragma mark ---------------------最受欢迎-----------------

#define BestFoodAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getHotTblVegetable.do?page=1&pageRecord=12&phonetype=2&user_id=&is_traditional=0"

#pragma mark ----------------------当月菜单--------------------

#define MenuOfMonthAPI  @"http://42.121.13.106:8080/HandheldKitchen/api/more/tblmonthlypopinfo!get.do?phonetype=2&year=%@&month=%@&user_id=&page=1&pageRecord=14&is_traditional=0"

#pragma mark -------------------万道美食任你选-------------------

#define ChoiceOfAllAPI  @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getInfo.do?phonetype=2&catalog_id=&page=1&pageRecord=10&is_traditional=0&user_id="

#define ChoiceOfAllScrollAPI  @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetablecatalog!get.do?page=1&pageRecord=18&phonetype=2&is_traditional=0"

#define  CategoryAPI  @"http://112.124.32.151:8080//HandheldKitchen/api/vegetable/tblvegetable!getInfo.do?catalog_id="
 



#pragma mark ------------ 首页时间 -----------------

//固定时间接口
#define   OldDateAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/more/tblcalendaralertinfo!get.do?year=2014&month=09&day=19&page=1&pageRecord=10&is_traditional=0"

//当天时间接口
#define   NewDateAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/more/tblcalendaralertinfo!get.do?year=2014&month=09&day=20&page=1&pageRecord=10&is_traditional=0"


#pragma mark ------------ 菜肴信息 -----------------

//首页菜谱以及菜谱详情
#define   FoodModelAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/more/tblcalendaralertinfo!getHomePage.do?phonetype=2&page=page_id&pageRecord=16&user_id=&is_traditional=0"

//材料
#define   MaterialAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=vegetable_number&type=1&phonetype=0&is_traditional=0"

//做法
#define   StepAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=vegetable_number&type=2&phonetype=0&is_traditional=0"

//相宜相克
#define   GoodAndBadAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=vegetable_number&type=3&phonetype=0&is_traditional=0"

//相关常识
#define   RelevantAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=vegetable_number&type=4&phonetype=0&is_traditional=0"




//搜索
#define   SearchAPI   @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getVegetableInfo.do?"







#endif
