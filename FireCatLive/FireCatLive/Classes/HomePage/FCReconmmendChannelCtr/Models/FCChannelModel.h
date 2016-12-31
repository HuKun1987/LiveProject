//
//  FCChannelModel.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCBaseModel.h"
@class FCChannelModel;
@class FCChannelDataModel;
@interface FCChannelModel : FCBaseModel
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

/**
 
 */
@property(nonatomic,assign)BOOL isAccessoryHidden;

+(NSArray<FCChannelModel*>*)channelModelWithContentDataArr:(NSArray*)dataArr;
@end
