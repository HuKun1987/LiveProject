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

+(NSArray<FCChannelModel*>*)channelModelWithContentDataArr:(NSArray*)dataArr
{
    NSMutableArray* mutebleArr = [NSMutableArray arrayWithCapacity:1];
  
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
    return  mutebleArr.copy;
}

//拦截key将对应的value转变成模型数据；
-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"data"])
    {
        if ([value isKindOfClass:[NSArray class]])
        {
            self.data = [FCChannelDataModel channelDataWithContentOfArr:value];
        }
    }else{
    
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
