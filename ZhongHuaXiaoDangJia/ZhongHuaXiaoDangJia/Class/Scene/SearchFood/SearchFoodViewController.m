//
//  SearchFoodViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-25.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "SearchFoodViewController.h"

#import "SearchFoodCell.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

#import "FoodDetailViewController.h"

#import "FoodModel.h"

#import "MJRefresh.h"

#import "DDMenuController.h"

#import "Reachability.h"

#import "NetWork.h"


@interface SearchFoodViewController ()
{
    UICollectionView *_collectionView;
    NSString  * _url;
}
//存储数据的数组
@property(nonatomic,retain)NSMutableArray * searchFootArray;
//缓存
@property(nonatomic,retain)MBProgressHUD * hud;

@end

@implementation SearchFoodViewController

- (void)dealloc
{
    [_collectionView release];
    
    [_url release];
    self.searchFootArray = nil;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = @"搜索结果";
    
    //导航栏背景图片
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    //背景颜色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    
    
    
    [self p_setupSelfView];
    
    
    
    
    
    
}


- (void)p_setupSelfView
{
    //处理接口
    //接收搜索框传来的关键字
    NSString * text = [self.searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //封装网址对象
    NSString * string = SearchAPI;
    _url = [NSString stringWithFormat:@"%@name=%@&child_catalog_name=&taste=&fitting_crowd=&cooking_method=&effect=&pageRecord=14&phonetype=2&user_id=&is_traditional=0&page=1",string,text];
    
    
    //创建集合视图
    [self setupSubviews];
    
    //菊花
    [self p_setupProgressHud];
    
    //数据解析
    [self setDataSource:_url];
    
    //调用上拉加载，把自定义数组空间放在这
     self.searchFootArray = [NSMutableArray arrayWithCapacity:40];
    
    //调用加载数据
    [self setupRefresh];
}



#pragma mark ----------------- 创建集合视图 -----------------
//创建UICollectionFlowLayout
- (void)setupSubviews
{
    //创建collectionView的布局，系统的网格样式
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //创建一个集合视图
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height - 64) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [flowLayout release];
    //最小列间距
    flowLayout.minimumInteritemSpacing = 0;
    
    //最小行间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //注册集合视图中使用的Cell类型及重用标识
    [_collectionView registerClass:[SearchFoodCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark ----------------- 菊花 -----------------
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


#pragma mark ----------------- 数据解析 -----------------
//请求菜肴网络数据
- (void)setDataSource:(NSString *)dataUrl
{
    
    
    //设置请求
    //NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    
    //self.searchFootArray = [NSMutableArray arrayWithCapacity:40];
    
    __block SearchFoodViewController * searchVC = self;
    
    [[NetWork shareInstance]loadingDataWithUrlString:dataUrl urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error)   {
        if (data != nil && error == nil) {
            NSDictionary * foodDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * foodArray = foodDic[@"data"];
            
            for (NSDictionary * oneFood in foodArray) {
                
                FoodModel * food = [[FoodModel alloc]init];
                
                [food setValuesForKeysWithDictionary:oneFood];
                
                [searchVC.searchFootArray addObject:food];
                
                ;
                
                [food release];
                
            }
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        
        //数据重载
        [_collectionView reloadData];
        
        [_hud hide:YES];
        
        //判断是否搜索到菜肴
        if (_searchFootArray.count == 0) {
            UIAlertView  * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"没有相关的菜肴" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertView.tag = 123;
            [alertView show];
            [alertView release];
            
        }
        
        //homePageVC.view.userInteractionEnabled = YES;
        
        //[homePageVC.view reloadInputViews];
        
    }];
   
    
}


#pragma mark ----------------- 集合视图代理方法 -----------------
//分区数[必须实现]
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section有几个items[必须实现]
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_searchFootArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchFoodCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    FoodModel * food = _searchFootArray[indexPath.row];
    cell.searchFood = food;
    
    NSURL * url = [NSURL URLWithString:food.imagePathThumbnails];
    [cell.showImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"sdefaultImage"]];
    
    return cell;
}

//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 126);
}


//进入详情页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController * foodVC = [[FoodDetailViewController alloc] init];
    
    FoodModel * showFood = _searchFootArray[indexPath.row];
    
    foodVC.detailFood = showFood;
    
    //是否添加导航栏右侧按钮
    foodVC.isRightBarButtonItemAppear = YES;
    
    [self.navigationController pushViewController:foodVC animated:YES];
    
    [foodVC release];
}


#pragma mark------------------上拉加载跟多数据的方法----------------------

- (void)setupRefresh
{
    // 上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_collectionView addFooterWithTarget:self action:@selector(footerRefresh)];
    
    _collectionView.footerPullToRefreshText = @"上拉可以加载更多数据";
    _collectionView.footerReleaseToRefreshText =  @"松开加载更多数据";
    _collectionView.footerRefreshingText = @"正在加载数据";
}

- (void)footerRefresh
{
    NSInteger pageCount = [_searchFootArray count]/14 + 1;
    
    
    //接收搜索框传来的关键字
    NSString * text = [self.searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //封装网址对象
    NSString * string = SearchAPI;
    NSString * urlString = [NSString stringWithFormat:@"%@name=%@&child_catalog_name=&taste=&fitting_crowd=&cooking_method=&effect=&pageRecord=14&phonetype=2&user_id=&is_traditional=0&page=%ld",string,text,pageCount];;
    
    
    
    [self setDataSource:urlString];
    //让底部停止刷新状态
    [_collectionView footerEndRefreshing];
}


#pragma mark ----------------- UIAlertView代理 -----------------
//UIAlertView代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 123) {
        
        if (buttonIndex == 0){
            
            //如果没有搜索结果，返回抽屉
            DDMenuController  * menuController  = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
            
            [menuController showLeftController:YES];
            
        }
        
    }
    
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
        [hud hide:YES afterDelay:1.5];
        return NO;
    }
    
    return isExistenceNetwork;
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
