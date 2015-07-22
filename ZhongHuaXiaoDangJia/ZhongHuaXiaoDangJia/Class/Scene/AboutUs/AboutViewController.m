//
//  AboutViewController.m
//  ZhongHuaXiaoDangJia
//
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    
    
    
    self.navigationItem.title = @"关于我们";
    
    //设置导航栏背景图片
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem  * backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickReturnAction:)];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = backButton;
    [backButton release];
    
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"women"];
    [self.view addSubview:imageView];
    [imageView release];
    
    
    
    
    
}

- (void)didClickReturnAction : (UIBarButtonItem *)button
{

    [self dismissViewControllerAnimated:YES completion:^{
    }];

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