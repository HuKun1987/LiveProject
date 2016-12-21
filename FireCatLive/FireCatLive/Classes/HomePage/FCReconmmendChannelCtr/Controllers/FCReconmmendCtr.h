//
//  FCReconmmendCtr.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCRecommendChannelInfo;
@interface FCReconmmendCtr : UICollectionViewController

/**
 
 */
@property(copy,nonatomic)void(^firstCallBack)(NSArray<FCRecommendChannelInfo*>*channelsIfolist);
@end
