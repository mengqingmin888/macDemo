//
//  FoodCollectViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FoodCollectViewController.h"
#import "FoodModel.h"
#import "FavoriteDataHandle.h"
#import "FoodDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "FoodCollectViewCell.h"

@interface FoodCollectViewController ()

{

    BOOL  rightButtonEdit;
    
    
}
@property(nonatomic,retain)UICollectionView  * collectionView;


@end

@implementation FoodCollectViewController

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
    
//    导航栏标题
    self.navigationItem.title = @"收藏列表";
    //导航栏背景图片
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
//   记录按钮状态
     rightButtonEdit = NO;
////    右上方添加按钮
        UIBarButtonItem   * rightButton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(didClick:)];
    rightButton.tintColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = rightButton;
  
    //    创建collectionView的布局，使用系统的网格样式。
    UICollectionViewFlowLayout  * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //    设置section的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,64,0);
    //     设置最小行边距
        flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    //    创建一个collectionView的集合视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    [self.view addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    //    注册集合视图中使用的cell类型及重用标识
    [_collectionView registerClass:[FoodCollectViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
//    执行方法，从数据库中读取存储的数据，存储的即为收藏的数据
    [[FavoriteDataHandle shareInstance] setupFoodModelDataSource];
    
   
}

- (void)didClick : (UIBarButtonItem *)button
{

    if(rightButtonEdit == NO){
      button.title = @"完成";
    rightButtonEdit = YES;
        
        [_collectionView reloadData];

        
        
    }else if (rightButtonEdit == YES) {
        button.title = @"删除";
        rightButtonEdit = NO;
        
        
        [_collectionView reloadData];
        
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    
    return 1;
}

//显示的个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return [[FavoriteDataHandle shareInstance] countOfFoodModel];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    FoodCollectViewCell  * foodCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    FoodModel  *foodModel = [[FavoriteDataHandle shareInstance] foodModelForRow:indexPath.row];
    
    NSURL  * url = [NSURL URLWithString:foodModel.imagePathThumbnails];

    [foodCell.showImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"sdefaultImage"]];
    
    foodCell.nameLabel.text = foodModel.name;

    foodCell.deleteImageView.image = [UIImage imageNamed:@"我的-收藏删除.png"];
    
   if (rightButtonEdit == YES) {
       
    [foodCell.showImageView addSubview:foodCell.deleteImageView];
       
   }else if (rightButtonEdit == NO){
   
       [foodCell.deleteImageView removeFromSuperview];
   }
 
    
    return foodCell;
}

//设置collectionView中每一个view的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{


    return CGSizeMake(160,126);

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //    删除
    if (rightButtonEdit == YES) {
        

        
        [[FavoriteDataHandle shareInstance] deleteFoodModelForRow:indexPath.row];
        
        [collectionView reloadData];
        
    }
    else if(rightButtonEdit == NO){
    FoodDetailViewController  * foodDetailVC = [[FoodDetailViewController alloc] init];
    
    foodDetailVC.detailFood = [[FavoriteDataHandle shareInstance] foodModelForRow:indexPath.row];
    
    //是否添加导航栏右侧按钮
    foodDetailVC.isRightBarButtonItemAppear = NO;
    
    [self.navigationController pushViewController:foodDetailVC animated:YES];
    
    [foodDetailVC release];
    }

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