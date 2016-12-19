//
//  FCReconmmendCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCReconmmendCtr.h"
#import "FCLiveRoomCell.h"
#import "FCChannelModel.h"
#import "FCChannelDataModel.h"
@interface FCReconmmendCtr ()<UICollectionViewDelegateFlowLayout>
/**
 存放推荐频道的推荐频道的数组
 */
@property(nonatomic,strong)NSArray<FCChannelModel*>* channelList;
/**
 
 */
@property(nonatomic,strong)NSArray<FCChannelDataModel*>* hotRecommendLiveList;
@end

@implementation FCReconmmendCtr

static NSString * const reuseIdentifier = @"Cell";
/*
 *存放推荐频道的数组
 **/
-(NSArray <FCChannelModel*>*)channelList
{
    if (!_channelList) {
        _channelList = [NSArray array];
    }
    return _channelList;
}
/*
 *存放热门直播的数组
 **/
-(NSArray<FCChannelDataModel *> *)hotRecommendLiveList
{
    if (!_hotRecommendLiveList) {
        _hotRecommendLiveList = [NSArray array];
    }
    return _hotRecommendLiveList;
}
- (instancetype)init
{
    UICollectionViewFlowLayout* recommendLayOut = [[ UICollectionViewFlowLayout alloc]init];
     recommendLayOut.scrollDirection =UICollectionViewScrollDirectionVertical;
    if (self = [super initWithCollectionViewLayout:recommendLayOut])
    {
    
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self loadData];
    //热门直播数据
 
//    [[NetWorkTool sharedTool]requestDataWithType:AFNRequestTypeGet UrlString:@"http://api.huomao.com/channels/getRecmmend.json?time=1482061260&refer=ios&token=aaa0cbdaa13db67cf4395d44a5f75474" Param:nil CompleteBlock:^(id result)
//     {
//         NSLog(@"%@",result[@"data"]);
//         
//     }];
    //轮播图数据
    http://api.huomao.com/channels/getBanner.json?time=1482061680&refer=ios&token=e1bf6e77aaa9fc1f1ae605c11f3e3284

    //
    [self.collectionView registerClass:[FCLiveRoomCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FCRecommendHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
   
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return self.channelList.count + 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section > 1 ? 4:1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCLiveRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    cell.textLable.text = [NSString stringWithFormat:@"第%zd组第%zd行",indexPath.section,indexPath.item];
    
    return cell;
}


#pragma mark -- UICollectionViewDelegateFlowLayout
#define CycleScrollViewHeight 120
#define RecommendScrollViewHeight 64
#define insetMargin 10
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat mainWidth = self.collectionView.width;
    
    if (indexPath.section == 0)
    {//第一组轮播图的item大小
        return CGSizeMake(mainWidth, CycleScrollViewHeight);
    }
    else if (indexPath.section == 1)
    {//第二组
        return CGSizeMake(mainWidth, RecommendScrollViewHeight);
    }
    CGFloat roomItemWidth = (mainWidth - 3*insetMargin)*0.5;
    //显示每个房间的item的大小
    return CGSizeMake(roomItemWidth, roomItemWidth*0.7);
}
/*
 *设置行最小间距
 **/
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return section > 1?10:0;
}
/*
 *设置item最小间距
 **/
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return section > 1?10:0;
}
/*
 *设置内边距
 **/
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return section > 1?UIEdgeInsetsMake(10, 10, 10, 10):UIEdgeInsetsZero;
}
/*
 *设置组头尺寸
 **/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return section >1?CGSizeMake([UIScreen mainScreen].bounds.size.width, 44) : CGSizeZero;
}
/*
 *设置组头
 **/
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 1)
    {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            //此处设置组头中的内容
            UICollectionReusableView* reusableHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];
            
            return reusableHeader;
        }
    }
    return nil;
}
-(void)loadData
{
    __weak typeof(self)weakSelf = self;
    [FCChannelModel channelModelWithContentOfUrlString:@"http://api.huomao.com/channels/get_rec_games.json?time=1482061680&refer=ios&token=e1bf6e77aaa9fc1f1ae605c11f3e3284" callBackHandler:^(NSArray<FCChannelModel *> *callbackData)
     {
         weakSelf.channelList = callbackData;
         
         [weakSelf.collectionView reloadData];
     }];
    
    [[NetWorkTool sharedTool]requestDataWithType:AFNRequestTypeGet UrlString:@"http://api.huomao.com/channels/getRecmmend.json?time=1482061260&refer=ios&token=aaa0cbdaa13db67cf4395d44a5f75474" Param:nil CompleteBlock:^(id result)
     {
         if ([result[@"data"] isKindOfClass:[NSArray class]])
         {
             weakSelf.hotRecommendLiveList =    [FCChannelDataModel channelDataWithContentOfArr:result[@"data"]];
             [weakSelf.collectionView reloadData];
         }
         
     }];
}

@end
