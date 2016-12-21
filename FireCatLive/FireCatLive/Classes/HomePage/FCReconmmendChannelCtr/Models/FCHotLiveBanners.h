//
//  FCHotLiveBanners.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FCHotLiveBanners;
/*
 *cid: "8439",
 channel: "‘王’一样的男人",
 gid: "53",
 image: "http://livepic.huomao.com/8439/i_10.jpg?1482195600",
 type: 1,
 screenType: 0,
 channels: "‘王’一样的男人"
 **/

@interface FCHotLiveBanners : NSObject
/**
 
 */
@property(copy,nonatomic)NSString* gid;
/**
 
 */
@property(copy,nonatomic)NSString* cid;
/**
 
 */
@property(copy,nonatomic)NSString* image;
/**
 
 */
@property(copy,nonatomic)NSString* channel;

+(NSArray<FCHotLiveBanners*>*)hotLiveBannersWithContentDataArr:(NSArray*)dataArr;
@end
