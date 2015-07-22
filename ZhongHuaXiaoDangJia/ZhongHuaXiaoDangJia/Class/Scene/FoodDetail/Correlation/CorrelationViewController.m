//
//  CorrelationViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-19.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "CorrelationViewController.h"

#import "FoodDetailViewController.h"

#import "HomePageViewController.h"

#import "CorrelationView.h"

#import "GoodAndBadViewController.h"

#import "StepTableViewController.h"

#import "FoodModel.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

#import "NetWork.h"

@interface CorrelationViewController ()

@property (nonatomic,retain) CorrelationView * correlationView;
@property (nonatomic,retain) MBProgressHUD * hud;

@end

@implementation CorrelationViewController

- (void)dealloc
{
    self.correlationView = nil;
    self.correlationFood = nil;
    self.hud = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"iconfont-1.png"];
        self.tabBarItem.title = @"相关常识";
    }
    return self;
}

- (void)loadView
{
    self.correlationView = [[[CorrelationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = self.correlationView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    self.navigationItem.title = @"相关常识";
    
    
    //左上方返回图标
    UIImage * backImage = [[UIImage imageNamed:@"btn_nav_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加左边按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
    //菊花
    [self p_setupProgressHud];
    
    //异步链接，通过Block接受数据，并解析
    [self setupDataSourse];
    
    
}

#pragma mark -------- 创建菊花 --------
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

#pragma mark --------异步链接，通过Block接受数据，并解析--------
//异步链接，通过Block接受数据，并解析
- (void)setupDataSourse
{
    //封装网址对象
    NSString * string = RelevantAPI;
    NSString * urlString = [string stringByReplacingOccurrencesOfString:@"vegetable_number" withString:self.correlationFood.vegetable_id];
    
    //NSURL * url = [NSURL URLWithString:urlString];
    
    //设置请求
    //NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        
    [[NetWork shareInstance]loadingDataWithUrlString:urlString urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (data != nil && error == nil) {
            //data是完整数据
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers  error:nil];
            
            NSArray * oneArray = dic[@"data"];
            
            NSDictionary * foodDic = [oneArray lastObject];
            
            self.correlationFood.imageCorrelation = foodDic[@"imagePath"];
            self.correlationFood.nutritionAnalysis = foodDic[@"nutritionAnalysis"];
            self.correlationFood.productionDirection = foodDic[@"productionDirection"];
            
            
            //显示数据
            [self showDataSource];
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
                //菊花结束
        [_hud hide:YES];
        
    }];
    
    
}

#pragma mark ----------------- 赋值，显示数据 -----------------
//显示数据
- (void)showDataSource
{
    //拼接简介和制作指导
    NSString * jianjieText = [NSString stringWithFormat:@"      %@",_correlationFood.nutritionAnalysis];
    NSString * zhidaoText = [NSString stringWithFormat:@"      %@",_correlationFood.productionDirection];
    
    
     //背景scrollView的滚动范围
    _correlationView.scrollView.contentSize = CGSizeMake(kScreen_width,160 + [self.class textHeight:jianjieText] + 35 + [self.class textHeight:zhidaoText] + 15+ 64 );
    
    //显示图片
    NSURL * url = [NSURL URLWithString:_correlationFood.imageCorrelation];
    
    [_correlationView.correlationImageView sd_setImageWithURL:url];
    
    //简介
    _correlationView.nutritionAnalysisLabel.text = jianjieText;
    _correlationView.nutritionAnalysisLabel.frame = CGRectMake(20, 160, 280, [self.class textHeight:jianjieText]);
    
    //分割线
    _correlationView.xuXianImageView.frame = CGRectMake(20, 160 + [self.class textHeight:jianjieText] + 4, 280, 1);
    
    //“制作指导”
    _correlationView.zhiDaoLabel.frame = CGRectMake(20, 160 + [self.class textHeight:jianjieText] + 15, 90, 20);
    
    //制作指导
    _correlationView.productionDirectionLabel.text = zhidaoText;
    _correlationView.productionDirectionLabel.frame = CGRectMake(20, 160 + [self.class textHeight:jianjieText] + 35, 280, [self.class textHeight:zhidaoText]);
    
    
}

//计材料文本的高度
+ (CGFloat)textHeight:(NSString *)text
{
    
    NSDictionary * textDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(250, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    
    
    return textRect.size.height;
}




#pragma mark ----------------- 导航栏按钮 -----------------
//返回按钮
- (void)didBackButtonItemAction:(UIBarButtonItem *)buttonItem
{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

//首页按钮
- (void)didHomeButtonItemAction:(UIBarButtonItem *)buttonItem
{
    
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[HomePageViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
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
