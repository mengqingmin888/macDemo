//
//  FoodTreatmentViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FoodTreatmentViewController.h"
#import "FoodTreatmentViewCell.h"
#import "FoodTreatment.h"
#import "UIImageView+WebCache.h"
#import "TreatmentViewController.h"

#import "MBProgressHUD.h"

#import "NetWork.h"


@interface FoodTreatmentViewController ()

@property (nonatomic,retain) MBProgressHUD * hud;

@end

@implementation FoodTreatmentViewController

- (void)dealloc
{
//    self.foodTreatmentArray = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    
    self.navigationItem.title = @"对症食疗";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    self.tableView.separatorColor = [UIColor clearColor];

    
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];

    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
    
    self.FoodTreatmentArray = [NSMutableArray arrayWithCapacity:40];
    
    
    [self dataSource];
    
    
    [self setupProgressHud];
    
}



- (void)setupProgressHud
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


//处理接口数据
- (void)dataSource
{
    NSString  *urlString = FoodTreatmentAPI;

    __block  FoodTreatmentViewController   * foodVC = self;
    
    [[NetWork shareInstance]loadingDataWithUrlString:urlString urlExpireInSeconds:30 download:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (data != nil && error == nil) {
            
            NSDictionary  * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray  * sourceArray = sourceDic[@"data"];
            
            for (NSDictionary  * dic in sourceArray) {
                
                FoodTreatment  * foodTreatment = [[FoodTreatment alloc] init];
                [foodTreatment setValuesForKeysWithDictionary:dic];
                [foodVC.foodTreatmentArray addObject:foodTreatment];
                [foodTreatment release];
                
            }
            
            
            
        }else {
            [KGStatusBar showErrorWithStatus:@"请求网络错误,请检查网络"];
        }
        
        
        [self.tableView reloadData];
        
        [_hud hide:YES];
        
    }];
    
    
    
}

//返回按钮响应方法，返回上一级
- (void)didClickBackButtonItemAction : (UIBarButtonItem *)button
{

    [self.navigationController popViewControllerAnimated:YES];

}


//设置分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//设置cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [_foodTreatmentArray count];
}

//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString  * identifier = @"cell";
    
    FoodTreatmentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[FoodTreatmentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
 
//    改变cell的分界线
    self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]];
////改变选中cell时的背景
    cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"科室选中.png"] ]autorelease];
    cell.backgroundColor = [UIColor clearColor];
    
    FoodTreatment  * treatment = _foodTreatmentArray[indexPath.row];
    
    cell.foodTreatment = treatment;
    
    NSURL  *url = [NSURL URLWithString:treatment.imagePath];
    [cell.treatmentView sd_setImageWithURL:url];
    
    return cell;
}

//定义cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    TreatmentViewController  * treatmentVC = [[TreatmentViewController alloc] init];
    
    treatmentVC.foodArray = _foodTreatmentArray;
    treatmentVC.indexPathRow = indexPath.row;
    
    
    [self.navigationController pushViewController:treatmentVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [treatmentVC release];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
