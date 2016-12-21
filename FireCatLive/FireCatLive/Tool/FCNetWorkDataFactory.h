//
//  FCNetWorkDataFactory.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *首页推荐页面模型头文件
 **/
//推荐模型数组(colloection的组头和item对应的数据的模型)
#import "FCChannelModel.h"
//推荐的所有频道的模型数组(item对应的模型)
#import "FCChannelDataModel.h"
//频道标签对应的模型（分类页面和推荐对应lable锁携带的信息等）
#import "FCRecommendChannelInfo.h"
//热门直播的模型
#import "FCHotLiveBanners.h"
//轮播图对应的模型
#import "FCRecommendCycleBanner.h"


@interface FCNetWorkDataFactory : NSObject

/*
 *请求主页推荐频道对应的数据信息；
 **/
+(void)homeRecomendDataWithCallBackFirst: (void(^)(NSArray<FCRecommendCycleBanner*> * cycleDataList))callBackCycleDataList CallBackSecond: (void(^)(NSArray<FCHotLiveBanners*> * hotDataList))callBackHotDataList CallBackThird: (void(^)(NSArray<FCChannelModel*> * recommendDataList))callBackRecommendDataList;
/*
 *第一次默认加载推荐的频道标签
 **/

+(void)homeDefaultRecommendChannelWithCallBack:(void(^)(NSArray<FCRecommendChannelInfo*> * recommendChannelList))callBackRecommendChannelList;
/*
 *请求加工好的分类页面数据
 **/
+(void)catergaryDataWithCallBack:(void(^)(NSArray<FCRecommendChannelInfo*>*))callBackCatagaryDataList;
/*
 *通过gid请求详情的数据信息
 **/
+(void)detailDataWithGid:(NSString*)gid CallBack:(void(^)(NSArray<FCChannelDataModel*>*))callBackDetailDataList;
@end
