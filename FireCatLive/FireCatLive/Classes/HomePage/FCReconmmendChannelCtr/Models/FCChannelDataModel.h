//
//  FCChannelDataModel.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FCChannelDataModel;
@interface FCChannelDataModel : NSObject
/**
 
 */
@property(copy,nonatomic)NSString* channel;
/**
 
 */
@property(copy,nonatomic)NSString* room_number;
/**
 
 */
@property(copy,nonatomic)NSString* user_name;
/**
 
 */
@property(copy,nonatomic)NSString* image;
/**
 
 */
@property(copy,nonatomic)NSString* tj_pic;
/**
 
 */
@property(copy,nonatomic)NSString* uid;
/**
 频道类型
 */
@property(copy,nonatomic)NSString*  gid ;
/**
 
 */
@property(copy,nonatomic)NSString* cid;
/**
 访客数
 */
@property(copy,nonatomic)NSString* views;
/**
 具体访客数值
 */
@property(copy,nonatomic)NSString* originviews;
/**
 
 */
@property(copy,nonatomic)NSString* get_url_rule;

/**
 
 */
@property(copy,nonatomic)NSString* channels;
+(NSArray<FCChannelDataModel*>*)channelDataWithContentOfArr:(NSArray*)dataArr;
@end
