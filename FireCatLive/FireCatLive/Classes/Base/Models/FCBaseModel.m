//
//  FCBaseModel.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/27.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCBaseModel.h"
#import <objc/runtime.h>

@implementation FCBaseModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++)
    {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //利用KVC取值
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        unsigned int outCount;
        
        Ivar * ivars = class_copyIvarList([self class], &outCount);
        
        for (int i = 0; i < outCount; i ++)
        {
            Ivar ivar = ivars[i];
            
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //利用KVC存值
            [self setValue:[coder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}
@end
