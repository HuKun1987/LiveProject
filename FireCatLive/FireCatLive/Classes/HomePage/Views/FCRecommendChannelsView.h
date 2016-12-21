//
//  FCRecommendChannelsView.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCRecommendChannelInfo;
@class FCChannelLable;
@interface FCRecommendChannelsView : UIView
/**
 
 */
@property(nonatomic,strong)NSArray<FCRecommendChannelInfo*>* channeList;
@property (weak, nonatomic) IBOutlet UIScrollView *channelsView;
/**
 
 */
@property(nonatomic,strong)FCChannelLable* selectedLable;

/**
 控件数组
 */
@property (nonatomic, strong) NSMutableArray *channelLabels;

/**
 
 */
@property(copy,nonatomic)void(^scrollBackPage)(NSInteger currentPage);

-(void)updateLablesWhenSelectedNew;
@end
