//
//  FCChannelDataModel.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCChannelDataModel.h"

@implementation FCChannelDataModel
+(NSArray<FCChannelDataModel *> *)channelDataWithContentOfArr:(NSArray *)dataArr
{
    NSMutableArray* temp = [NSMutableArray arrayWithCapacity:1];
    
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL * _Nonnull stop)
    {
        FCChannelDataModel* dataModel = [[self alloc]init];
        [dataModel setValuesForKeysWithDictionary:dic];
        [temp addObject:dataModel];
    }];
    
    
    return temp.copy;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
