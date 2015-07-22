//
//  BestFavoriteViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "BestFavoriteViewController.h"

#import "BestFavoriteImageCell.h"

#import "HomePageViewController.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

#import "FoodDetailViewController.h"

#import "FoodModel.h"

#import "MJRefresh.h"

#import "NetWork.h"

@interface BestFavoriteViewController ()
{
    UICollectionView *_collectionView;
}
//存储数据的数组
@property(nonatomic,retain)NSMutableArray * bestArray;
//缓存
@property(nonatomic,retain)MBProgressHUD * mbprogressHUD;

@end


@implementation BestFavoriteViewController

- (void)dealloc
{
    [_collectionView release];
    [_mbprogressHUD release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"最受欢迎";
    //调用collectionview
    [self setupSubviews];
    
    //调用数据源
    [self setDataSource:BestFoodAPI];
    //调用缓存加载(菊花)
    [self setDownLoad];
    
#pragma mark-------------------上拉加载更多数据--------------------
    
    //调用上拉加载，把自定义数组空间放在这
    self.bestArray = [NSMutableArray arrayWithCapacity:40];
    
    //调用加载数据
    [self setupRefresh];
    
    //左上方返回图标
    UIImage * backImage = [[UIImage imageNamed:@"btn_nav_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加左边按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
    //    //在导航条上加图片
    //    UIImageView * barView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"每月菜单.png"]];
    //    barView.frame = CGRectMake(90, 4, 40, 40);
    //    [self.navigationController.navigationBar addSubview:barView];
    
}
#pragma mark----------------按钮触发-----------------
//返回首页
- (void)didClickBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    HomePageViewController * homeVC = [[HomePageViewController alloc]init];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [homeVC release];
    
}

//进入详情页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController * foodVC = [[FoodDetailViewController alloc] init];
    
    FoodModel * showFood = _bestArray[indexPath.row];
    
    foodVC.detailFood = showFood;
    
    //是否添加导航栏右侧按钮
    foodVC.isRightBarButtonItemAppear = YES;
    
    [self.navigationController pushViewController:foodVC animated:YES];
    
    [foodVC release];
}

#pragma mark-------------------数据处理----------------------
//缓存加载
- (void)setDownLoad
{
       
    //缓存加载页面
    _mbprogressHUD = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _mbprogressHUD.frame = self.view.bounds;
    _mbprogressHUD.minSize = CGSizeMake(100, 100);
    _mbprogressHUD.labelText = NSLocalizedString(@"加载中", nil);
    _mbprogressHUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_mbprogressHUD];
    [_mbprogressHUD hide:YES afterDelay:5.0];
    
    
    [_mbprogressHUD show:YES];
}
//数据源
- (void)setDataSource:(NSString *)dataUrl
{
    //封装网址对象
    NSString * string = dataUrl;
    //NSURL * url = [NSURL URLWithString:string];
    //设置请求
    //NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    __block BestFavoriteViewController * bestVC = self;
    
    
    [[NetWork shareInstance]loadingDataWithUrlString:string urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (data != nil && error == nil) {
            NSDictionary * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * dataArray = sourceDic[@"data"];
            
            for (NSDictionary * dataDic in dataArray) {
                FoodModel * food = [[FoodModel alloc] init];
                [food setValuesForKeysWithDictionary:dataDic];
                [bestVC.bestArray addObject:food];
                [food release];
            }

            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
                //数据重载
        [_collectionView reloadData];
        
        [_mbprogressHUD hide:YES];
    }];
    
    
    
}

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
    [_collectionView registerClass:[BestFavoriteImageCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark----------------- 必须实现的方法 ----------------
//分区数[必须实现]
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section有几个items[必须实现]
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_bestArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BestFavoriteImageCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    FoodModel * food = _bestArray[indexPath.row];
    cell.bestFood = food;
    
    NSURL * url = [NSURL URLWithString:food.imagePathThumbnails];
    [cell.showImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"sdefaultImage"]];
    
    return cell;
}

//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 126);
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
    NSString * urlString = @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getHotTblVegetable.do?pageRecord=12&phonetype=2&user_id=&is_traditional=0&page=";
    
    NSInteger pageCount = [_bestArray count]/12 + 1;
    NSString * url = [NSString stringWithFormat:@"%@%ld",urlString,pageCount];
    
    
    [self setDataSource:url];
    //让底部停止刷新状态
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
