//
//  FCChannelModel.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCChannelModel.h"
#import "FCChannelDataModel.h"

@implementation FCChannelModel

+(void)channelModelWithContentOfUrlString:(NSString *)urlString callBackHandler:(void (^)(NSArray<FCChannelModel *> *))finishedBack
{
    [[NetWorkTool sharedTool]requestDataWithType:AFNRequestTypeGet UrlString:urlString Param:nil CompleteBlock:^(id result)
     {
         if ([result isKindOfClass:[NSDictionary class]])
         {
             NSDictionary* dic = (NSDictionary*)result;
             
             id data = dic[@"data"];
             
             if ([data isKindOfClass:[NSArray class]])
             {
                 NSMutableArray* mutebleArr = [NSMutableArray arrayWithCapacity:1];
                 NSArray* dataArr = (NSArray*)data;
                 
                 [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
                 {
                     if ([obj isKindOfClass:[NSDictionary class]])
                     {
                         NSDictionary* dict = (NSDictionary*)obj;
                         
                         FCChannelModel* channel = [[self alloc]init];
                         [channel setValuesForKeysWithDictionary:dict];
                         [mutebleArr addObject:channel];
                     }
                 }];
                 finishedBack(mutebleArr.copy);
             }
         }else
         {
             FCLog(@"result不是一个字典类型");
         }
     }];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"data"])
    {
        if ([value isKindOfClass:[NSArray class]])
        {
            self.data = [FCChannelDataModel channelDataWithContentOfArr:value];
        }
    }
}
@end
