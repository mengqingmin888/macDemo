//
//  StepTableViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-19.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "StepTableViewController.h"

#import "FoodDetailViewController.h"

#import "StepViewCell.h"

#import "HomePageViewController.h"

#import "FoodModel.h"
#import "MBProgressHUD.h"

#import "CorrelationViewController.h"

#import "KGStatusBar.h"

#import "NetWork.h"

@interface StepTableViewController ()


@property (nonatomic,retain) NSMutableArray * allStepArray;
@property (nonatomic,retain) MBProgressHUD * hud;
@property (nonatomic,retain) NSString * materialStr;

@end

@implementation StepTableViewController

- (void)dealloc
{
    self.stepFood = nil;
    self.allStepArray = nil;
    self.hud = nil;
    self.materialStr = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"cailiaozuofa.png"];
        self.tabBarItem.title = @"材料做法";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.tableView.frame = CGRectMake(0, 64, 320, 568-64-44);
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    self.navigationItem.title = @"材料and做法";
    
    //去除cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //左上方返回图标
    UIImage * backImage = [[UIImage imageNamed:@"btn_nav_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加左边按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(didBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
    
    
    //拼接材料 （即把 原料和调料 ，组合到一起）
    self.materialStr = [NSString stringWithFormat:@"%@，%@",_stepFood.fittingRestriction,_stepFood.method];
    
    
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
    NSString * string = StepAPI;
    NSString * urlString = [string stringByReplacingOccurrencesOfString:@"vegetable_number" withString:self.stepFood.vegetable_id];
    
    //NSURL * url = [NSURL URLWithString:urlString];
    
    //设置请求
    //NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    __block StepTableViewController * stepVC = self;
    
    self.allStepArray = [NSMutableArray arrayWithCapacity:40];
    
    [[NetWork shareInstance]loadingDataWithUrlString:urlString urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data != nil && error == nil) {
            //data是完整数据
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers  error:nil];
            
            NSArray * oneArray = dic[@"data"];
            
            for (NSDictionary * stepDic in oneArray) {
                
                FoodModel * food = [[FoodModel alloc]init];
                
                [food setValuesForKeysWithDictionary:stepDic];
                
                [stepVC.allStepArray addObject:food];
                
                [food release];
                
            }
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        
        //重载数据
        [stepVC.tableView reloadData];
        
        //菊花结束
        [_hud hide:YES];
        
    }];

    
}



#pragma mark ----------------- 导航栏按钮 -----------------
//返回按钮
- (void)didBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------- 自定义section -----------------

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = [self.class sectionHeight:self.materialStr]; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

//自定义section
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return  nil;
    }
    
    UIView * sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 220)] autorelease];
    [sectionView setBackgroundColor:[UIColor blackColor]];
    
    
    
    UILabel * label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(0, 0, 320, [self.class sectionHeight:sectionTitle]);
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    [sectionView addSubview:label];
    
    
    UILabel * label2 = [[[UILabel alloc] init] autorelease];
    label2.frame = CGRectMake(10, 10, 50, 25);
    //label2.backgroundColor = [UIColor cyanColor];
    label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    label2.text = @"材料:";
    label2.textColor = [UIColor redColor];
    [label addSubview:label2];
    
    
    UILabel * materialLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 250, [self.class p_materialTextHeight:sectionTitle])];
    //materialLabel.backgroundColor = [UIColor yellowColor];
    materialLabel.font = [UIFont systemFontOfSize:14.0];
    materialLabel.numberOfLines = 0;
    materialLabel.text = sectionTitle;
    materialLabel.textColor = [UIColor colorWithRed:139/255.0 green:69/255.0 blue:19/255.0 alpha:1.0];
    [label addSubview:materialLabel];
    
    
    return sectionView;
    
}

//设置分区头部的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return self.materialStr;
}



//分区头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.class sectionHeight:self.materialStr];
}


//自适应高度(section的高度)
+ (CGFloat)sectionHeight:(NSString *)materialString
{
    
    //不变的部分
    CGFloat unchangeHeight = 10 + 10;
    
    //计算变化的部分
    //类方法中的self表示类
    CGFloat changeHeight = [self.class p_materialTextHeight:materialString];
    
    return unchangeHeight + changeHeight;
    
}

//计算材料文本的高度
+ (CGFloat)p_materialTextHeight:(NSString *)text
{
    
    NSDictionary * textDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(250, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    
    
    return textRect.size.height;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_allStepArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _allStepArray.count - 1) {
        return 220 + 49;
    }
    else{
       return 220;
    }
    
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    
    StepViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[StepViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]autorelease];
    }
    
    cell.whiteImage.image = [UIImage imageNamed:@"详情页-材料背景"];
    
    FoodModel * food = _allStepArray[indexPath.row];
    
    cell.showFood = food;
    
    //cell的用户交互关闭，即不可点击
    cell.userInteractionEnabled = NO;
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
