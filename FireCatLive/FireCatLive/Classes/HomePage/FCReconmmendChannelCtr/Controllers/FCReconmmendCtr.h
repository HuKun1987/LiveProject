//
//  FCReconmmendCtr.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCDetailChannelCtr.h"
@class FCRecommendChannelInfo;
@interface FCReconmmendCtr : FCDetailChannelCtr

/**
 
 */
@property(copy,nonatomic)void(^firstCallBack)(NSArray<FCRecommendChannelInfo*>*channelsIfolist);
@end
