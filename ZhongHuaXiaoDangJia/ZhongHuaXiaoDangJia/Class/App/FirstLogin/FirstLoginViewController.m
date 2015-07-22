//
//  FirstLoginViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-23.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "FirstLoginViewController.h"

#import "HomePageViewController.h"

#import "DDMenuController.h"
#import "LeftMenuViewController.h"

#import "AppDelegate.h"

@interface FirstLoginViewController ()
{
    UIPageControl  *_pageControl;
    UIScrollView   *_scrollView;
    
}

@end

@implementation FirstLoginViewController

- (void)dealloc
{
    [_pageControl release];
    [_scrollView release];
    self.menuController = nil;
    
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
    //创建scrollview
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    //设置滚动区域
    [self.view addSubview:_scrollView];
    
    UIImageView * view1= [[UIImageView alloc]initWithFrame:self.view.bounds];
    view1.image = [UIImage imageNamed:@"image111.png"];
    [_scrollView addSubview:view1];
    [view1 release];
    
    UIImageView * view2= [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_width, 0, kScreen_width, kScreen_height)];
    view2.image = [UIImage imageNamed:@"image222.png"];
    [_scrollView addSubview:view2];
    [view2 release];
    
    UIImageView * view3= [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_width * 2, 0, kScreen_width, kScreen_height)];
    view3.image = [UIImage imageNamed:@"image333.png"];
    [_scrollView addSubview:view3];
    [view3 release];
    
    UIImageView * view4= [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_width * 3, 0, kScreen_width, kScreen_height)];
    view4.image = [UIImage imageNamed:@"image444.png"];
    [_scrollView addSubview:view4];
    [view4 release];
    
    UIImageView * view5= [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_width * 4, 0, kScreen_width, kScreen_height)];
    view5.image = [UIImage imageNamed:@"image555.png"];
    [_scrollView addSubview:view5];
    [view5 release];
    
    //设置滚动区域
    _scrollView.contentSize =CGSizeMake(kScreen_width * 5, kScreen_height);
    //设置分页效果
    _scrollView.pagingEnabled = YES;
    //修改contentoffset，影响仕途位置
    //    _scrollView.contentOffset = CGPointMake(0, 0);
    
    //设置能否滚动
    _scrollView.scrollEnabled= YES;
    
    _scrollView.delegate = self;
    
    //创建pagecontrol
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(60, kScreen_height - 40/568.0 * kScreen_height, 200, 20/568.0 * kScreen_height)];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages = 5;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [_pageControl addTarget:self action:@selector(handlePageControlChangeAction:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage * image = [UIImage imageNamed:@"开始体验2.png"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(kScreen_width * 4 + 70, kScreen_height - 90/568.0 * kScreen_height, 180, 35/568.0 * kScreen_height);
    [button addTarget:self action:@selector(didRootViewControllerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    
}

- (void)didRootViewControllerBtnAction:(UIButton *)btn
{
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate setupViewController];
    delegate.window.rootViewController = (UIViewController *)delegate.menuController;
    
}

//pagecontrol的响应方法
- (void)handlePageControlChangeAction:(id)sender
{
    
    CGFloat offsetX = _scrollView.bounds.size.width * _pageControl.currentPage;
    
    //根据pagecontrol的当前页数，设置scollview的controffset，显示对应的页面
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
//结束减速时触发(停⽌止时)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前第几页
    CGPoint offset= scrollView.contentOffset;
    NSInteger pageNumber = offset.x /scrollView.bounds.size.width;
    _pageControl.currentPage = pageNumber;
    
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
