//
//  GoodAndBadViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-19.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "GoodAndBadViewController.h"

#import "FoodDetailViewController.h"

#import "HomePageViewController.h"

#import "CorrelationViewController.h"

#import "GoodAndBadViewCell.h"

#import "FoodModel.h"

#import "MBProgressHUD.h"

#import "UIImageView+WebCache.h"

#import "NetWork.h"

@interface GoodAndBadViewController ()
{
    UITableView     *_tableView;
}


@property (nonatomic,retain) NSMutableArray  * goodFoodArray;//相宜食材数组

@property (nonatomic,retain) NSMutableArray  * badFoodArray;//相克食材数组

@property (nonatomic,retain) MBProgressHUD * hud;

@property (nonatomic,retain) FoodModel * sectionFood;


@end

@implementation GoodAndBadViewController

- (void)dealloc
{
    self.goodFoodArray = nil;
    self.badFoodArray = nil;
    self.hud = nil;
    self.sectionFood = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"iconfont-banxing.png"];
        self.tabBarItem.title = @"相宜相克";
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"相宜相克";
    
    
    //添加左上角按钮
    [self addLeftBarButtonItem];
    
    //创建tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    //关闭反弹效果
    _tableView.bounces = NO;
    
    
    //去除cell分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //关闭用户交互
//    _tableView.userInteractionEnabled = NO;
    
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
    NSString * string = GoodAndBadAPI;
    NSString * urlString = [string stringByReplacingOccurrencesOfString:@"vegetable_number" withString:self.goodAndBadFood.vegetable_id];
    
    //NSURL * url = [NSURL URLWithString:urlString];
    
    //设置请求
   // NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    __block GoodAndBadViewController * goodAndBadFoodVC = self;
    
    self.goodFoodArray = [NSMutableArray arrayWithCapacity:40];
    self.badFoodArray = [NSMutableArray arrayWithCapacity:40];
    
    [[NetWork shareInstance]loadingDataWithUrlString:urlString urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data != nil && error == nil) {
            //data是完整数据
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers  error:nil];
            
            NSArray * oneArray = dic[@"data"];
            
            NSDictionary * FirstDic = [oneArray firstObject];
            
            self.sectionFood = [[FoodModel alloc]init];
            
            self.sectionFood.materialName = FirstDic[@"materialName"];
            self.sectionFood.materialImage = FirstDic[@"imageName"];
            
            NSArray * FitingArray = FirstDic[@"Fitting"];
            
            for (NSDictionary * oneDic in FitingArray) {
                
                FoodModel * food = [[FoodModel alloc]init];
                
                food.MaterialFoodName = oneDic[@"materialName"];
                food.MaterialFoodImage = oneDic[@"imageName"];
                food.contentDescription = oneDic[@"contentDescription"];
                
                [goodAndBadFoodVC.goodFoodArray addObject:food];
                
                [food release];
                
            }
            
            NSDictionary * SecondDic = [oneArray lastObject];
            
            NSArray * GramArray = SecondDic[@"Gram"];
            
            for (NSDictionary * oneDic in GramArray) {
                
                FoodModel * food = [[FoodModel alloc]init];
                
                food.MaterialFoodName = oneDic[@"materialName"];
                food.MaterialFoodImage = oneDic[@"imageName"];
                food.contentDescription = oneDic[@"contentDescription"];
                
                [goodAndBadFoodVC.badFoodArray addObject:food];
                
                [food release];
                
            }

            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        
        //重载数据
        [_tableView reloadData];
        
        //菊花结束
        [_hud hide:YES];
        
    }];
    
    
}


#pragma mark ----------------- 导航栏按钮 -----------------
//添加左上角按钮
- (void)addLeftBarButtonItem
{
    //左上方返回图标
    UIImage * backImage = [[UIImage imageNamed:@"btn_nav_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加左边按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
}

//返回按钮
- (void)didBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


#pragma mark ----------------- 自定义section -----------------
//自定义section
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return  nil;
    }
    
    UIView * sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] autorelease];
    sectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    UIView * whiteView = [[[UIView alloc]init]autorelease];
    whiteView.frame = CGRectMake(20, 9, 280, 32);
    whiteView.backgroundColor = [UIColor whiteColor];
    [sectionView addSubview:whiteView];
    
    UIImageView * imageView1 = [[[UIImageView alloc]init]autorelease];
    imageView1.frame = CGRectMake(2, 2, 55, 28);
    if (section == 0) {
        imageView1.image = [UIImage imageNamed:@"qwer"];
    }else{
        imageView1.image = [UIImage imageNamed:@"asdf"];
    }
    [whiteView addSubview:imageView1];
    
    UILabel * label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(60, 2, 160, 28);
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    if (section == 0) {
        label.text = [NSString stringWithFormat:@"%@与下列食物相宜",sectionTitle];
        label.textColor = [UIColor colorWithRed:0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0];
    }else{
        if (_badFoodArray.count == 0) {
            label.text = [NSString stringWithFormat:@"%@无相克食物",sectionTitle];
            label.textColor = [UIColor colorWithRed:240/255.0 green:110/255.0 blue:110/255.0 alpha:1.0];
        }
        else{
            label.text = [NSString stringWithFormat:@"%@与下列食物相克",sectionTitle];
            label.textColor = [UIColor colorWithRed:240/255.0 green:110/255.0 blue:110/255.0 alpha:1.0];
        }
        
    }
    [whiteView addSubview:label];
    
    
    UIImageView * imageView2 = [[[UIImageView alloc]init]autorelease];
    imageView2.frame = CGRectMake(225, 0, 1, 32);
    imageView2.image = [UIImage imageNamed:@"详情-虚线0"];
    [whiteView addSubview:imageView2];
    
    //食材图片
    UIImageView * materialFoodImage = [[[UIImageView alloc]init]autorelease];
    materialFoodImage.frame = CGRectMake(235, 0, 36, 32);
    NSURL * url = [NSURL URLWithString:_sectionFood.materialImage];
    [materialFoodImage sd_setImageWithURL:url];
    [whiteView addSubview:materialFoodImage];
    
    
    return sectionView;
}


//设置分区头部的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.sectionFood.materialName;
    }
    else{
        return self.sectionFood.materialName;
    }
}

//分区头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

#pragma mark --------TableView 数据源设置-----------
//设置分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}


//设置每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_goodFoodArray count];
    }
    else{
        return [_badFoodArray count];
    }

}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


//设置每行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identfier = @"cell";
    
    GoodAndBadViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    
    if (nil == cell) {
        cell = [[[GoodAndBadViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identfier]autorelease];
    }
    
    if (indexPath.section == 0) {
        
        FoodModel * food = _goodFoodArray[indexPath.row];
        
        cell.showFood = food;
        
    }
    else {
        
        FoodModel * food = _badFoodArray[indexPath.row];
        
        cell.showFood = food;
        
    }
    
    //关闭cell的用户交互
    cell.userInteractionEnabled = NO;
    
    
    return cell;
    
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
