//
//  FCLiveRoomCell.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCLiveRoomCell.h"

@implementation FCLiveRoomCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.textLable = ^{
            UILabel* lable = [[UILabel alloc]init];
            [self addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.offset(0);
            }];
            return lable;
        }();
    }
    return self;
}

@end
