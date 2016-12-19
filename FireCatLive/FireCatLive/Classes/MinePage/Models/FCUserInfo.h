//
//  FCUserInfo.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/17.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCUserInfo : NSObject
/**
 头像名称
 */
@property(copy,nonatomic)NSString* iconName;
/**
 昵称
 */
@property(copy,nonatomic)NSString* screenName;
/**
 猫币
 */
@property(nonatomic,strong)NSNumber* catCoin;
/**
 猫豆
 */
@property(nonatomic,strong)NSNumber* catPeas;
@end
