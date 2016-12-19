//
//  FCSettingModel.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCSettingModel : NSObject
/**
 
 */
@property(copy,nonatomic)NSString* icon;
/**
 
 */
@property(copy,nonatomic)NSString* name;
/**
 
 */
@property(copy,nonatomic)NSString* accessoryImgName;

/**
 
 */
@property(copy,nonatomic)NSString* pushVCName;
+(NSArray*)settingWithContentOfUrl:(NSURL*)url;
@end
