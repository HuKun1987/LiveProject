//
//  FCRightImgBtn.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCRightImgBtn.h"

@implementation FCRightImgBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
      
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.originX = 10;
//    self.layer.cornerRadius = self.width*0.015;
//    self.layer.masksToBounds = YES;
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = self.selected? [UIColor redColor].CGColor:[UIColor lightGrayColor].CGColor;
//      self.clipsToBounds  = YES;
}
@end
