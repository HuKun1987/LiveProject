//
//  FCCycleScrollCell.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/26.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCCycleScrollCell.h"
#import <SDCycleScrollView.h>


@interface FCCycleScrollCell ()<SDCycleScrollViewDelegate>

@end

@implementation FCCycleScrollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
  
        
    }
    return self;
}

-(void)setCycleDataList:(NSArray<FCRecommendCycleBanner *> *)cycleDataList
{
    NSMutableArray* temp = [NSMutableArray arrayWithCapacity:1];
    
    for (FCRecommendCycleBanner* banner in cycleDataList)
    {
        [temp addObject:banner.image];
    }
    
    SDCycleScrollView * cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:temp.copy];
    
    cycle.delegate = self;
    
    [self addSubview:cycle];
    
    [cycle mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.offset(0);
     }];

}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    self.tapCycleImgCallBack(index);
}

@end
