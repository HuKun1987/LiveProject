//
//  FCRecommendChannelInfo.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FCRecommendChannelInfo;
@interface FCRecommendChannelInfo : NSObject
/**
 
 */
@property(copy,nonatomic)NSString* gid;
/**
 
 */
@property(copy,nonatomic)NSString* cname;
/**
 
 */
@property(copy,nonatomic)NSString* images;



+(NSArray<FCRecommendChannelInfo*>*)channelInfoWithContentOfDataArr:(NSArray*)dataArr;

@end
