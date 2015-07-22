//
//  DiseaseViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "DiseaseViewController.h"
#import "FoodTreatment.h"
#import "DiseaseViewCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "FoodDetailViewController.h"
#import "FoodModel.h"
#import "HomePageViewController.h"
#import "MJRefresh.h"

@interface DiseaseViewController ()


@property(nonatomic,retain)NSMutableArray  * diseaseAbstractArray;
@property(nonatomic,retain)UICollectionView  * collectionView;
//菜品的详细情况
@property(nonatomic,retain)NSMutableArray  * detailsArray;

@property (nonatomic,retain) MBProgressHUD * hud;

@end

@implementation DiseaseViewController

- (void)dealloc
{
    [_introductionLabel release];
    [_introductionView release];
    [_diseaseLabel release];
    [_detailView release];
    self.foodTreatment = nil;
    self.diseaseAbstractArray = nil;
    self.collectionView = nil;
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
    
//创建返回按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
    //    创建跳转到主页按钮
    UIBarButtonItem  * rightButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-shouye.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickReturnHomePageButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.title = _foodTreatment.diseaseName;
    [rightButton release];
    
    
    
    
//   设置背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
   
// 调用创建集合视图方法
    [self setupCollectionView];
    
//数组分配空间
    self.diseaseAbstractArray = [NSMutableArray arrayWithCapacity:40];
    self.detailsArray = [NSMutableArray arrayWithCapacity:40];
    
//  调用方法创建病症详情布局
    [self setupSubviews];
    
//拼接接口字符串
    NSString  * urlString = [NSString  stringWithFormat:@"%@%@&page=1&pageRecord=8&phonetype=0&is_traditional=0",DiseaseAPI,_foodTreatment.diseaseId];
    [self dataSource:urlString];
    
//    调用加载更多方法
    [self setupRefresh];

//调用缓存加载方法
    [self setupProgressHud];
    
    
    
    

}

#pragma  mark -----------跳转主页按钮方法-------------------

- (void)didClickReturnHomePageButtonAction : (UIBarButtonItem *)button
{

    for (UIViewController  * temp in self.navigationController.viewControllers) {
        
        if ([temp isKindOfClass:[HomePageViewController class]]) {
            
            [self.navigationController popToViewController:temp animated:YES];
            
        }
    }
    
}


#pragma  mark -----------返回上一级按钮方法-------------------

//返回按钮响应方法，返回上一级
- (void)didClickBackButtonItemAction : (UIBarButtonItem *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma  mark -----------创建集合视图方法-------------------

//创建一个集合视图
- (void)setupCollectionView
{

    //    创建collectionView的布局，使用系统的网格样式。
    UICollectionViewFlowLayout  * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //    设置section的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 60, 0);
    //     设置最小行间距
    flowLayout.minimumLineSpacing = 0;
    //最小列间距
    flowLayout.minimumInteritemSpacing = 0;

    
    //    创建一个collectionView的集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height-100) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    [self.view addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    //    注册集合视图中使用的cell类型及重用标识
    [_collectionView registerClass:[DiseaseViewCell class] forCellWithReuseIdentifier:@"cell"];

    [flowLayout release];
    [_collectionView release];

}


#pragma  mark -----------创建病症详情布局方法-------------------

//病症详情布局
- (void)setupSubviews
{

    _introductionView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"详细疾病-详情.png"] highlightedImage:[UIImage imageNamed:@"详细疾病-详情-选.png"]];
   
    
    _introductionView.frame = CGRectMake(5, 5, self.view.frame.size.width-10,80 );
    
    [self.view addSubview:_introductionView];
    
    _diseaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 20, 80)];
    _diseaseLabel.text = @"病\n症\n简\n介";
    _diseaseLabel.numberOfLines = 0;
    _diseaseLabel.font = [UIFont systemFontOfSize:15];
    [_introductionView addSubview:_diseaseLabel];
    
    _introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, self.introductionView.frame.size.width-60, 60)];
    _introductionLabel.numberOfLines = 0;
    _introductionLabel.font = [UIFont systemFontOfSize:13];
    [_introductionView addSubview:_introductionLabel];
    
    _introductionLabel.text = _foodTreatment.diseaseDescribe;
    
   
    
//设置是否能进行交互
    _introductionView.userInteractionEnabled = YES;
//    给introductionView添加轻拍手势
    UITapGestureRecognizer  *tapIntroduction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIntroductionImageViewAction:)];
    
    [_introductionView addGestureRecognizer:tapIntroduction];
    
    [tapIntroduction release];

}


//点击详情详细介绍布局
- (void)setupSubview
{
    
    _detailView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"详情框.png"]];
    _detailView.frame = CGRectMake(40, 40/568.0 * kScreen_height, 240, 400/568.0 * kScreen_height);
    [self.view addSubview:_detailView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10/568.0 * kScreen_height, 230, 20/568.0 * kScreen_height)];
    [_detailView addSubview:_titleLabel];
    _titleLabel.text = _foodTreatment.diseaseName;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 60/568.0 * kScreen_height, 220, 320/568.0 * kScreen_height)];
    [_detailView addSubview:_contentScrollView];
    
    //    _contentScrollView.backgroundColor = [UIColor redColor];
    
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 180, 100/568.0 * kScreen_height)];
    _contentLabel.font = [UIFont systemFontOfSize:12.0];
    _contentLabel.numberOfLines = 0;
    [_contentScrollView addSubview:_contentLabel];
    
    
    _detailView.userInteractionEnabled = YES;
    _closeButton  =  [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(200, 10/568.0 * kScreen_height, 30, 30);
    [_detailView addSubview:_closeButton];
    [_closeButton setImage:[UIImage imageNamed:@"关闭.png"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeDetailViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}


#pragma  mark -----------手势响应方法-------------------

//手势响应事件
- (void)tapIntroductionImageViewAction:(UITapGestureRecognizer *)tap
{

//    关闭introductionView交互
    _introductionView.userInteractionEnabled = NO;
    
     _introductionView.highlighted = YES;
    
//调用点击详情详细介绍布局
    [self setupSubview];
    
    
    // 得到病症介绍的字符串

    NSString  * contentText = [NSString stringWithFormat:@"病症简介：\n%@\n饮食保健：\n%@\n生活保健：\n%@",_foodTreatment.diseaseDescribe,_foodTreatment.fitEat,_foodTreatment.lifeSuit];
    
    
    //设定病症介绍的内容的自适应高度
    CGRect  contentRect = _contentLabel.frame;
    contentRect.size.height = [self contentTextHeight:contentText];
    _contentLabel.frame = contentRect;
    _contentLabel.text = contentText;
    _contentLabel.textColor = [UIColor whiteColor];
    _contentScrollView.contentSize = CGSizeMake(180, _contentLabel.frame.size.height);

    

}


#pragma  mark -----------病症文本高度方法-------------------

//得到病症介绍的文本高度
- (CGFloat)contentTextHeight : (NSString *)content
{
    CGSize  size = CGSizeMake(180, 100000);
    NSDictionary  *textDic = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0]};
    CGRect textRect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    
    return textRect.size.height;
}

#pragma  mark -----------关闭按钮响应方法-------------------

//关闭按钮响应事件
- (void)closeDetailViewButtonAction : (UIButton *)button
{

    [_detailView removeFromSuperview];
    _introductionView.highlighted = NO;
 _introductionView.userInteractionEnabled = YES;
    
}


#pragma  mark -----------集合视图数据处理方法-------------------

- (void)dataSource: (NSString *)urlStr
{
    NSString  * urlString = urlStr;
//    [NSString  stringWithFormat:@"%@%@&page=1&pageRecord=8&phonetype=0&is_traditional=0",DiseaseAPI,_foodTreatment.diseaseId];
    NSURL  * url = [NSURL URLWithString:urlString];
    
    __block  DiseaseViewController  * diseaseVC  = self;
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary  * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray  * sourceArray = sourceDic[@"data"];
        
        for (NSDictionary  * dic in sourceArray) {
            
            FoodTreatment  * foodTreatment = [[FoodTreatment alloc] init];
            
//            FoodModel  * foodModel = [[FoodModel alloc] init];
            
            [foodTreatment setValuesForKeysWithDictionary:dic];
            
           
            
            
            
            [diseaseVC.diseaseAbstractArray addObject:foodTreatment];
      
            [foodTreatment release];
            
        }
        
        [diseaseVC.collectionView reloadData];

        
        [_hud hide:YES];
        
    }];

}

#pragma  mark -----------点击集合视图item处理数据方法-------------------


//同步连接加载数据，根据菜品的Id得到该菜品的详情
- (void)dataSources : (NSString *)vegetableId
{
    
    [_detailsArray removeAllObjects];
    
    NSString  *urlString = [NSString  stringWithFormat:@"%@%@&phonetype=2&user_id=&is_traditional=0",DetailsAPI,vegetableId];
    
    NSURL  * url = [NSURL URLWithString:urlString];

    NSMutableURLRequest  * request = [NSMutableURLRequest requestWithURL:url];

    NSURLResponse  * response = nil;
    NSError  * error = nil;
    NSData  * data = [NSURLConnection  sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary  * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray  * sourceArray = sourceDic[@"data"];

    for (NSDictionary  * dic in sourceArray) {
        
        FoodModel  * foodModel = [[FoodModel alloc] init];
        [foodModel setValuesForKeysWithDictionary:dic];
        [self.detailsArray addObject:foodModel];
        
        [foodModel release];
    
    }
}

#pragma  mark -----------collectionView必须实现方法-------------------


//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    
    return 1;
}

//显示的个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return [_diseaseAbstractArray count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    DiseaseViewCell  * diseaseCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    FoodTreatment  * foodTreatment = _diseaseAbstractArray[indexPath.row];

// 加载图片
    NSURL  * url = [NSURL URLWithString:foodTreatment.imagePathThumbnails];
    [diseaseCell.showImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"sdefaultImage"]];
//设置菜名
    diseaseCell.nameLabel.text = foodTreatment.name;
//设置收藏量
    diseaseCell.clickCountLabel.text =  foodTreatment.clickCount;

//    foodTreatment.clickCount;
//设置收藏小图标
//    diseaseCell.collectImageView.image = [UIImage imageNamed:@"点击率.png"];
    
   
    
    return diseaseCell;
}





//进入详情页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self setupProgressHud];

    FoodDetailViewController * foodVC = [[FoodDetailViewController alloc] init];
    
    FoodTreatment  * foodTreatment = _diseaseAbstractArray[indexPath.row];
  
// 调用解析接口的方法，对当前点击的cell进行数据解析
     [self dataSources:foodTreatment.vegetableId];

    
    FoodModel * showFood = _detailsArray[0];

    foodVC.detailFood = showFood;
    
    //是否添加导航栏右侧按钮
    foodVC.isRightBarButtonItemAppear = YES;
    
//推出详情页面
    [self.navigationController pushViewController:foodVC animated:YES];
    
    [_hud hide:YES];
    
    [foodVC release];
}



//设置collectionView中每一个view的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(160, 126);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark -----------缓存加载方法-------------------

- (void)setupProgressHud
{
    self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.labelText = NSLocalizedString(@"加载中", nil);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
    
}

#pragma  mark -----------上拉加载更多方法-------------------

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
    
    
    NSString * urlString = @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tbldisease!getVegetable.do?&pageRecord=10&phonetype=0&is_traditional=0&diseaseId=";
    
    NSInteger pageCount = [_diseaseAbstractArray count]/10 + 1;
    
    NSString * newUrl = [NSString stringWithFormat:@"%@%@&page=%ld",urlString,_foodTreatment.diseaseId,pageCount];
    
    [self dataSource:newUrl];
    
    //让数据加载需要3秒钟
    dispatch_after(dispatch_time((DISPATCH_TIME_NOW), (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_collectionView reloadData];
        //让底部停止刷新状态
        [_collectionView footerEndRefreshing];
    });
    
}





@end
