//
//  GiveUsViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-30.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "GiveUsViewController.h"

#import "MBProgressHUD.h"

@interface GiveUsViewController ()

@property (nonatomic,retain)MBProgressHUD * hub;
@property (nonatomic,retain)UIWebView * webView;

@end

@implementation GiveUsViewController
- (void)dealloc
{
    [_hub release];
    [_webView release];
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
    
    self.navigationItem.title = @"给我评分";
    //导航栏背景图片
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    _webView.scalesPageToFit =YES;
    _webView.delegate =self;
    self.hub = [[MBProgressHUD alloc]initWithView:self.view];
    _hub.frame = self.view.bounds;
    _hub.minSize = CGSizeMake(100, 100);
    _hub.mode = MBProgressHUDModeIndeterminate;
    [_webView addSubview:_hub];
    [_hub show:YES];
    
    NSString * string = @"http://www.lanou3g.com";
    [self loadWebPageWithString:string];
    
    
    
}
- (void)loadWebPageWithString:(NSString*)urlString
{
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL * url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_hub hide:YES];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
    [alterview release];
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
