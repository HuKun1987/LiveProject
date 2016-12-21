//
//  FCChannelLable.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCChannelLable.h"
#import "FCRecommendChannelInfo.h"
@implementation FCChannelLable

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
     
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.scale = 0;
        self.font = [UIFont systemFontOfSize:20];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLableChannel:)];
        
        [self addGestureRecognizer:tap];
    }
    return self;
}
/*
 *手势的响应事件
 **/
-(void)tapLableChannel:(UITapGestureRecognizer*)tapGesture
{
    self.tapLableCallBack(tapGesture);
}


-(void)setChannel:(FCRecommendChannelInfo *)channel
{
    _channel = channel;
    
    self.text = channel.cname;
    
    [self sizeToFit];
}

- (void)setScale:(float)scale{
    _scale = scale;
    
    //改变颜色
    //白色是最不纯洁的颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
    //字体
    //限定范围在 0.8 - 1.0 之间
    CGFloat minScale = 0.8;
    
    //最终显示的缩放比率
    CGFloat lastScale = minScale + (1 - minScale)*scale;
    self.transform = CGAffineTransformMakeScale(lastScale, lastScale);
}
@end
