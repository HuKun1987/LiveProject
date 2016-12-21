//
//  FCDetailChannelCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCDetailChannelCtr.h"
#import "FCDetailChannelFlowLayOut.h"
#import "FCChannelCell.h"
@interface FCDetailChannelCtr ()
/**
 
 */
@property(nonatomic,strong)NSArray* channelDetailList;

@end
static NSString* const channelsCellID = @"channelsCellID";
@implementation FCDetailChannelCtr

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    FCDetailChannelFlowLayOut* layOut = [[FCDetailChannelFlowLayOut alloc]init];
    
    if (self = [super initWithCollectionViewLayout:layOut])
    {
        self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.channelDetailList = [NSArray array];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FCChannelCell" bundle:nil]  forCellWithReuseIdentifier:channelsCellID];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.channelDetailList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:channelsCellID forIndexPath:indexPath];

    cell.channelData = self.channelDetailList[indexPath.item];
    
    return cell;
}
#pragma mark -- 获取gid去请求数据
-(void)setGid:(NSString *)gid
{
    _gid = gid;
    __weak typeof(self)weakSelf = self;
    
    [FCNetWorkDataFactory detailDataWithGid:gid CallBack:^(NSArray<FCChannelDataModel *> * channelDetailList)
    {
        weakSelf.channelDetailList = channelDetailList;
        
        
        [weakSelf.collectionView reloadData];
    }];
}
@end
