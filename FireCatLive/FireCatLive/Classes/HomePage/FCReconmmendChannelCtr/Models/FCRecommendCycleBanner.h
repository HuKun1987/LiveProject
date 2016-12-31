//
//  FCRecommendCycleBanner.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FCRecommendCycleBanner;
/*
 *image: "http://static.huomao.com/upload/web/images/advert/20160918135750b5zw1Hol.png",
 img_url: "3785",
 img_title: "贱贱教你上传说~",
 order: "11",
 screenType: 0,
 is_channel: 1,
 type: 1
 **/
@interface FCRecommendCycleBanner : NSObject
/**
 
 */
@property(copy,nonatomic)NSString *image;
/**
 
 */
@property(copy,nonatomic)NSString* img_url;
/**
 
 */
@property(copy,nonatomic)NSString*  img_title;
/**
 
 */
@property(copy,nonatomic)NSString* order;



+(NSArray<FCRecommendCycleBanner*>*)recommendCycleBannerWithContentDataArr:(NSArray*)dataArr;
@end
