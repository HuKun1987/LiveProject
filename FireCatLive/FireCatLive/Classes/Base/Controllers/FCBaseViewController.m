//
//  FCBaseViewController.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/10.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCBaseViewController.h"

@interface FCBaseViewController ()

@end

@implementation FCBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor whiteColor];
     self.isLogin = NO;
    [self setUPUI];
}

-(void)setUPUI{
    
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem* searchItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"search_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    
    UIBarButtonItem* history = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"history"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(lookAtHistorySeacrh)];
    
    
    self.navigationItem.rightBarButtonItems = @[searchItem, history];
}
-(void)lookAtHistorySeacrh
{
    
    
}

-(void)searchAction
{
    
    
}
@end
