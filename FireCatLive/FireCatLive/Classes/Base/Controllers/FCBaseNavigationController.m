//
//  FCBaseNavigationController.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCBaseNavigationController.h"

@interface FCBaseNavigationController ()

@end

@implementation FCBaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:(CGFloat)255.0/255.0 green:(CGFloat)23.0/255.0 blue:(CGFloat)4.0/255.0 alpha:1.0]];
    
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
 
}
/*
 *通过判断确定是否要隐藏底部标签视图
 **/
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
