//
//  FCContentCollectionCell.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/28.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCContentCollectionCell.h"
#import "FCDetailChannelCtr.h"
#import "FCReconmmendCtr.h"

@interface FCContentCollectionCell ()
{
    FCDetailChannelCtr* _recommendDetail;
}
@end

@implementation FCContentCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUPUI];
    }
    return self;
}

-(void)setUPUI
{
   
    
}
-(void)setRecommendInfo:(FCRecommendChannelInfo *)recommendInfo
{
     _recommendInfo = recommendInfo;
    if ([self.recommendInfo.cname isEqualToString:@"推荐"])
    {
        _recommendDetail = [[FCReconmmendCtr alloc]init];
        
        [self addSubview:_recommendDetail.collectionView];
        
        [_recommendDetail.collectionView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.edges.offset(0);
         }];
    }
    else
    {
        _recommendDetail = [[FCDetailChannelCtr alloc]init];
        
        [self addSubview:_recommendDetail.collectionView];
        
        [_recommendDetail.collectionView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.edges.offset(0);
         }];
        _recommendDetail.gid = self.recommendInfo.gid;
    }

}



@end
