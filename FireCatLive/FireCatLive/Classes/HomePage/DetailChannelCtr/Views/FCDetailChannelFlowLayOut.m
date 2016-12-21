//
//  FCDetailChannelFlowLayOut.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCDetailChannelFlowLayOut.h"

@implementation FCDetailChannelFlowLayOut
-(void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    CGFloat mainWidth = self.collectionView.width;
    
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CGFloat roomItemWidth = (mainWidth - 20)*0.5;
    //显示每个房间的item的大小
     self.itemSize =  CGSizeMake(roomItemWidth, roomItemWidth*0.7);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;

}
@end
