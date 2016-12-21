//
//  FCRecommendChannelInfo.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCRecommendChannelInfo.h"

@implementation FCRecommendChannelInfo

+(NSArray<FCRecommendChannelInfo *> *)channelInfoWithContentOfDataArr:(NSArray *)dataArr
{
    
    NSMutableArray* temp = [NSMutableArray array];
    
    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* dic = (NSDictionary*)obj;
            FCRecommendChannelInfo * info = [[self alloc]init];
            
            [info setValuesForKeysWithDictionary:dic];
            [temp addObject:info];
        }
    }];
    return temp.copy;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
