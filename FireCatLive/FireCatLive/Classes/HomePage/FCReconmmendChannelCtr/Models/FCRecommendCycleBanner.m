//
//  FCRecommendCycleBanner.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCRecommendCycleBanner.h"

@implementation FCRecommendCycleBanner
+(NSArray<FCRecommendCycleBanner*>*)recommendCycleBannerWithContentDataArr:(NSArray*)dataArr
{
    NSMutableArray* temp = [NSMutableArray arrayWithCapacity:1];
    
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary*dic, NSUInteger idx, BOOL * _Nonnull stop)
     {
         FCRecommendCycleBanner* cycle = [[self alloc]init];
         [cycle setValuesForKeysWithDictionary:dic];
         [temp addObject:cycle];
     }];
    
    return temp.copy;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
