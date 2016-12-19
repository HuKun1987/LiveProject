//
//  FCSettingModel.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCSettingModel.h"

@implementation FCSettingModel
+(NSArray *)settingWithContentOfUrl:(NSURL*)url
{
    NSArray* dataArr = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray* temp = [NSMutableArray arrayWithCapacity:1];
    
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FCSettingModel * model = [[FCSettingModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [temp addObject:model];
    }];
    
    return temp.copy;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
