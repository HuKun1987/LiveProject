//
//  UILabel+extension.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/17.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "UILabel+extension.h"

@implementation UILabel (extension)
+(instancetype)lableWithTextColor:(UIColor *)textColor TextFont:(UIFont *)font
{
    UILabel* lable = [[self alloc]init];
    lable.textColor = textColor;
    lable.font = font;
    return lable;
}
@end
