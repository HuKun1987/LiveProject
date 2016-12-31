//
//  FCHomePageViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCHomePageViewCtr.h"
#import "FCChannelLable.h"
#import "FCRecommendChannelsView.h"
#import "FCRecommendChannelInfo.h"
#import "FCContentCollectionLayOut.h"
#import "FCContentCollectionCell.h"
#define ChannelsViewHeight 44
#define maxCommonChannelCount 6
@interface FCHomePageViewCtr ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

/**
 存放推荐频道模型的数组
 */
@property(nonatomic,strong)NSMutableArray<FCRecommendChannelInfo*>* commaonChannels;

/**
 
 */
@property(nonatomic,weak)UICollectionView* contentCollection;
@end


static NSString* contentCellID = @"contentCellID";

@implementation FCHomePageViewCtr
{

    //推荐频道标签
    FCRecommendChannelsView* _recommendChannelsView;

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAllFCChannelsData];
    [self setUPUI];
}

-(void)setUPUI
{
    //取消自动布局
  self.automaticallyAdjustsScrollViewInsets = NO;
    
  [self intializationRecommendChannelsView];

  [self intializationContentCollection];

}

#pragma mark -- 频道导航
-(void)intializationRecommendChannelsView
{
    _recommendChannelsView = ^
    {
        FCRecommendChannelsView *reconmmendView = [[FCRecommendChannelsView alloc]init];
        
        [self.view addSubview:reconmmendView];
        
        [reconmmendView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.right.offset(0);
             make.top.offset(64);
             make.height.offset(ChannelsViewHeight);
         }];
        return reconmmendView;
    }();
    
    __weak typeof(self) weakSelf = self;

    _recommendChannelsView.scrollBackPage = ^(NSInteger currentPage)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:currentPage inSection:0];

        
        [weakSelf.contentCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone   animated:YES];
        
    };
}

#pragma mark -- 内容视图相关
-(void)intializationContentCollection
{
    FCContentCollectionLayOut* layOut = [[FCContentCollectionLayOut alloc]init];
    self.contentCollection = ^
    {
       UICollectionView* collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layOut];
        
        collection.dataSource = self;
        
        collection.delegate = self;
        
        collection.bounces = NO;
        collection.showsVerticalScrollIndicator = NO;
        [self.view addSubview:collection];
            
            return collection;
    }();
    [self.contentCollection mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.right.bottom.offset(0);
        make.top.equalTo(_recommendChannelsView.mas_bottom);
    }];
    //注册
    [self.contentCollection registerClass:[FCContentCollectionCell class] forCellWithReuseIdentifier:contentCellID];
}
#pragma mark  --数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.commaonChannels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCContentCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:contentCellID forIndexPath:indexPath];
    
    cell.recommendInfo = self.commaonChannels[indexPath.item];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0  blue:arc4random_uniform(255)/255.0  alpha:1];
    
    
    return cell;
}

#pragma mark -- 加载数据的方法

-(void)loadAllFCChannelsData
{
    __weak typeof(self)weakSelf = self;
    //获取加工后的常用频道标签
    [FCNetWorkDataFactory homeDefaultRecommendChannelWithCallBack:^(NSArray<FCRecommendChannelInfo *> *recommendChannelList)
     {
         [recommendChannelList enumerateObjectsUsingBlock:^(FCRecommendChannelInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
          {//默认加载的常用标签数量不能超过6个
              if (idx < maxCommonChannelCount - 1)
              {
                  [weakSelf.commaonChannels addObject:obj];
              }
          }];
         _recommendChannelsView.channeList = weakSelf.commaonChannels;
         [_contentCollection reloadData];
     }];
}

//懒加载常用频道标签，默认第一个是推荐，并且不能移除
-(NSMutableArray<FCRecommendChannelInfo *> *)commaonChannels
{
    if (!_commaonChannels)
    {
        FCRecommendChannelInfo* info = [[FCRecommendChannelInfo alloc]init];
        info.gid = 0;
        info.cname = @"推荐";
        _commaonChannels = [NSMutableArray arrayWithObject:info];
    }
    return _commaonChannels;
}


#pragma mark --内容视图的代理方法；
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging)
    {
        //1.计算滚动的偏移量
        CGFloat value =  scrollView.contentOffset.x / scrollView.bounds.size.width;

        //处理在最左边还往右边滚动
        if (value<0 || value > (_recommendChannelsView.channelLabels.count -1)) {
            return;
        }
        //2.计算当前滚动到了第几页
        int currentPage =  scrollView.contentOffset.x / scrollView.bounds.size.width;

        //3.获取右边的缩放比率
        CGFloat rightScale = value - currentPage;

        //4.左边的缩放比率
        CGFloat leftScale = 1 - rightScale;

        //5.左边的索引
        int leftIndex = currentPage;

        //6.右边的索引
        int rightIndex = leftIndex + 1;

        //7.取出左边的ChannelLabel
        FCChannelLable *leftChannelLabel =  _recommendChannelsView.channelLabels[leftIndex];

        leftChannelLabel.scale = leftScale;

        //8.取出右边的ChannelLabel
        if (rightIndex < _recommendChannelsView.channelLabels.count )
        {
            FCChannelLable *rightChannelLabel =  _recommendChannelsView.channelLabels[rightIndex];
            rightChannelLabel.scale = rightScale;
        }
    }
}


@end
