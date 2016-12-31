//
//  FCReconmmendCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCReconmmendCtr.h"
#import "FCChannelModel.h"
#import "FCChannelDataModel.h"
#import "FCChannelCell.h"
#import "FCBaseCollectionCell.h"
#import "FCReusableHeaderView.h"
#import "FCRecommendChannelInfo.h"

#import "FCNetWorkDataFactory.h"
#import "FCCycleScrollCell.h"
#import "FCHotLiveRecommendCell.h"
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
/**
 
 */
@property(nonatomic,strong)NSArray<FCRecommendCycleBanner *> *cycleDataList;

/**
 
 */
@property(nonatomic,strong)NSArray<FCChannelDataModel*> *hotRecommendBanner;


@end
#define documentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]
@implementation FCReconmmendCtr


-(void)loadView{
    [super loadView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^
    {
        [self loadData];
    }];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    [self registerCellAndHeader];
}

#pragma mark <UICollectionViewDataSource>
#define itemCountInSection 4
//返回组数 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.channelList.count + 2;
}
//返回行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section > 1 ? itemCountInSection:1;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* ID = nil;
    
    if (indexPath.section > 1)
    {
        ID = channelsCellID;
    }else if (indexPath.section == 0)
    {
        ID = cycleScrollCellID;
    }
    else
    {
        ID = hotRecommendCellID;
    }
 
    FCBaseCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        cell.cycleDataList = self.cycleDataList;
    }
    else if (indexPath.section == 1)
    {
        cell.hotBannerList = self.hotRecommendBanner;
    }
    else
    {
         cell.channelData = self.channelList[indexPath.section - 2].data[indexPath.item];
    }
    
    return cell;

}
#pragma mark -- UICollectionViewDelegateFlowLayout
#define CycleScrollViewHeight 200
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
    CGFloat roomItemWidth = (mainWidth - 2*insetMargin)*0.5;
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
    return 0;
}
/*
 *设置内边距
 **/
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return section > 1?UIEdgeInsetsMake(0, 5, 0, 5):UIEdgeInsetsZero;
}
/*
 *设置组头尺寸
 **/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return section >0?CGSizeMake([UIScreen mainScreen].bounds.size.width, 44) : CGSizeZero;
}
/*
 *设置组头
 **/
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.section < 1)
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
    if (indexPath.section == 1)
    {
        FCChannelModel* model = [[FCChannelModel alloc]init];
        model.isAccessoryHidden = YES;
        model.cname = @"热门直播";
        model.icon = nil;
        reusableHeader.channelModel = model;
        
    }else
    {
      reusableHeader.channelModel = self.channelList[indexPath.section -2];
    }
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
    
    [self.collectionView registerClass:[FCHotLiveRecommendCell class] forCellWithReuseIdentifier:hotRecommendCellID];
    
    [self.collectionView registerClass:[FCCycleScrollCell class] forCellWithReuseIdentifier:cycleScrollCellID];
    //注册推荐频道的组头
    [self.collectionView registerNib:[UINib nibWithNibName:@"FCRecommendHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:channelSectionHeaderID];
}

-(void)loadData
{
    __weak typeof(self)weakSelf = self;
    
    [FCNetWorkDataFactory homeRecomendDataWithCallBackFirst:^(NSArray<FCRecommendCycleBanner *> *cycleDataList)
     {//轮播图数据
         weakSelf.cycleDataList = cycleDataList;
     
     }
     CallBackSecond:^(NSArray<FCChannelDataModel *> *hotDataList)
     {//热门直播数据
         weakSelf.hotRecommendBanner= hotDataList;

     }
    CallBackThird:^(NSArray<FCChannelModel *> *recommendDataList)
     {//推荐频道数据
         weakSelf.channelList = recommendDataList;
         [weakSelf.collectionView.mj_header endRefreshing];
         [weakSelf.collectionView reloadData];
     }];
}
#pragma mark --初始化方法
- (instancetype)init
{
    UICollectionViewFlowLayout* recommendLayOut = [[ UICollectionViewFlowLayout alloc]init];
    
    recommendLayOut.scrollDirection =UICollectionViewScrollDirectionVertical;
    
    if (self = [super initWithCollectionViewLayout:recommendLayOut])
    {
        self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.channelList = [NSArray array];
        self.cycleDataList= [NSArray array];
        self.hotRecommendLiveList = [NSArray array];;
        self.channelInfoList = [NSArray array];
    }
    return self;
}
@end
