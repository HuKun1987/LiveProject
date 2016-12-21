//
//  FCHotLiveBanners.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCHotLiveBanners.h"

@implementation FCHotLiveBanners

+(NSArray<FCHotLiveBanners*>*)hotLiveBannersWithContentDataArr:(NSArray*)dataArr
{
    NSMutableArray* temp = [NSMutableArray arrayWithCapacity:1];
    
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary*dic, NSUInteger idx, BOOL * _Nonnull stop)
    {
        FCHotLiveBanners* hot = [[self alloc]init];
        [hot setValuesForKeysWithDictionary:dic];
        [temp addObject:hot];
    }];
    
    return temp.copy;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
