//
//  FoodDetailViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodDetailView.h"
#import "HomePageViewController.h"
#import "StepTableViewController.h"
#import "CorrelationViewController.h"
#import "GoodAndBadViewController.h"
#import "UIImageView+WebCache.h"
#import "FoodModel.h"
#import "MBProgressHUD.h"
#import "MarqueeLabel.h"
#import "DatabaseHandle.h"

#import "Reachability.h"




@interface FoodDetailViewController ()
{
    UIView * _rightView;
}

@property (nonatomic,retain) FoodDetailView * detailView;

@property (nonatomic,retain) MBProgressHUD * hud;

@end

@implementation FoodDetailViewController

- (void)dealloc
{
    self.detailFood = nil;
    self.detailView = nil;
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
    self.detailView = [[[FoodDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _detailView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.title = @"美食详情";
    
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    //左上方返回图标
    UIImage * backImage = [[UIImage imageNamed:@"btn_nav_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加左边按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
    
    _rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
    _rightView.backgroundColor = [UIColor clearColor];
    
    //添加分享按钮
    UIImage * shareImage = [[UIImage imageNamed:@"分享911.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    //button.backgroundColor = [UIColor cyanColor];
    [button setBackgroundImage:shareImage forState:UIControlStateNormal];
    button.frame = CGRectMake(36,0, 33, 44);
    [button addTarget:self action:@selector(didShareButtonItemAction:)forControlEvents:UIControlEventTouchUpInside];
    [_rightView addSubview:button];
    
    
    
    [self p_setupSelfView];
    
    
        
}


- (void)p_setupSelfView
{
    
    //做法按钮添加响应方法
    [_detailView.stepButton.button addTarget:self action:@selector(didClickStepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //相关常识按钮添加响应方法
    [_detailView.correlationButton.button addTarget:self action:@selector(didClickCorrelationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //相宜相克按钮添加响应方法
    [_detailView.goodAndBadButton.button addTarget:self action:@selector(didClickGoodAndBadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加占位图
    _detailView.FoodImageView.image = [UIImage imageNamed:@"占位图"];
    //判断添加导航栏右侧按钮
    [self addRightBarButtonItem];
    
    //自定义右上角buttonItem
    UIBarButtonItem * btn=[[UIBarButtonItem alloc]initWithCustomView:_rightView];
    self.navigationItem.rightBarButtonItem = btn;
    [btn release];
    
    
    //菊花
    [self p_setupProgressHud];
    
    //创建滚动框
    [self p_setupChangeLabel];
    
    //接收并显示数据
    [self showDataSource];
}  






#pragma mark ----------------- 判断添加收藏按钮 -----------------
//添加导航栏右侧按钮
- (void)addRightBarButtonItem
{
    if (_isRightBarButtonItemAppear == YES) {
        //右上方按钮图标
        UIImage * favoriteImage = [[UIImage imageNamed:@"shixin.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //添加收藏按钮
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        //button.backgroundColor = [UIColor cyanColor];
        [button setBackgroundImage:favoriteImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0,0, 33, 44);
        [button addTarget:self action:@selector(didFavoriteButtonItemAction:)forControlEvents:UIControlEventTouchUpInside];
        [_rightView addSubview:button];
    }
}

#pragma mark ----------------- 创建滚动框 -----------------
//创建滚动框
- (void)p_setupChangeLabel
{
    MarqueeLabel *durationLabel = [[MarqueeLabel alloc] initWithFrame:CGRectMake(220, 20/568.0 * kScreen_height, 80, 20) duration:8.0 andFadeLength:10.0f];
    
    durationLabel.tag = 101;
    durationLabel.numberOfLines = 1;
    durationLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    durationLabel.textAlignment = 2;
    durationLabel.backgroundColor = [UIColor clearColor];
    durationLabel.textColor=[UIColor whiteColor];
    durationLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.000];
    
    durationLabel.text = @"亲~珍爱生命，远离黑暗料理~    ";
    //[NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(changeTheLabel) userInfo:nil repeats:YES];
    
    [self.view addSubview:durationLabel];
}

- (void)changeTheLabel {
    // Generate even or odd
    int i = arc4random() % 2;
    if (i == 0) {
        NSString * text =[NSString stringWithFormat:@"亲~珍爱生命，远离黑暗料理~    "];
        [(MarqueeLabel *)[self.view viewWithTag:101] setText:text];
    } else {
        NSString * text =@"亲~珍爱生命，远离黑暗料理~    ";
        [(MarqueeLabel *)[self.view viewWithTag:101] setText:text];
    }
}


#pragma mark ----------------- 显示数据 -----------------
//创建菊花
- (void)p_setupProgressHud
{
    self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.labelText = NSLocalizedString(@"加载中", nil);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}

//显示传来的值
- (void)showDataSource
{
    //显示菜名
    _detailView.nameLabel.text = _detailFood.name;
    
    //显示菜名拼音
    _detailView.englishNameLabel.text = _detailFood.englishName;
    
    //显示烹饪时间
    _detailView.timeLengthLabel.text = _detailFood.timeLength;
    
    //显示口味
    _detailView.tasteLabel.text = _detailFood.taste;
    
    //显示烹饪方法
    _detailView.cookingMethodLabel.text = _detailFood.cookingMethod;
    
    //显示功效
    _detailView.effectLabel.text = _detailFood.effect;
    
    //显示适合人群
    _detailView.fittingCrowdLabel.text = _detailFood.fittingCrowd;
    
    //显示图片
    NSURL * url = [NSURL URLWithString:_detailFood.imagePathPortrait];
    
    _detailView.FoodImageView.image = [UIImage imageNamed:@"占位图"];
    
    [self.detailView.FoodImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    //菊花结束
     [_hud hide:YES];
    
}



#pragma mark ----------------- 导航栏按钮 -----------------
//返回按钮
- (void)didBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    HomePageViewController * homeVC = [[HomePageViewController alloc]init];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [homeVC release];
    
    
}

//分享按钮
- (void)didShareButtonItemAction:(UIButton *)button
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:[NSString stringWithFormat:@"我刚学会了一道菜：“%@”，很美味的哦！想了解更多的美食嘛，尽在中华小当家(*^__^*) 嘻嘻……",_detailFood.name]
                                     shareImage:[UIImage imageNamed:@"分享图片1.png"]
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQzone,UMShareToWechatTimeline]
                                       delegate:self];
}


//收藏按钮
- (void)didFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
    
   BOOL isFavorite = [[DatabaseHandle shareInstance] isFavoriteFoodModelWithID:_detailFood.vegetable_id];
    
    if (YES == isFavorite) {
        UIAlertView  * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该菜已被收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        return;
    }
//    收藏菜品
    [[DatabaseHandle shareInstance] insertNewFood:_detailFood];
    
    UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}



#pragma mark ----------------- 页面跳转 -----------------

//做法按钮响应方法
- (void)didClickStepButtonAction:(UIButton *)button
{
    [self p_setupTabBarView:0];
    
}

//相关常识按钮响应方法
- (void)didClickCorrelationButtonAction:(UIButton *)button
{
    [self p_setupTabBarView:1];
}

//相宜相克按钮响应方法
- (void)didClickGoodAndBadButtonAction:(UIButton *)button
{
    [self p_setupTabBarView:2];
}


//创建TabBar，模态推出
- (void)p_setupTabBarView:(int)index
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    StepTableViewController * StepVC = [[StepTableViewController alloc]init];
    UINavigationController * firstNC = [[UINavigationController alloc]initWithRootViewController:StepVC];
    [firstNC.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    StepVC.stepFood = _detailFood;
    [items addObject:firstNC];
    
    
    
    CorrelationViewController * CorrelationVC = [[CorrelationViewController alloc]init];
    UINavigationController * secondNC = [[UINavigationController alloc]initWithRootViewController:CorrelationVC];
    [secondNC.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    CorrelationVC.correlationFood = _detailFood;
    [items addObject:secondNC];
    
    
    
    GoodAndBadViewController * GoodAndBadVC = [[GoodAndBadViewController alloc]init];
    UINavigationController * thirdNC = [[UINavigationController alloc]initWithRootViewController:GoodAndBadVC];
    [thirdNC.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    GoodAndBadVC.goodAndBadFood = _detailFood;
    [items addObject:thirdNC];
    
    
    //设置导航栏字体颜色
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dic = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    firstNC.navigationBar.titleTextAttributes = dic;
    secondNC.navigationBar.titleTextAttributes = dic;
    thirdNC.navigationBar.titleTextAttributes = dic;
    
    
    // items是数组，每个成员都是UIViewController
    UITabBarController * tabBar = [[UITabBarController alloc] init];
    [tabBar setViewControllers:items];
    tabBar.tabBar.barTintColor = [UIColor blackColor];
    tabBar.tabBar.tintColor = [UIColor whiteColor];
    
    tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//动画风格

    
    //设置显示第几个TabBar
    tabBar.selectedIndex = index;
    
    [self presentViewController:tabBar animated:YES completion:^{
        
    }];
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
