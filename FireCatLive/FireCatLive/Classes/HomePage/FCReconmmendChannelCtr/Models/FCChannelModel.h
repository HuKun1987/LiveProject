//
//  FCChannelModel.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FCChannelModel;
@class FCChannelDataModel;
@interface FCChannelModel : NSObject
/**
 
 */
@property(copy,nonatomic)NSString* gid;
/**
 
 */
@property(copy,nonatomic)NSString* icon;
/**
 
 */
@property(copy,nonatomic)NSString* cname;
/**
 
 */
@property(nonatomic,strong)NSArray<FCChannelDataModel*>* data;

+(void)channelModelWithContentOfUrlString:(NSString*)urlString callBackHandler:(void(^)(NSArray<FCChannelModel*>*  callbackData))finishedBack;
@end
