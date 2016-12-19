//
//  FCChannelLable.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCChannelLable.h"

@implementation FCChannelLable

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
    }
    return self;
}

-(void)setIsSelected:(BOOL)isSelected
{
    if (isSelected)
    {
        self.textColor = [UIColor redColor];
        self.font = [UIFont systemFontOfSize:20];
    }
    else
    {
     self.font = [UIFont systemFontOfSize:18];
        self.textColor = [UIColor blackColor];
    }

}
@end
