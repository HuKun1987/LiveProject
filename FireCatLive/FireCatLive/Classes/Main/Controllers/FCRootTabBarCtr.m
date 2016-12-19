//
//  FCRootTabBarCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/10.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCRootTabBarCtr.h"
#import "FCHomePageViewCtr.h"
#import "FCLivePageViewCtr.h"
#import "FCCatagryPageViewCtr.h"
#import "FCMinePageViewCtr.h"
#import "FCCoustomTabBar.h"
#import "FCBaseNavigationController.h"
@interface FCRootTabBarCtr ()

@end

@implementation FCRootTabBarCtr

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self coustomTabBarWithTabBarClassName:@"FCCoustomTabBar"];
    [self addViewControllers];

    self.tabBar.tintColor = [UIColor redColor];
}


-(void)addViewControllers
{
    UIViewController* home = [self creatChildControllerWithTitle:@"首页" BarImgName:@"tab_home" ClassName:@"FCHomePageViewCtr"];
    
    UIViewController* live = [self creatChildControllerWithTitle:@"直播" BarImgName:@"tab_live" ClassName:@"FCLivePageViewCtr"];
    UIViewController* catagary = [self creatChildControllerWithTitle:@"分类" BarImgName:@"tab_list" ClassName:@"FCCatagryPageViewCtr"];
    UIViewController* mine = [self creatChildControllerWithTitle:@"我的" BarImgName:@"tab_me" ClassName:@"FCMinePageViewCtr"];
    self.viewControllers = @[home,live,catagary,mine];
}
//设置子控制器；
-(UIViewController*)creatChildControllerWithTitle:(NSString*)title BarImgName:(NSString*)imgName ClassName:(NSString*)className
{
    Class class = NSClassFromString(className);
    
    UIViewController* vc = [[class alloc]init];
    
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imgName];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_on",imgName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FCBaseNavigationController * nav = [[FCBaseNavigationController alloc]initWithRootViewController:vc];
    return nav;
}
/*
 *根据需要看是否需要扩展tabBar
 **/
-(void)coustomTabBarWithTabBarClassName:(NSString*)ClassName
{
    Class class = NSClassFromString(ClassName);
    
    UITabBar* bar = [[class alloc]init];
    
    [self setValue:bar forKey:@"tabBar"];
}


@end
