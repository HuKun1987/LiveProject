//
//  FCChannelLable.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCRecommendChannelInfo;

@interface FCChannelLable : UILabel
/**
 *  供外部设置值,大小是从0~1
 */
@property (nonatomic, assign) float scale;

/**
 
 */
@property(nonatomic,strong)FCRecommendChannelInfo* channel;

/**
 
 */
@property(copy,nonatomic)void(^tapLableCallBack)( UITapGestureRecognizer* tapGesture);
@end
