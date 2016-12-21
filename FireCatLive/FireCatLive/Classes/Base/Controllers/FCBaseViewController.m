//
//  FCBaseViewController.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/10.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCBaseViewController.h"

#define FCUserAccountKey  @""

@interface FCBaseViewController ()

@end

@implementation FCBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor whiteColor];
     self.isLogin = YES;
    [self setUPUI];
}

-(void)setUPUI{
    
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem* searchItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"search_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    
    UIBarButtonItem* history = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"history"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(lookAtHistorySeacrh)];
    
    
    self.navigationItem.rightBarButtonItems = @[searchItem, history];
}

/*
 *获取本地保存的用户名和密码并请求登录
 **/
-(void)getLocalSaveUserAccoutAndPassWordAndRequest2Login
{
    NSString* userAccount =  [[NSUserDefaults standardUserDefaults]stringForKey:FCUserAccountKey];
    
    NSString* password = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:userAccount];
    
    NSString* md5PWd = [password md5String];
}

-(void)lookAtHistorySeacrh
{
    
    
}

-(void)searchAction
{
    
    
}
@end
