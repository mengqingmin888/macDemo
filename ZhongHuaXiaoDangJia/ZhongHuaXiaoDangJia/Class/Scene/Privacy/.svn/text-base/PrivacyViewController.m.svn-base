//
//  PrivacyViewController.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-10-3.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

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
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"导航3.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10/568.0 * kScreen_height, 220, 40/568.0 * kScreen_height)];
    imageView.image = [UIImage imageNamed:@"隐私声明.png"];
    [self.view addSubview:imageView];
    
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 55/568.0 * kScreen_height, 260, 370/568.0 * kScreen_height)];
    label.text = @"尊敬的用户：\n\t您好！首先感谢您对本应用的支持。\n\t中华小当家非常重视用户信息的保护，在使用《中华小当家》产品和服务前，请您务必仔细阅读并透彻理解本声明。一旦您选择使用，即表示您认可并接受本条款现有内容及其可能随时更新的内容。\n\t(1)本应用为了方便用户，无需登陆即可使用绝大部分功能，所以您无需担心您的个人信息被泄露。\n\t(2)分享美食的功能需要进行登录授权，届时，您可选择授权与否。同时我们也会严格保护您的个人信息安全，不会以任何方式泄露你的个人信息。\n\t(3)互联网上不排除因黑客行为或用户的保管疏忽导致帐号、密码遭他人非法使用，此类情况与中华小当家无关。\n\t如有其他疑问，可发送邮件至：617280164@qq.com，谢谢您的合作。";
    //label.backgroundColor = [UIColor orangeColor];
    //label.font = [UIFont systemFontOfSize:14.50];
    
    if (kScreen_height > 500) {
        label.font = [UIFont systemFontOfSize:14.5];
    }
    if (kScreen_height < 500) {
        label.font = [UIFont systemFontOfSize:13.5];
    }
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    
    
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    //button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.frame = CGRectMake(140,430/568.0 * kScreen_height, 40, 24);
    [button addTarget:self action:@selector(didBackButtonAction:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}



- (void)didBackButtonAction:(UIButton *)button
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
