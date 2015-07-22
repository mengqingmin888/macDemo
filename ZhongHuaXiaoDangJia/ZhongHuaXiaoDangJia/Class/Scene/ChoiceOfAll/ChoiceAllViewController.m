//
//  ChoiceAllViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "ChoiceAllViewController.h"
#import "ChoiceAllCell.h"
#import "FoodModel.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "HomePageViewController.h"
#import "FoodDetailViewController.h"
#import "MJRefresh.h"
#import "TypeViewCell.h"
#import "CategoryViewCell.h"
#import "NetWork.h"


@interface ChoiceAllViewController ()
{

    int scrollX;//tableview的index
//    判断collectionView是否被点击
    BOOL  isCollectionViewClick;
//    存放点击小分类时点击的当前的Id
    NSString   * vegetableChildId;
    
}

@property(nonatomic,retain)NSMutableArray * choiceArray;//数据源的数组

//@property(nonatomic,retain)NSMutableArray * choArray;//数据源的数组

@property(nonatomic,retain)NSMutableArray * eightArray;//tableview点击cell对应的数组

@property(nonatomic,retain)NSMutableArray * tenArray;//tableview上的数组

@property(nonatomic,retain)NSMutableDictionary  * categoryDic;  //存放大分类对应小分类的字典

@property(nonatomic,retain)NSMutableArray  * categoryArray;   //最后得到的八个分类对应的数组

//定义两个集合视图
@property(nonatomic,retain,readonly)UICollectionView  * foodCollectionView;  //显示菜品的集合视图
@property(nonatomic,retain,readonly)UICollectionView  * foodTypeView;  //显示不同分类的集合视图

@property(nonatomic,retain,readonly)UITableView  * categoryTableView;  //定义一个TableView来放置菜品的十大分类
@property(nonatomic,retain,readonly)UIView   * categoryView;  //放置TabelView的View

@property(nonatomic,retain)NSMutableArray  * aaArray;   //存放处理完成的数据的数组，对应81个对象
@property(nonatomic,retain)NSMutableArray  * bbArray;   //用来存放字典是需要用到的数组


//加载功能
@property(nonatomic,retain)MBProgressHUD * hud;

@end

@implementation ChoiceAllViewController

- (void)dealloc
{
    [_foodCollectionView release];
    [_foodTypeView release];
    [_categoryTableView release];
    [_categoryView release];
    self.choiceArray = nil;
//    self.choArray = nil;
    self.eightArray = nil;
    self.tenArray = nil;
    self.categoryDic = nil;
    self.categoryArray = nil;
    self.hud = nil;
    
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
    

// 用到的数组进行空间分配
//    self.choArray = [NSMutableArray arrayWithCapacity:40];
    self.choiceArray = [NSMutableArray arrayWithCapacity:40];
    self.categoryDic = [NSMutableDictionary dictionaryWithCapacity:40];
    self.aaArray = [NSMutableArray arrayWithCapacity:40];

    
    
    
    
    
#pragma mark---------------展示页面需调用的方法-------------------
    
    
//调用缓存加载
    [self setupProgressHud];
    
//调用数据源，对显示菜品的collectionView数据进行处理
    [self setDataSource:ChoiceOfAllAPI];
//当没有点击下面tableView显示的分类时，设置isTableViewClick为NO
    isCollectionViewClick = NO;
    
//调用创建UICollectionView
    [self setupCollectionView];
    
//调用创建tableView
    [self setupTableView];
    
//对tableView上数据的处理，显示十个分类
    [self dataSource];

//调用加载数据
    [self setupRefresh];
    
    
//左上方返回图标
    UIImage * backImage = [[UIImage imageNamed:@"btn_nav_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//添加左边按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackBarButtonItem:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
//导航栏标题
    self.navigationItem.title = @"万道美食";
    
}


#pragma mark -----------UICollectionView布局---------------

//创建两个UICollectionView
- (void)setupCollectionView
{
    //创建collectionView的布局，系统的网格样式
    UICollectionViewFlowLayout * collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionViewFlowLayout * typeFlowLayout = [[UICollectionViewFlowLayout alloc] init];

    //创建一个集合视图
    _foodCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height - 104) collectionViewLayout:collectionFlowLayout];
    
    _foodCollectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
//    创建分类菜品的集合视图
    _foodTypeView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-64, 320, 80) collectionViewLayout:typeFlowLayout];
    _foodTypeView.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"选菜-分类背景.png"]];
//    _foodTypeView.backgroundColor = [UIColor redColor];
    
    //设置代理
    _foodCollectionView.delegate = self;
    _foodCollectionView.dataSource = self;
    _foodTypeView.delegate = self;
    _foodTypeView.dataSource = self;
    
    
    [self.view addSubview:_foodCollectionView];
    [self.view addSubview:_foodTypeView];
    

    
    //最小列间距
    collectionFlowLayout.minimumInteritemSpacing = 0;
    //最小行间距
    collectionFlowLayout.minimumLineSpacing = 0;
    collectionFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //最小列间距
    typeFlowLayout.minimumInteritemSpacing = 0;
    //最小行间距
    typeFlowLayout.minimumLineSpacing = 0;
    typeFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    
    //注册集合视图中使用的Cell类型及重用标识
    [_foodCollectionView registerClass:[ChoiceAllCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_foodTypeView registerClass:[TypeViewCell class] forCellWithReuseIdentifier:@"typeCell"];
    

    
    [collectionFlowLayout release];
    [typeFlowLayout release];

   
}

#pragma mark--------------UICollectionView实现方法---------------
//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
 
    return 1;
    
}

//分区items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //...
    if (collectionView == _foodCollectionView) {
    

        return [_choiceArray count];
    }
    
   
    return [_categoryArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //
    if (collectionView == _foodCollectionView) {
    
        ChoiceAllCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        FoodModel * food = _choiceArray[indexPath.row];
        cell.choiceModal = food;
        
        NSURL * url = [NSURL URLWithString:food.imagePathThumbnails];
        [cell.showImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"sdefaultImage"]];
        
        return cell;
        
    }

    TypeViewCell  * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"typeCell" forIndexPath:indexPath];
    
    FoodModel  * food = _categoryArray[indexPath.row];
    cell.foodModel = food;
//    cell.backgroundColor = [UIColor clearColor];
    NSURL  * url = [NSURL URLWithString:food.imagePathName];
    
    [cell.showImageView sd_setImageWithURL:url];
    
    return cell;

}


//设置imtes的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _foodCollectionView) {
        return CGSizeMake(160, 126);
    }
    
    return CGSizeMake(80 ,40);
}




//点击进入详细页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
 /*
  实现步骤：
  
  点击controllerView的Item的时候首先判断下面分类的controllerView是否弹出（通过判断tableView的frame的y坐标）：
  1）如果判断已经弹出，则会再次判断点击的是哪一个collectionView
            如果点击的是_foodCollectionView，则会开始动画，让tableView和_foodTypeView返回到原来的位置。
            如果点击的是_foodTypeView，则也会开始动画，让tableView和_foodTypeView返回到原来的位置，同时会根据点击的item对应的FoodModel的属性vegetableChildCatalogId，进行数据解析。
  2）如果判断没有弹出，则点击Item直接跳转到详情页面。
 */
    if (_categoryView.frame.origin.y == self.view.frame.size.height-120) {
        
        if (collectionView == _foodTypeView) {
            [UIView animateWithDuration:1 animations:^{
                
                _foodTypeView.transform = CGAffineTransformTranslate(_foodTypeView.transform, 0, _foodTypeView.frame.size.height);
                _categoryView.transform = CGAffineTransformTranslate(_categoryView.transform,0 , _foodTypeView.frame.size.height);
                
            }];
            
// 当判断完成进行解析数据时，先将isCollectionViewClick状态设置为YES
             isCollectionViewClick = YES;
//      解析数据
            FoodModel  * food = _eightArray[indexPath.row];

            [self.choiceArray removeAllObjects];
            
//拼接接口字符串
         NSString  * urlString  =  [NSString  stringWithFormat:@"%@%@&page=1&pageRecord=10&phonetype=2&user_id=&is_traditional=0",CategoryAPI,food.vegetableChildCatalogId];
//将得到的点击的item即food.vegetableChildCatalogId赋给vegetableChildId，便于在刷新数据的时候使用。
            vegetableChildId = food.vegetableChildCatalogId;
            
//通过得到的food.vegetableChildCatalogId进行数据解析
            [self setDataSource:urlString];
            
        }if (collectionView == _foodCollectionView) {
            
            [UIView animateWithDuration:0.8 animations:^{
                
                _foodTypeView.transform = CGAffineTransformTranslate(_foodTypeView.transform, 0, _foodTypeView.frame.size.height);
                _categoryView.transform = CGAffineTransformTranslate(_categoryView.transform,0 , _foodTypeView.frame.size.height);
                
            }];
        }
        
    }else {
     
        FoodDetailViewController * foodVC = [[FoodDetailViewController alloc] init];
        
        FoodModel * showFood = _choiceArray[indexPath.row];
        
        foodVC.detailFood = showFood;
        
        //是否添加导航栏右侧按钮
        foodVC.isRightBarButtonItemAppear = YES;
        
        [self.navigationController pushViewController:foodVC animated:YES];
        
        [foodVC release];
        
    }

}




#pragma  mark -----------UITableView布局-------------------
//创建一个tableView，对tableView进行布局
- (void)setupTableView
{
    
    //设置一个放置tableView的View
    _categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-104, 320, 40)];
    _categoryView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"万道美食背景.png"]];
    
    _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    // 设置tableView的背景色和cell的分割线为透明
    _categoryTableView.backgroundColor = [UIColor clearColor];
    _categoryTableView.separatorColor = [UIColor clearColor];
    //将tableView旋转90度，进行横放。
    _categoryTableView.transform =CGAffineTransformMakeRotation(-M_PI/2);
    //横放后要再次设置frame
    _categoryTableView.frame = CGRectMake(0, 0, 320, 40);
    //关闭右边显示的滑动条
    _categoryTableView.showsVerticalScrollIndicator = NO;
    //关闭反弹效果
    _categoryTableView.bounces = NO;
    
    _categoryTableView.dataSource = self;
    _categoryTableView.delegate = self;
    
    [self.view addSubview:_categoryView];
    [_categoryView addSubview:_categoryTableView];
    
    
}




#pragma mark -----------UITableView 实现方法---------------


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [_tenArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static  NSString  * identifier = @"cell";
    
        CategoryViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[CategoryViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"选菜-大类.png"]];

    FoodModel  * food = _tenArray[indexPath.row];
    cell.foodModel = food;
//  点击tableView的cell后改变背景图片，旋转点击后的图片
    cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"选菜-大类-选.png"]] autorelease];
    cell.selectedBackgroundView.transform =CGAffineTransformMakeRotation(M_PI/2);
    
    NSURL  * url = [NSURL URLWithString:food.imagePathName];
    [cell.showImageView sd_setImageWithURL:url];
    
    cell.backgroundColor = [UIColor clearColor];
    
        return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return 80;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    scrollX  = (int)indexPath.row + 1;
    
//点击tableView的cell时，通过_categoryView.frame.origin.y进行判断是否开始动画，同时处理对应的数据。
    
    if (_categoryView.frame.origin.y == self.view.frame.size.height-40) {
        
//        _foodCollectionView.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:0.8 animations:^{
            
            _categoryView.transform = CGAffineTransformTranslate(_categoryView.transform, 0,-_foodTypeView.frame.size.height);
            _foodTypeView.transform = CGAffineTransformTranslate(_foodTypeView.transform, 0, -_foodTypeView.frame.size.height);
            
        }completion:^(BOOL finished) {
            
        }];
    
        
        [self dataSourceButton:scrollX categoryId:1 vegetableId:@"12"];
        [self dataSourceButton:scrollX categoryId:2 vegetableId:@"13"];
        [self dataSourceButton:scrollX categoryId:3 vegetableId:@"14"];
        [self dataSourceButton:scrollX categoryId:4 vegetableId:@"15"];
        [self dataSourceButton:scrollX categoryId:5 vegetableId:@"20"];
        [self dataSourceButton:scrollX categoryId:6 vegetableId:@"21"];
        [self dataSourceButton:scrollX categoryId:7 vegetableId:@"22"];
        [self dataSourceButton:scrollX categoryId:8 vegetableId:@"26"];
        [self dataSourceButton:scrollX categoryId:9 vegetableId:@"27"];
        [self dataSourceButton:scrollX categoryId:10 vegetableId:@"28"];
       
    }else{
        
        [self dataSourceButton:scrollX categoryId:1 vegetableId:@"12"];
        [self dataSourceButton:scrollX categoryId:2 vegetableId:@"13"];
        [self dataSourceButton:scrollX categoryId:3 vegetableId:@"14"];
        [self dataSourceButton:scrollX categoryId:4 vegetableId:@"15"];
        [self dataSourceButton:scrollX categoryId:5 vegetableId:@"20"];
        [self dataSourceButton:scrollX categoryId:6 vegetableId:@"21"];
        [self dataSourceButton:scrollX categoryId:7 vegetableId:@"22"];
        [self dataSourceButton:scrollX categoryId:8 vegetableId:@"26"];
        [self dataSourceButton:scrollX categoryId:9 vegetableId:@"27"];
        [self dataSourceButton:scrollX categoryId:10 vegetableId:@"28"];
        
    }
    }


#pragma mark -------------UItableView数据处理-----------------

//对tableView上数据的处理，显示十个分类,同时处理每一个分类对应的数组。
- (void)dataSource
{
    //封装网址对象（宏定义）
    NSString * string = ChoiceOfAllScrollAPI;
    
    
    self.tenArray = [NSMutableArray arrayWithCapacity:40];
    
    __block ChoiceAllViewController  * choiceVC = self;
    
    [[NetWork shareInstance]loadingDataWithUrlString:string urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error)  {
        
        if (data != nil && error == nil) {
            //导出data数据
            NSDictionary * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * dataArray = sourceDic[@"data"];
            
            for (NSDictionary * dataDic in dataArray) {
                
                FoodModel * foodModel = [[FoodModel alloc] init];
                [foodModel setValuesForKeysWithDictionary:dataDic];
                [choiceVC.tenArray addObject:foodModel];
                [foodModel release];
                NSArray  * datArray = dataDic[@"TblVegetableChildCatalog"];
                for (NSDictionary  * dic in datArray) {
                    FoodModel  * food = [[FoodModel alloc] init];
                    [food setValuesForKeysWithDictionary:dic];
                    [choiceVC.aaArray addObject:food];
                    [food release];
                }
            }
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        [choiceVC.categoryTableView reloadData];
        
//    对数组进行处理，对应根据key值存入对应的字典的value中。
        for (int i = 0 ; i < choiceVC.tenArray.count; i ++) {
            choiceVC.bbArray = [NSMutableArray arrayWithCapacity:40];
            FoodModel  * foodM = choiceVC.tenArray[i];
            for (int j = 0; j < choiceVC.aaArray.count; j ++) {
                
                FoodModel  * foodO = choiceVC.aaArray[j];
                
                if ([foodM.vegetableCatalogId isEqualToString:foodO.catalogId]) {
                    [choiceVC.bbArray addObject:foodO];
                    
                    [choiceVC.categoryDic setValue:choiceVC.bbArray forKey:foodM.vegetableCatalogId];
                }
                
            }
            
        }
        
        
        
    }];
    
}





#pragma mark ---------- 点击tableView的cell后进行的数据处理--------------

//根据对应的点击的tableView的cell的indexPath.row跟categoryId比较是否相同，如果相同则根据vegetableId的值进行数据解析，将解析完成的数据放到eightArray数组中。
- (void)dataSourceButton : (NSUInteger)buttonId   categoryId : (NSUInteger)categoryId  vegetableId : (NSString *)vegetableId
{
    
    
    if (buttonId == categoryId) {
        
        self.eightArray = [NSMutableArray arrayWithCapacity:40];
        
        self.eightArray = [self.categoryDic objectForKey:vegetableId];
        
      
        
            self.categoryArray = [NSMutableArray arrayWithCapacity:40];
//因为数组中会存有9个元素，所有再次将得到的数据进行处理，得到前8个元素存放到categoryArray数组中。
                for (int i = 0; i < 8; i ++) {
                    
                    [self.categoryArray addObject:self.eightArray[i]];
                    
                }
        
            [_foodTypeView reloadData];
        
       
        
    }
    
}


#pragma mark------------显示菜品的CollectionView数据处理------------


//数据源
- (void)setDataSource:(NSString *)dataUrl
{
    //封装网址对象（宏定义）
    NSString * string = dataUrl;
    //NSURL * url = [NSURL URLWithString:string];
    //设置请求
    //NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    __block ChoiceAllViewController * choiceVC = self;
    
    [[NetWork shareInstance]loadingDataWithUrlString:string urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data != nil && error == nil) {
            //导出data数据
            NSDictionary * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * dataArray = sourceDic[@"data"];
            
            
            for (NSDictionary * dataDic in dataArray) {
                FoodModel * food = [[FoodModel alloc] init];
                [food setValuesForKeysWithDictionary:dataDic];
                [choiceVC.choiceArray addObject:food];
                [food release];
            }
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        //数据重载
        [_foodCollectionView reloadData];
        //缓存停止
        [_hud hide:YES];
        
    }];
    
}

#pragma mark----------------按钮触发事件-----------------

//点击左侧键返回首页
- (void)didClickBackBarButtonItem:(UIBarButtonItem *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark----------------缓存加载事件-----------------
//缓存加载
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

#pragma mark ------------------上拉加载--------------------


- (void)setupRefresh
{
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_foodCollectionView addFooterWithTarget:self action:@selector(footerReshingMoth)];
    
    _foodCollectionView.footerPullToRefreshText = @"上拉可以加载更多数据";
    _foodCollectionView.footerReleaseToRefreshText =  @"松开加载更多数据";
    _foodCollectionView.footerRefreshingText = @"正在加载数据";
}

- (void)footerReshingMoth
{
    
    //根据接口下拉刷新的时候，首先判断动画推出的CollectionView时候被点击过，即isCollectionViewClick的状态。
    if (isCollectionViewClick == NO) {
        NSString * urlString = @"http://42.121.13.106:8080/HandheldKitchen/api/vegetable/tblvegetable!getInfo.do?phonetype=2&catalog_id=&pageRecord=10&is_traditional=0&user_id=&page=";
        NSInteger pageCount = [_choiceArray count]/10 + 1;
        
        NSString * newUrl = [NSString stringWithFormat:@"%@%ld",urlString,pageCount];
        
        [self setDataSource:newUrl];
    }else{
        NSString * urlString = @"http://112.124.32.151:8080//HandheldKitchen/api/vegetable/tblvegetable!getInfo.do?&pageRecord=10&phonetype=2&user_id=&is_traditional=0&catalog_id=";
        
        NSInteger pageCount = [_choiceArray count]/10 + 1;
        
        NSString * newUrl = [NSString stringWithFormat:@"%@%@&page=%ld",urlString,vegetableChildId,pageCount];
        
        [self setDataSource:newUrl];
        
    }
    
    //让数据加载需要3秒钟
    dispatch_after(dispatch_time((DISPATCH_TIME_NOW), (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_foodCollectionView reloadData];
        //让底部停止刷新状态
        [_foodCollectionView footerEndRefreshing];
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end