//
//  HomePageViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "HomePageViewController.h"

#import "HomePageView.h"

#import "FoodTreatmentViewController.h"
#import "FoodDetailViewController.h"
#import "BestFavoriteViewController.h"
#import "MenuViewController.h"
#import "NewViewController.h"
#import "ChoiceAllViewController.h"

#import "FoodModel.h"
#import "DateModel.h"
#import "DDMenuController.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

#import "Reachability.h"
#import "DDMenuController.h"
#import "NetWork.h"


#import "KGStatusBar.h"

@interface HomePageViewController ()
{
    int _pageNumber;
    int _page_id;
}

@property (nonatomic,retain) HomePageView * homeView;

@property (nonatomic,retain) NSMutableArray * allFootArray;

@property (nonatomic,retain) DateModel * date;

@property (nonatomic,retain) MBProgressHUD * hud;

@property (nonatomic,retain) NSMutableArray * array;

@end

@implementation HomePageViewController

- (void)dealloc
{
    self.homeView = nil;
    self.allFootArray = nil;
    self.date = nil;
    
    self.hud = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.homeView = [[[HomePageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = self.homeView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置导航栏标题
    self.navigationItem.title = @"中华小当家";
    
    //设置导航栏背景图片
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    
//    //右侧刷新按钮
//    UIImage * refreshImage = [[UIImage imageNamed:@"iconfont-shuaxin.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem * refreshItem = [[UIBarButtonItem alloc]initWithImage:refreshImage style:UIBarButtonItemStylePlain target:self action:@selector(didClickRefreshItemAction:)];
//    self.navigationItem.rightBarButtonItem = refreshItem;
//    [refreshItem release];
    
    //关闭反弹效果
    _homeView.imageScroll.bounces = NO;
    
    
    //pageControl添加响应方法
    [_homeView.pageControl addTarget:self action:@selector(handleChangeImageView:) forControlEvents:UIControlEventValueChanged];
    
    //
    //对症食疗按钮添加响应方法
    [_homeView.TreatmentButton.button addTarget:self action:@selector(didClickTreatmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //最受欢迎按钮添加响应方法
    [_homeView.BestFavoriteButton.button addTarget:self action:@selector(didClickBestFavoriteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //最新推出按钮添加响应方法
    [_homeView.NewFoodButton.button addTarget:self action:@selector(didClickNewFoodButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //每月美食按钮添加响应方法
    [_homeView.MenuOfMonthButton.button addTarget:self action:@selector(didClickMenuOfMonthButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //万道美食任你选添加响应方法
    [_homeView.MuchFoodButton.button addTarget:self action:@selector(didClickMuchFoodButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //设置根视图中scrollView的代理方法
    _homeView.imageScroll.delegate = self;
    
    
    //菊花
    [self p_setupProgressHud];
    
    //初始化page_id
    _page_id = 1;
    
    
    //请求网络数据
    [self setDataSource];
    
    
    //给菜肴图片添加轻拍手势
    [self addTapToFoodImage];
    
    
    
}


#pragma mark -------- 刷新界面 --------
- (void)didClickRefreshItemAction:(UIBarButtonItem *)buttonItem
{
//    self.allFootArray = [NSMutableArray arrayWithCapacity:40];
    
    //初始化page_id
    _page_id = 1;
    
    
    //请求网络数据
    [self setDataSource];
    
}




#pragma mark -------- 创建菊花 --------
//创建菊花
- (void)p_setupProgressHud
{
    self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.labelText = NSLocalizedString(@"加载中", nil);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    [_hud hide:YES afterDelay:5.0];
    
    [_hud show:YES];
}


#pragma mark ----------------- 数据处理 -----------------


//请求时间网络数据
- (void)setDataSource
{
    //********************** 解析时间 **********************
    //封装网址对象
    NSString * string = OldDateAPI;
    
    __block HomePageViewController * homePageVC = self;
    
    
    [[NetWork shareInstance]loadingDataWithUrlString:string urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data != nil && error == nil) {
            NSDictionary * dateDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * dateArray = dateDic[@"data"];
            
            NSDictionary * oneDic = [dateArray lastObject];
            
            homePageVC.date = [[DateModel alloc]init];
            
            _date.GregorianCalendar  = oneDic[@"GregorianCalendar"];
            
            
            
            homePageVC.date.year_id = [_date.GregorianCalendar substringWithRange:NSMakeRange(0, 4)];
            homePageVC.date.month_id = [_date.GregorianCalendar substringWithRange:NSMakeRange(5, 2)];
            homePageVC.date.day_id = [_date.GregorianCalendar substringWithRange:NSMakeRange(8, 2)];
            
            
            
            //解析新日期
            
            //封装网址对象
            NSString * dateString = [NSString stringWithFormat:@"http://42.121.13.106:8080/HandheldKitchen/api/more/tblcalendaralertinfo!get.do?year=%@&month=%@&day=%@&page=1&pageRecord=10&is_traditional=0",_date.year_id,_date.month_id,_date.day_id];
            // NSURL * url = [NSURL URLWithString:string];
            
            //设置请求
            //NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
            
            
            [[NetWork shareInstance]loadingDataWithUrlString:dateString urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
                
                if (data != nil && error == nil) {
                    NSDictionary * dateDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    NSArray * dateArray = dateDic[@"data"];
                    
                    NSDictionary * oneDic = [dateArray lastObject];
                    
                    self.date = [[DateModel alloc]init];
                    
                    [_date setValuesForKeysWithDictionary:oneDic];
                    
                    
                    //显示数据
                    [self p_showDateSource];
                    
                    //[homePageVC.view reloadInputViews];
                    homePageVC.hud.hidden=YES;
                }
                else {
                    [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
                }
                
            }];
            
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        
        
    }];
    
    
    
    
    //********************** 解析菜肴 **********************
//    if (_page_id == 4) {
//        //self.view.userInteractionEnabled = YES;
//        //[_hud hide:YES];
//        return;
//    }
//    _page_id++;
    
    //封装网址对象
    NSString * string2 = FoodModelAPI;
    NSString * urlString = [string2 stringByReplacingOccurrencesOfString:@"page_id" withString:[NSString stringWithFormat:@"%d",_page_id]];
    
    
//    if (self.allFootArray == nil) {
        self.allFootArray = [NSMutableArray arrayWithCapacity:40];
//    }
    
    
    
    [[NetWork shareInstance]loadingDataWithUrlString:urlString urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        
        if (data != nil && error == nil) {
            NSDictionary * foodDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * foodArray = foodDic[@"data"];
            
            for (NSDictionary * oneFoodDic in foodArray) {
                
                FoodModel * onefood = [[FoodModel alloc]init];
                
                [onefood setValuesForKeysWithDictionary:oneFoodDic];
                
                [homePageVC.allFootArray addObject:onefood];
                
                
                
                [onefood release];
                
            }
            
            
            
            //传值
            _homeView.dataArray = _allFootArray;
            
            //Block函数
            _homeView.sucessBlock(@"Fuck You!");
            
            //设置滚动范围和分页
            [homePageVC setScrollAndPage];
            
            //显示数据
            [homePageVC showDataSource];
            
            homePageVC.hud.hidden=YES;
            
            //homePageVC.view.userInteractionEnabled = YES;
            
            
            
            //[homePageVC.view reloadInputViews];
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        
    }];
    
}

//
////解析新日期
//- (void)setupNewDateSource
//{
//    //封装网址对象
//    NSString * dateString = [NSString stringWithFormat:@"http://42.121.13.106:8080/HandheldKitchen/api/more/tblcalendaralertinfo!get.do?year=%@&month=%@&day=%@&page=1&pageRecord=10&is_traditional=0",_date.year_id,_date.month_id,_date.day_id];
//   // NSURL * url = [NSURL URLWithString:string];
//    
//    //设置请求
//    //NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
//    
//    
//    __block HomePageViewController * homePageVC = self;
//    
//    
//    [NetWork loadingDataWithUrlString:dateString downloadSuccess:^(NSData *data) {
//        
//        NSDictionary * dateDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        NSArray * dateArray = dateDic[@"data"];
//        
//        NSDictionary * oneDic = [dateArray lastObject];
//        
//        self.date = [[DateModel alloc]init];
//        
//        [_date setValuesForKeysWithDictionary:oneDic];
//        
//        //显示数据
//        [self p_showDateSource];
//        
//        [homePageVC.view reloadInputViews];
//        
//        
//    }];
//    
//    
//    
//}



#pragma mark ----------------- 赋值，显示数据 -----------------
//显示时间数据
- (void)p_showDateSource
{
    //阳历日期
    _homeView.dateLabel.text = _date.GregorianCalendar;
    
    //农历
    _homeView.lunarCalendarLabel.text = _date.LunarCalendar;
    
    //生肖年
    _homeView.yearLabel.text = _date.ChineseZodiacYear;
    
    //适宜
    _homeView.alertInfoFittingLabel.text = _date.alertInfoFitting;
    
    //忌讳
    _homeView.alertInfoAvoidLabel.text = _date.alertInfoAvoid;
    
}

//设置滚动范围和分页
- (void)setScrollAndPage
{
    //scrollView的滚动范围
    _homeView.imageScroll.contentSize = CGSizeMake(320 * [_allFootArray count],kScreen_height - 44- 64);
    
    
    //pageControl的个数
    _homeView.pageControl.numberOfPages = [_allFootArray count];

}

//显示菜肴数据
- (void)showDataSource
{
        
    //获取菜肴信息
    FoodModel * showFood = _allFootArray[_pageNumber];
    
    //菜肴名称
    _homeView.nameLabel.text = showFood.name;
    
    //菜名拼音
    _homeView.englishNameLabel.text = showFood.englishName;
    
    
}

#pragma mark ----------------- 代理方法 -----------------

//scrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int x = scrollView.contentOffset.x;
    
//    if (x > 320 * (_allFootArray.count -1)) {
//        self.view.userInteractionEnabled = YES;
//
//        
//        if (x > 9280) {
//            
//            if ([self isConnectionAvailable] == YES) {
//                //请求网络数据
//                [self setDataSource];
//                _hud.hidden=YES;
//            }
//            
//        }
//        else{
//            
//            
//            if ([self isConnectionAvailable] == YES) {
//                //菊花
//                [self p_setupProgressHud];
//                //请求网络数据
//                [self setDataSource];
//               
//            }else{
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
//                hud.removeFromSuperViewOnHide =YES;
//                //hud.mode = MBProgressHUDModeText;
//                hud.labelText = NSLocalizedString(@"加载失败", nil);
//                hud.minSize = CGSizeMake(132.f, 108.0f);
//                [hud hide:YES afterDelay:1];
//            }
//           
//        }
//        
//    }
    
    
    _pageNumber = x / scrollView.bounds.size.width;
    
    //页码
    _homeView.pageControl.currentPage = _pageNumber;
    
    //显示菜名
    [self showDataSource];
    
    //self.hud.hidden=YES;
    
}

//pageControl添加响应方法
- (void)handleChangeImageView:(UIPageControl *)pageControl
{
    
    int x = pageControl.currentPage * _homeView.imageScroll.bounds.size.width;

    [_homeView.imageScroll setContentOffset:CGPointMake(x, 0) animated:YES];
    
    [self showDataSource];
    
}


#pragma mark ----------------- 图片轻拍手势 -----------------
//给菜肴图片添加轻拍手势
- (void)addTapToFoodImage
{
    _homeView.imageScroll.userInteractionEnabled = YES;
    
    //创建一个手势识别器对象
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    
    
    //将手势识别器指定给需要响应手势的视图
    [_homeView.imageScroll addGestureRecognizer:tapGesture];
    
    [tapGesture release];
}

//手势识别器在识别出手势后，触发的方法
- (void)handleTapGesture:(UITapGestureRecognizer *)gesture
{
    
    if ([self isConnectionAvailable] == YES) {
        FoodDetailViewController * detailVC = [[FoodDetailViewController alloc]init];
    
        //获取菜肴信息
        FoodModel * showFood = _allFootArray[_pageNumber];
        
        detailVC.detailFood = showFood;
        
        //是否添加导航栏右侧按钮
        detailVC.isRightBarButtonItemAppear = YES;
        
        [self.navigationController pushViewController:detailVC animated:YES];
        
        [detailVC release];
    }
    else{
        [KGStatusBar showErrorWithStatus:@"网络错误，请检查"];
    }
    
    
}

#pragma mark ----------------- 页面跳转 -----------------

//对症食疗按钮触发
- (void)didClickTreatmentButtonAction:(UIButton *)button
{
    FoodTreatmentViewController * footTreatmentVC = [[FoodTreatmentViewController alloc]init];
    
    [self.navigationController pushViewController:footTreatmentVC animated:YES];
    
    [footTreatmentVC release];
}

//对症食疗按钮触发
- (void)didClickBestFavoriteButtonAction:(UIButton *)button
{
    BestFavoriteViewController * bestFavoriteVC = [[BestFavoriteViewController alloc]init];
    
    [self.navigationController pushViewController:bestFavoriteVC animated:YES];
    
    [bestFavoriteVC release];
}

//最新推出按钮触发
- (void)didClickNewFoodButtonAction:(UIButton *)button
{
    NewViewController * bestFavoriteVC = [[NewViewController alloc]init];
    
    [self.navigationController pushViewController:bestFavoriteVC animated:YES];
    
    [bestFavoriteVC release];
}

//每月美食按钮触发
- (void)didClickMenuOfMonthButtonAction:(UIButton *)button
{
    MenuViewController * menuVC = [[MenuViewController alloc]init];
    
    menuVC.date = self.date;
    
    [self.navigationController pushViewController:menuVC animated:YES];
    
    [menuVC release];
}

//万道美食任你选按钮触发
- (void)didClickMuchFoodButtonAction:(UIButton *)button
{
    ChoiceAllViewController * choiceVC = [[ChoiceAllViewController alloc] init];
    
    
    [self.navigationController pushViewController:choiceVC animated:YES];
    [choiceVC release];
    
}


#pragma mark ----------------- UIAlertView代理 -----------------

//UIAlertView代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
   _page_id = 1;
   
   //请求网络数据
   [self setDataSource];
   
   
    
}




#pragma mark ----------------- 网络判断 -----------------

-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            
            break;
    }
    
    if (!isExistenceNetwork) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
        hud.removeFromSuperViewOnHide =YES;
        //hud.mode = MBProgressHUDModeText;
        hud.labelText = NSLocalizedString(@"加载失败", nil);
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:2];
        
        
        return NO;
    }
    
    return isExistenceNetwork;
}







//
//-(BOOL)checkNetwork{
//    
//    NetworkStatus status = [self.ymNetwork currentReachabilityStatus];
//    self.result = YES;
//    if (status==kNotReachable) {
//        
//
//        
//    }else if ((status==kReachableViaWWAN )|| (status==kReachableViaWiFi)){
//        
//
//        [self performSelector:@selector(viewDidLoad)];
//        
//        self.result = NO;
//        
//
//        
//    }
//    return self.result;
//}
//
//-(void)changeNetworkMainFrame:(NSNotification *)notification{
//    
//    
//    [self checkNetwork];
//}




- (void)reachabilityChanged:(NSNotification *)note{
    Reachability * curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
//    Reachability * curReach = [Reachability reachabilityWithHostName:@"www.apple.com"];
   
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        //self.navigationController.view.userInteractionEnabled = NO;
        //self.view.userInteractionEnabled = NO;
        
//        UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络中断" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alter show];
//        [alter release];
        
    }
    else if ((status== ReachableViaWWAN )|| (status== ReachableViaWiFi)){
        self.navigationController.view.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
        self.allFootArray = [NSMutableArray arrayWithCapacity:30];
        [self performSelector:@selector(viewDidLoad)];
        
//        DDMenuController  * menuController  = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
////        
////        HomePageViewController  * homeVC = [[HomePageViewController alloc] init];
////        
////        UINavigationController  * rootNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
//        
//        UINavigationController  * rootNC = menuController.rootVCS[0];
//        
//        //设置导航栏字体颜色
//        UIColor * color = [UIColor whiteColor];
//        //UIFont * font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
//        NSDictionary * dic = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
//        rootNC.navigationBar.titleTextAttributes = dic;
//        
//        
//        //[menuController showRootController:YES];
//        [menuController setRootController:rootNC animated:YES];
        
    
        
    }
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
