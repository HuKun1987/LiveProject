//
//  FCCatagryPageViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCCatagryPageViewCtr.h"
#import "FCCatagaryCollectionFlowLayOut.h"
#import "FCRecommendChannelInfo.h"
#import "FCCatagaryCollectionCell.h"
@interface FCCatagryPageViewCtr ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 
 */
@property(nonatomic,weak)UICollectionView* catagaryCollectionView;

/**
 
 */
@property(nonatomic,strong)NSArray<FCRecommendChannelInfo*>* allCatagaryChannelList;
@end

static NSString* reuseId = @"catagaryCollectionViewCellID";
@implementation FCCatagryPageViewCtr
//懒加载防错处理
-(NSArray<FCRecommendChannelInfo *> *)allCatagaryChannelList{
    if (!_allCatagaryChannelList)
    {
        _allCatagaryChannelList = [NSArray array];
    }
    return _allCatagaryChannelList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    //请求加工好的分类页面数据
    [FCNetWorkDataFactory catergaryDataWithCallBack:^(NSArray<FCRecommendChannelInfo *> * allCataryList)
    {
        weakSelf.allCatagaryChannelList = allCataryList;
        [weakSelf.catagaryCollectionView reloadData];
    }];
    //初始化主页面
    self.catagaryCollectionView = ^
    {
        FCCatagaryCollectionFlowLayOut* layOut = [[FCCatagaryCollectionFlowLayOut alloc]init];
        UICollectionView * collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layOut];
        collection.dataSource = self;
        collection.delegate = self;
        [self.view addSubview:collection];
        //添加约束
        [collection mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.edges.offset(0);
        }];
        return collection;
    }();
    
    [self.catagaryCollectionView registerNib:[UINib nibWithNibName:@"FCCatagaryCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseId];
}
#pragma mark 数据源代理方法：
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allCatagaryChannelList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCCatagaryCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    
    cell.info = self.allCatagaryChannelList[indexPath.item];

    return cell;
}
@end
