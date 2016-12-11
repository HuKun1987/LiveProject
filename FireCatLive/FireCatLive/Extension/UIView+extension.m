//
//  UIView+extension.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/10.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "UIView+extension.h"

@implementation UIView (extension)


//重写set方法
-(void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}
-(void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}
-(void)setWidht:(CGFloat)widht
{
    CGRect frame = self.frame;
    frame.size.width = widht;
    self.frame = frame;
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
//重写get方法
-(CGFloat)originX
{
    return self.frame.origin.x;
}
-(CGFloat)originY
{
    return self.frame.origin.y;
}
-(CGFloat)widht
{
    return self.frame.size.width;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
-(CGSize)size
{
    return self.frame.size;
}
@end
