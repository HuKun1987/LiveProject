//
//  FCBaseViewController.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/10.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCBaseViewController.h"

#define FCUserAccountKey  @"UserAccount"



@interface FCBaseViewController ()

@end

@implementation FCBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor whiteColor];
    [self getLocalSaveUserAccoutAndPassWordAndRequest2Login];
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
    //用户名存储在偏好设置
    NSString* userAccount =  [[NSUserDefaults standardUserDefaults]stringForKey:FCUserAccountKey];
    //密码保存到钥匙串
    NSString* password = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:userAccount];
    
    NSString* md5PWd = [password md5String];
 
    if (userAccount != nil && password != nil)
    {
        NSDictionary* para = @{@"username":userAccount,@"password":md5PWd};
        
        [FCNetWorkDataFactory requestToLoginWithUrlString:@"http://localhost/login.php" Para:para FinishedCallBack:^(id responseResult)
        {
            if (responseResult != nil)
            {
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:KApploginState];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }];
    }else
    {
        self.isLogin = NO;
    }
    
}

-(void)lookAtHistorySeacrh
{
    
    
}

-(void)searchAction
{
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//       self.isLogin = [[NSUserDefaults standardUserDefaults]boolForKey:KApploginState];

}
@end
