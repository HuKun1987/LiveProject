//
//  FCHomePageViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCHomePageViewCtr.h"
#import "FCRecommendChannelsView.h"
#import "FCDetailChannelCtr.h"
#import "FCReconmmendCtr.h"
#define ChannelsViewHeight 44
@interface FCHomePageViewCtr ()
{
    //推荐频道标签
    FCRecommendChannelsView* _recommendChannelsView;
    /*
     *展示
     **/
    UIScrollView* _contentScrollView;
}



@end

@implementation FCHomePageViewCtr

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self intializationRecommendChannelsView];
    [self intializationContentScrollView];
  
}
-(void)intializationRecommendChannelsView
{

    _recommendChannelsView = ^
    {
        FCRecommendChannelsView *reconmmendView = [[FCRecommendChannelsView alloc]init];
        [self.view addSubview:reconmmendView];
        
        [reconmmendView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.right.offset(0);
            make.top.offset(64);
            make.height.offset(ChannelsViewHeight);
        }];
        return reconmmendView;
    }();
    
}
-(void)intializationContentScrollView
{
    _contentScrollView = ^
    {
        UIScrollView* scroll = [[UIScrollView alloc]init];
        scroll.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self.view addSubview:scroll];
        
        [scroll mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.right.offset(0);
            make.top.equalTo(_recommendChannelsView.mas_bottom);
            make.bottom.offset(-49);
            
        }];
        return scroll;
    }();
    
    [self addContentViews];
}
-(void)addContentViews
{
//    NSMutableArray* ctrArr = [NSMutableArray arrayWithCapacity:1];
    //推荐
    FCReconmmendCtr* recommendCtr = [[FCReconmmendCtr alloc]init];
    
    //其他
//    FCDetailChannelCtr* detailCtr = [[FCDetailChannelCtr alloc]init];
    
    [_contentScrollView addSubview:recommendCtr.view];
    
    [self addChildViewController:recommendCtr];
    
    [recommendCtr didMoveToParentViewController:self];
    
    [recommendCtr.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.height.equalTo(_contentScrollView);
    }];
    
    
//    [ctrArr addObject:recommendCtr.view];
    
//    NSArray* list = @[recommendCtr.view];
//    
//    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
////    
//    for (UIView* view in list)
//    {
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.offset(0);
//            make.width.height.equalTo(_contentScrollView);
//        }];
//    }
    
}

@end
