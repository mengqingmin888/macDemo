//
//  TreatmentViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "TreatmentViewController.h"
#import "FoodTreatmentViewController.h"
#import "FoodTreatment.h"
#import "FoodTreatmentViewCell.h"
#import "TreatmentViewCell.h"
#import "DiseaseViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

#import "NetWork.h"


@interface TreatmentViewController ()

{
//    定义两个放置两个tableView的View
    UIView  * treatmentView;
    UIView  * diseaseView;

}



@property(nonatomic,retain)NSMutableArray  * diseaseArray;
//左边的tableView
@property(nonatomic,retain,readonly)UITableView  * treatmentTableView;
//右边的tableView
@property(nonatomic,retain,readonly)UITableView  * diseaseTableView;
//引用第三方，加载数据
@property (nonatomic,retain) MBProgressHUD * hud;
//显示箭头图标的view
//@property(nonatomic,retain,readonly)UIView  *arrowView;

@end



@implementation TreatmentViewController

- (void)dealloc
{
    [treatmentView release];
    [diseaseView release];
    [_treatmentTableView release];
    [_diseaseTableView release];
//    [_arrowView release];
    self.foodArray = nil;
    self.diseaseArray = nil;
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
    
//改变view的背景图片
    self.view.backgroundColor = [UIColor brownColor];

//创建返回按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
//给数组创建空间    
    self.diseaseArray = [NSMutableArray arrayWithCapacity:40];

//    创建tableView视图
    [self setupTableView];
    
    
//通过前一个页面传过来的点击的cell的index设置本页面当前点击的cell的index
    
    NSIndexPath  *indexP = [NSIndexPath indexPathForRow:self.indexPathRow inSection:0];

    [_treatmentTableView selectRowAtIndexPath:indexP animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    FoodTreatment  * treatment = _foodArray[self.indexPathRow];
    
    self.navigationItem.title = treatment.officeName;
    
//    
    [self setupProgressHud];
    
    [self dataSources:treatment.officeId];
    
    
  
}

#pragma  mark -----------UITableView布局-------------------
- (void)setupTableView
{

    //定义放置tableView的UIView和tableView
    treatmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 128, self.view.frame.size.height-64)];
    
    [self.view addSubview:treatmentView];
    
    treatmentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Left-bg"]];
    
    diseaseView = [[UIView alloc] initWithFrame:CGRectMake(130, 0, self.view.frame.size.width-130, self.view.frame.size.height-64)];
    
    [self.view addSubview:diseaseView];
    
    
    diseaseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"疾病bg"]];
    
    _treatmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 128, self.view.frame.size.height-64) style:UITableViewStylePlain];
    //    _treatmentTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Left-bg"]];
    _treatmentTableView.backgroundColor = [UIColor clearColor];
    _treatmentTableView.separatorColor = [UIColor clearColor];
    _treatmentTableView.showsVerticalScrollIndicator = NO;
    _treatmentTableView.bounces = NO;
    [treatmentView addSubview:_treatmentTableView];
    _treatmentTableView.dataSource = self;
    _treatmentTableView.delegate = self;
    _diseaseTableView = [[UITableView alloc] initWithFrame:diseaseView.bounds style:UITableViewStylePlain];
    //    _diseaseTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"疾病bg"]];
    _diseaseTableView.backgroundColor = [UIColor clearColor];
    _diseaseTableView.separatorColor = [UIColor clearColor];
    _diseaseTableView.showsVerticalScrollIndicator = NO;
    [diseaseView addSubview:_diseaseTableView];
    _diseaseTableView.dataSource = self;
    _diseaseTableView.delegate = self;
    



}



#pragma  mark -----------返回按钮响应方法-------------------

//返回按钮响应方法，返回上一级
- (void)didClickBackButtonItemAction : (UIBarButtonItem *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma  mark -----------UITableView必须实现的方法-------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (tableView == _treatmentTableView) {
        return [_foodArray count];
    }
    
    return [_diseaseArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static  NSString  * identifier = @"cell";
    
    static  NSString  * identif = @"foodCell";
    
    if (tableView == _treatmentTableView) {
        UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
    
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor brownColor];
        //改变选中cell时的背景
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"科室选中.png"] ]autorelease];
        cell.textLabel.highlightedTextColor = [UIColor blackColor];
        
        FoodTreatment  * treatment = _foodArray[indexPath.row];
        
        
        cell.textLabel.text = treatment.officeName;
        

        return cell;
        
    }


    TreatmentViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (cell == nil) {
        cell = [[[TreatmentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif] autorelease];
    }
 
    _diseaseTableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor brownColor];
    
    //改变选中cell时的背景
    cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"疾病选中.png"] ]autorelease];
    
    cell.diseaseLabel.highlightedTextColor = [UIColor brownColor];
    
        cell.backgroundColor = [UIColor clearColor];
    
    FoodTreatment  * treatment = _diseaseArray[indexPath.row];
    
    cell.foodTreatment = treatment;
    
    NSURL  *url = [NSURL URLWithString:treatment.imageName];
    
    [cell.diseaseView sd_setImageWithURL:url];
    
    
    return cell;
    
        
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _diseaseTableView) {
        return 80;
    }
    
    return 80;
}


#pragma  mark -----------UITableView点击cell处理方法-------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == _treatmentTableView) {
        
        FoodTreatment  * treatment = _foodArray[indexPath.row];
        
//NSIndexPath  *indexP = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        
        self.navigationItem.title = treatment.officeName;

//调用缓存加载
        [self setupProgressHud];
        
//根据treatment.officeId调用数据处理方法
        [self dataSources:treatment.officeId];
        
    }
    if (tableView == _diseaseTableView) {
        
        FoodTreatment  * treatment = _diseaseArray[indexPath.row];

        DiseaseViewController  * diseaseVC = [[DiseaseViewController alloc] init];
        
        [self.navigationController pushViewController:diseaseVC animated:YES];
        
        diseaseVC.foodTreatment = treatment;
        
        [diseaseVC release];
        
    }
    
}

#pragma  mark -----------UITableView数据处理-------------------

- (void)dataSources : (NSString *)officeId
{
    
    NSString  *urlString = [NSString  stringWithFormat:@"%@%@&is_traditional=0",FoodDiseaseAPI,officeId];
    
    NSURL  * url = [NSURL URLWithString:urlString];
    
    __block  TreatmentViewController   * diseaseVC = self;
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary  * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        移除数组中的所有对象
        [_diseaseArray removeAllObjects];
        
        NSArray  * sourceArray = sourceDic[@"data"];
        for (NSDictionary  * dic in sourceArray) {
            
            FoodTreatment  * foodTreatment = [[FoodTreatment alloc] init];
            [foodTreatment setValuesForKeysWithDictionary:dic];
            [diseaseVC.diseaseArray addObject:foodTreatment];
            
            [foodTreatment release];
        }
        [diseaseVC.diseaseTableView reloadData];
        
        [_hud hide:YES];
        
    }];
    
}

#pragma  mark -----------缓存加载-------------------

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
