//
//  FCNetWorkDataFactory.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCNetWorkDataFactory.h"
#import "NetWorkTool.h"

@interface FCNetWorkDataFactory ()


@end

@implementation FCNetWorkDataFactory

+(void)detailDataWithGid:(NSString*)gid CallBack:(void(^)(NSArray<FCChannelDataModel*>*))callBackDetailDataList
{

    NSString* urlStr = [NSString stringWithFormat:@"http://api.huomao.com/channels/channelpage.json?time=1482210000&refer=ios&page=1&gid=%@&token=ebfee87264326c711f71d98f86173ab4",gid];
    
    [[NetWorkTool sharedTool]requestDataWithType:AFNRequestTypeGet UrlString:urlStr  Param:nil CompleteBlock:^(id result)
    {
        if ([result[@"data"][@"list"] isKindOfClass:[NSArray class]])
        {
            NSArray* list = result[@"data"][@"list"];
            
            callBackDetailDataList([FCChannelDataModel channelDataWithContentOfArr:list]);
        }
    }];
}
/*
 *第一次默认加载推荐的频道标签
 **/
+(void)homeDefaultRecommendChannelWithCallBack:(void(^)(NSArray<FCRecommendChannelInfo*> * recommendChannelList))callBackRecommendChannelList
{

    [self homeRecomendDataWithCallBackFirst:^(NSArray<FCRecommendCycleBanner *> *cycleDataList)
    {
        cycleDataList = nil;
    } CallBackSecond:^(NSArray<FCHotLiveBanners *> *hotDataList)
    {
        hotDataList = nil;
    } CallBackThird:^(NSArray<FCChannelModel *> *recommendDataList)
    {
        NSMutableArray* temp = [NSMutableArray arrayWithCapacity:1];
        
        [recommendDataList enumerateObjectsUsingBlock:^(FCChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            FCRecommendChannelInfo* info = [[FCRecommendChannelInfo alloc]init];
            info.gid = obj.gid;
            info.cname = obj.cname;
            [temp addObject:info];
        }];
        callBackRecommendChannelList(temp.copy);
    }];
}
/*
 *分类页面数据
 **/
+(void)catergaryDataWithCallBack:(void(^)(NSArray<FCRecommendChannelInfo*>*))callBackCatagaryDataList
{

    [[NetWorkTool sharedTool]requestDataWithType:AFNRequestTypeGet UrlString:@"http://api.huomao.com/User/get_games?uid=1&time=1482149580&refer=ios&mp_openid=0453ea23c148de2439f5d406d38c363a&token=04d75a786ff8d569b58c3167cafd84bd" Param:nil CompleteBlock:^(id result)
     {
         id disSub = result[@"data"][@"disSub"];
         
         if ([disSub isKindOfClass:[NSArray class]])
         {
             NSArray* arr = (NSArray* )disSub;
             callBackCatagaryDataList([FCRecommendChannelInfo channelInfoWithContentOfDataArr:arr]);
         }
     }];
}
/*
 *推荐频道数据
 **/
+(void)homeRecomendDataWithCallBackFirst: (void(^)(NSArray<FCRecommendCycleBanner*> * cycleDataList))callBackCycleDataList CallBackSecond: (void(^)(NSArray<FCHotLiveBanners*> * hotDataList))callBackHotDataList CallBackThird: (void(^)(NSArray<FCChannelModel*> * recommendDataList))callBackRecommendDataList
{
    
    //请求推荐频道数据
    [[NetWorkTool sharedTool]requestDataWithType:AFNRequestTypeGet UrlString:@"http://api.huomao.com/channels/get_rec_games.json?time=1482061680&refer=ios&token=e1bf6e77aaa9fc1f1ae605c11f3e3284" Param:nil CompleteBlock:^(id result)
     {
         if ([result isKindOfClass:[NSDictionary class]])
         {
             NSDictionary* dic = (NSDictionary*)result;
             
             id data = dic[@"data"];
             
             if ([data isKindOfClass:[NSArray class]])
             {
                 NSArray* dataArr = (NSArray*)data;
                 
                 NSArray* modleArr = [FCChannelModel channelModelWithContentDataArr:dataArr];
                 callBackRecommendDataList(modleArr);
             }
             else
             {
                 FCLog(@"result不是一个正确的数组类型");
             }
         }
         else
         {
             FCLog(@"result不是一个正确的字典类型");
         }
     }];
    //热门直播数据
    [[NetWorkTool sharedTool]requestDataWithType:AFNRequestTypeGet UrlString:@"http://api.huomao.com/channels/getRecmmend.json?time=1482061260&refer=ios&token=aaa0cbdaa13db67cf4395d44a5f75474" Param:nil CompleteBlock:^(id result)
     {
         if ([result[@"data"] isKindOfClass:[NSArray class]])
         {
             NSArray* dataArr = (NSArray*)result[@"data"];

             callBackHotDataList([FCHotLiveBanners hotLiveBannersWithContentDataArr:dataArr]);
         }
         else
         {
             FCLog(@"result不是一个正确的数组类型");
         }
     }];
    //轮播图数据
    [[NetWorkTool sharedTool]requestDataWithType:AFNRequestTypeGet UrlString:@"http://api.huomao.com/channels/getBanner.json?time=1482061680&refer=ios&token=e1bf6e77aaa9fc1f1ae605c11f3e3284" Param:nil CompleteBlock:^(id result)
     {
         if ([result[@"data"] isKindOfClass:[NSArray class]])
         {
             NSArray* dataArr = (NSArray*)result[@"data"];

             callBackCycleDataList([FCRecommendCycleBanner recommendCycleBannerWithContentDataArr:dataArr]);
         }
         else
         {
             FCLog(@"result不是一个正确的数组类型");
         }
     }];
}


@end
