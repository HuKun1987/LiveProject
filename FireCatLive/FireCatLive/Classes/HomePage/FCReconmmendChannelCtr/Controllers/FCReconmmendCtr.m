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
#import "FCChannelCell.h"
#import "FCBaseCollectionCell.h"
#import "FCReusableHeaderView.h"
#import "FCRecommendChannelInfo.h"

#import "FCNetWorkDataFactory.h"

static NSString * const reuseIdentifier = @"Cell";

static NSString* const cycleScrollCellID = @"cycleScrollCellID";

static NSString* const hotRecommendCellID = @"hotRecommendCellID";

static NSString* const channelsCellID = @"channelsCellID";

static NSString* const channelSectionHeaderID = @"channelSectionHeaderID";
@interface FCReconmmendCtr ()<UICollectionViewDelegateFlowLayout,FCReusableHeaderViewDelegate>
/**
 存放推荐频道的推荐频道的数组
 */
@property(nonatomic,strong)NSArray<FCChannelModel*>* channelList;
/**
 存放热门推荐
 */
@property(nonatomic,strong)NSArray<FCChannelDataModel*>* hotRecommendLiveList;
/*
 *存放推荐频道标签模型的数组
 **/
@property(nonatomic,strong)NSArray<FCRecommendChannelInfo*>* channelInfoList;
@end

@implementation FCReconmmendCtr


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
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self loadData];
    [self registerCellAndHeader];
}

#pragma mark <UICollectionViewDataSource>
//返回组数 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.channelList.count + 2;
}
//返回行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section > 1 ? 4:1;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* ID = nil;
    
    if (indexPath.section > 1)
    {
        ID = channelsCellID;
    }else
    {
        ID = reuseIdentifier;
    }
 
    FCBaseCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    if (indexPath.section > 1)
    {
        cell.channelData = self.channelList[indexPath.section - 2].data[indexPath.item];
    }else
    {
       
        
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1];
    }
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
    CGFloat roomItemWidth = (mainWidth - 2.5*insetMargin)*0.5;
    //显示每个房间的item的大小
    return CGSizeMake(roomItemWidth, roomItemWidth*0.7);
}
/*
 *设置行最小间距
 **/
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return section > 1?5:0;
}
/*
 *设置item最小间距
 **/
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return section > 1?5:0;
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

    
    if (indexPath.section <= 1)
    {
        return [super collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    
    if (![kind isEqualToString:UICollectionElementKindSectionHeader] )
    {
        return [super collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    //此处设置组头中的内容
    FCReusableHeaderView* reusableHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:channelSectionHeaderID forIndexPath:indexPath];
    reusableHeader.delegate = self;
    reusableHeader.channelModel = self.channelList[indexPath.section -2];
    
    return reusableHeader;
}
#pragma mark  - FCReusableHeaderView代理方法
-(void)toSeeMoreCurrentGameWithGid:(NSString *)gid
{//跳转到详情页面

}
//注册建立collection所需子控件
-(void)registerCellAndHeader
{
    //注册推荐频道对应的item
    [self.collectionView registerNib:[UINib nibWithNibName:@"FCChannelCell" bundle:nil]  forCellWithReuseIdentifier:channelsCellID];
    //其他类型的item
    [self.collectionView registerClass:[FCLiveRoomCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //注册推荐频道的组头
    [self.collectionView registerNib:[UINib nibWithNibName:@"FCRecommendHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:channelSectionHeaderID];
}

-(void)loadData
{
    __weak typeof(self)weakSelf = self;
    [FCNetWorkDataFactory homeRecomendDataWithCallBackFirst:^(NSArray<FCRecommendCycleBanner *> *cycleDataList)
     {//轮播图数据
         
     } CallBackSecond:^(NSArray<FCHotLiveBanners *> *hotDataList)
     {//热门直播数据
         
     } CallBackThird:^(NSArray<FCChannelModel *> *recommendDataList)
     {//推荐频道数据
         weakSelf.channelList = recommendDataList;
         [weakSelf.collectionView reloadData];
     }];
}

@end
