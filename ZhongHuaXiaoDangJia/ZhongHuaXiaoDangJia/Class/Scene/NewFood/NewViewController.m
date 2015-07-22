//
//  NewViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "NewViewController.h"

#import "FoodModel.h"

#import "NewFoodCell.h"

#import "UIImageView+WebCache.h"

#import "HomePageViewController.h"

#import "FoodDetailViewController.h"

#import "MBProgressHUD.h"

#import "MJRefresh.h"

#import "NetWork.h"

@interface NewViewController ()


{
    UICollectionView *_collectionView;
}

//保存所有数据
@property(nonatomic,retain)NSMutableArray * foodNewArray;
//缓存加载
@property(nonatomic,retain)MBProgressHUD * mbpNew;

@end

@implementation NewViewController
- (void)dealloc
{
    [_collectionView release];
    [_foodNewArray release];
    [_mbpNew release];
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
    
    self.navigationItem.title = @"最新推出";
    
#pragma mark---------------展示页面需调用的方法-------------------
    
    //调用UICollectionView
    [self setupSubviews];
    //调用数据源
    [self setDataSource:NewFoodAPI];
    //调用缓存加载(菊花)
    [self setDownLoad];
    
#pragma mark---------------------上拉加载更多-----------------------
    
    //调用上拉加载，把自定义数组空间放在这
    self.foodNewArray = [NSMutableArray arrayWithCapacity:40];
    
    //调用加载数据
    [self setupRefresh];
    
    //左上方返回图标
    UIImage * backImage = [[UIImage imageNamed:@"btn_nav_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加左边按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didClicBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
}

#pragma mark----------------按钮触发事件-------------------
//点击返回主页面
- (void)didClicBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    HomePageViewController * homeVC = [[HomePageViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
    [homeVC release];
}

//点击进入详情页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController * foodVC = [[FoodDetailViewController alloc] init];
    FoodModel * showFood = _foodNewArray[indexPath.row];
    
    foodVC.detailFood = showFood;
    //是否添加导航栏右侧按钮
    foodVC.isRightBarButtonItemAppear = YES;
    
    [self.navigationController pushViewController:foodVC animated:YES];
    [foodVC release];
}

#pragma mark------------------数据处理----------------------
//缓存加载（菊花）
- (void)setDownLoad
{
    //缓存加载页面
    _mbpNew = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _mbpNew.frame = self.view.bounds;
    _mbpNew.minSize = CGSizeMake(100, 100);
    _mbpNew.labelText = NSLocalizedString(@"加载中", nil);
    _mbpNew.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_mbpNew];
    [_mbpNew hide:YES afterDelay:5.0];
    
    
    [_mbpNew show:YES];
    
    
}

//数据源
- (void)setDataSource:(NSString *)dataUrl
{
    //封装网址对象
    NSString * string =dataUrl ;
    //NSURL * url = [NSURL URLWithString:string];
    //设置请求
    //NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    __block NewViewController * newVC = self;
    
    [[NetWork shareInstance]loadingDataWithUrlString:string urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (data != nil && error == nil) {
            NSDictionary * souceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * dataArray = souceDic[@"data"];
            
            for (NSDictionary * dataDic in dataArray) {
                FoodModel * food = [[FoodModel alloc] init];
                [food setValuesForKeysWithDictionary:dataDic];
                [newVC.foodNewArray addObject:food];
                [food release];
            }
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        //数据重载
        [_collectionView reloadData];
        //缓存停止
        [_mbpNew hide:YES];
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
    [_collectionView registerClass:[NewFoodCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark-----------------必须实现的方法-------------------
//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//分区中的items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_foodNewArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewFoodCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    FoodModel * food = _foodNewArray[indexPath.row];
    cell.foodNewModal = food;
    
    NSURL * url = [NSURL URLWithString:food.imagePathThumbnails];
    [cell.showImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"sdefaultImage"]];
    return cell;
}

//设置imtems的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 126);
}

#pragma mark----------------------上拉加载数据---------------------

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
    NSString * urlString = @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getNewTblVegetable.do?pageRecord=12&phonetype=2&user_id=&is_traditional=0&page=";
    
    NSInteger pageCount = [_foodNewArray count]/12+1;
    
    NSString * newUrl = [NSString stringWithFormat:@"%@%ld",urlString,pageCount];
    
    
    [self setDataSource:newUrl];
    
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
