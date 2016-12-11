//
//  UIView+extension.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/10.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extension)
/**
 x点坐标
 */
@property(nonatomic,assign)CGFloat originX;
/**
 y点坐标
 */
@property(nonatomic,assign)CGFloat originY;
/**
 宽度
 */
@property(nonatomic,assign)CGFloat widht;
/**
 高度
 */
@property(nonatomic,assign)CGFloat height;
/**
 大小
 */
@property(nonatomic,assign)CGSize size;

@end
