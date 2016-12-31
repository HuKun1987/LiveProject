//
//  NetWorkTool.m
//  AsynToDownLoad
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "NetWorkTool.h"

@implementation NetWorkTool

NetWorkTool* _instance;
+(instancetype)sharedTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        _instance = [[self alloc]init];
        _instance = [self manager];
        // 超时
        _instance.requestSerializer.timeoutInterval = 10;
        
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html",nil];
        
//        _instance.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return _instance;
}

-(void)requestDataWithType:(RequestType)requestType UrlString:(NSString *)urlStr Param:(id)param CompleteBlock:(Complete)finished
{
    
    void (^success)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
     
        finished(responseObject);
    };

    void (^failure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"%@",error);
    };
  
    if (requestType == AFNRequestTypeGet)
    {
        [_instance GET:urlStr parameters:param progress:nil success:success failure:failure];
        
    }else if (requestType == AFNRequestTypePost){
    
        [_instance POST:urlStr parameters:param progress:nil success:success failure:failure];
    }
}

@end
