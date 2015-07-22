//
//  MenuViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "MenuViewController.h"

#import "MenuImageCell.h"

#import "FoodModel.h"

#import "MBProgressHUD.h"

#import "UIImageView+WebCache.h"

#import "HomePageViewController.h"

#import "FoodDetailViewController.h"

#import "MJRefresh.h"

#import "NetWork.h"

#import "DateModel.h"

@interface MenuViewController ()

{
    UICollectionView *_collectionView;
    NSInteger _pageCount;
}

@property(nonatomic,retain)NSMutableArray * menuArray;

//加载功能
@property(nonatomic,retain)MBProgressHUD * mbHud;
@end

@implementation MenuViewController

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
    
    self.navigationItem.title = @"每月美食";
    
    //调用collectionflowlayout方法
    [self setCollectionFlowLayout];
    //调用加载，必须把定义数组空间的代码放在这
    
    
    //获取年份和月份
    self.date.year_id = [_date.GregorianCalendar substringWithRange:NSMakeRange(0, 4)];
    self.date.month_id = [_date.GregorianCalendar substringWithRange:NSMakeRange(5, 2)];
    
    NSString * string = [MenuOfMonthAPI stringByReplacingOccurrencesOfString:@"year=%@&month=%@" withString:[NSString stringWithFormat:@"year=%@&month=%@",self.date.year_id,self.date.month_id]];
    
    
    //调用数据源
    [self setDataSource:string];
    
    self.menuArray = [NSMutableArray arrayWithCapacity:40];
    
    
    //调用加载数据
    [self setupRefresh];
    
    
    //调用缓存加载(菊花)
    [self setDownLoad];
    
    
    //左上方返回图标
    UIImage * backImage = [[UIImage imageNamed:@"btn_nav_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加左边按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackBarButtonItem:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
}

#pragma mark----------------按钮触发事件-----------------
//点击左侧键返回首页
- (void)didClickBackBarButtonItem:(UIBarButtonItem *)button
{
    HomePageViewController * homeVC = [[HomePageViewController alloc] init];
    
    [self.navigationController popViewControllerAnimated:YES];
    [homeVC release];
}

//点击进入详细页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController * foodVC = [[FoodDetailViewController alloc] init];
    
    FoodModel * showFood = _menuArray[indexPath.row];
    
    foodVC.detailFood = showFood;
    
    //是否添加导航栏右侧按钮
    foodVC.isRightBarButtonItemAppear = YES;
    
    [self.navigationController pushViewController:foodVC animated:YES];
    [foodVC release];
}

#pragma mark-----------------数据处理-------------------
//缓存加载
- (void)setDownLoad
{
    //缓存加载页面
    _mbHud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _mbHud.frame = self.view.bounds;
    _mbHud.minSize = CGSizeMake(100, 100);
    _mbHud.labelText = NSLocalizedString(@"加载中", nil);
    _mbHud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_mbHud];
    [_mbHud hide:YES afterDelay:5.0];
    
    [_mbHud show:YES];
    
    
}
//数据源
- (void)setDataSource:(NSString *)dataUrl
{
    //封装网址对象（宏定义）
    NSString * string = dataUrl;
    //NSURL * url = [NSURL URLWithString:string];
    //设置请求
    //NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    __block MenuViewController * menuVC = self;
    
    [[NetWork shareInstance]loadingDataWithUrlString:string urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data != nil && error == nil) {
            //导出data数据
            NSDictionary * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * dataArray = sourceDic[@"data"];
            
            
            for (NSDictionary * dataDic in dataArray) {
                FoodModel * food = [[FoodModel alloc] init];
                [food setValuesForKeysWithDictionary:dataDic];
                [menuVC.menuArray addObject:food];
                [food release];
            }
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        [_collectionView reloadData];
        [_mbHud hide:YES];
        
    }];
    
}

//实现UICollectionViewFlowLayout方法
- (void)setCollectionFlowLayout
{
    //布局collectionView
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //创建集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height - 64) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [flowLayout release];
    [_collectionView release];
    //最小列间距
    flowLayout.minimumInteritemSpacing = 0;
    
    //最小行间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //注册集合视图中使用的Cell类型及重标识
    [_collectionView registerClass:[MenuImageCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark------------------必须实现-------------------
//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//分区items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_menuArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    FoodModel * food = _menuArray[indexPath.row];
    cell.menuFood = food;
    
    NSURL * url = [NSURL URLWithString:food.imagePathThumbnails];
    [cell.showImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"sdefaultImage"]];
    
    return cell;
    
}

//设置imtes的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 126);
}

#pragma mark ------------------上拉加载--------------------


- (void)setupRefresh
{
     // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_collectionView addFooterWithTarget:self action:@selector(footerReshingMoth)];
    
    _collectionView.footerPullToRefreshText = @"上拉可以加载更多数据";
    _collectionView.footerReleaseToRefreshText =  @"松开加载更多数据";
    _collectionView.footerRefreshingText = @"正在加载数据";
    
    
    
}

- (void)footerReshingMoth
{
    NSString * urlString = [NSString stringWithFormat:@"http://42.121.13.106:8080/HandheldKitchen/api/more/tblmonthlypopinfo!get.do?phonetype=2&year=%@&month=%@&user_id=&pageRecord=14&is_traditional=0&page=",self.date.year_id,self.date.month_id];
    
    _pageCount = [_menuArray count]/14 + 1;
    
    
    if (_pageCount > 2) {
        _collectionView.footerPullToRefreshText = @"最后一页";
        _collectionView.footerReleaseToRefreshText =  @"最后一页";
        _collectionView.footerRefreshingText = @"无数据";
    }

    NSString * newUrl = [NSString stringWithFormat:@"%@%ld",urlString,_pageCount];
    
    
    [self setDataSource:newUrl];
    
    [_collectionView footerEndRefreshing];
    
    

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
