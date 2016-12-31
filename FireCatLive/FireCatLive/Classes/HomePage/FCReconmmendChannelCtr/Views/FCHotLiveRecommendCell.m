//
//  FCHotLiveRecommendCell.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/26.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCHotLiveRecommendCell.h"
#import "FCHotLiveColletionLayOut.h"
#import "FCChannelCell.h"
#import "FCChannelDataModel.h"
@interface FCHotLiveRecommendCell ()<UICollectionViewDataSource>
/**
 
 */
@property(nonatomic,weak)UICollectionView * mainColletion;

@end

static NSString* cellID = @"channelsCellID";
@implementation FCHotLiveRecommendCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPUI];
        self.hotBannerList = [NSArray array];
    }
    return self;
}
-(void)setUPUI
{
    self.mainColletion = ^
    {
        FCHotLiveColletionLayOut* layOut = [[FCHotLiveColletionLayOut alloc]init];
        
        UICollectionView* colletion = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layOut];
        
        colletion.backgroundColor = [UIColor whiteColor];
        colletion.dataSource = self;
        
        [colletion registerNib:[UINib nibWithNibName:@"FCChannelCell" bundle:nil]  forCellWithReuseIdentifier:cellID];
        [self addSubview:colletion];
        return colletion;
    }();
    
    [self.mainColletion mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.offset(0);
    }];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotBannerList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCChannelCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.channelData = self.hotBannerList[indexPath.item];
    
    return cell;
}

-(void)setHotBannerList:(NSArray<FCChannelDataModel *> *)hotBannerList
{
    [super setHotBannerList:hotBannerList];
    [self.mainColletion reloadData];
}

@end
