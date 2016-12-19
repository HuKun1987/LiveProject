//
//  FCLoginViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCLoginViewCtr.h"

@interface FCLoginViewCtr ()

@end

@implementation FCLoginViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItems = nil;
    self.title = @"登录";
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(InPutDone)];
    
}
-(void)InPutDone
{


}

@end
