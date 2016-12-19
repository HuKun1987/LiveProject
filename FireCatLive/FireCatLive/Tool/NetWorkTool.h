//
//  NetWorkTool.h
//  AsynToDownLoad
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSInteger, RequestType)
{
    AFNRequestTypeGet,
    AFNRequestTypePost,
};

typedef void(^Complete)(id result);

@interface NetWorkTool : AFHTTPSessionManager

+(instancetype)sharedTool;

-(void)requestDataWithType:(RequestType)requestType   UrlString:(NSString*)urlStr Param:(id)param CompleteBlock:(Complete)finished;
@end
