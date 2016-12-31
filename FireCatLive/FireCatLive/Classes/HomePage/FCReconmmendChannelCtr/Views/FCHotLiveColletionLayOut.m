//
//  FCHotLiveColletionLayOut.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/26.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCHotLiveColletionLayOut.h"

@implementation FCHotLiveColletionLayOut
-(void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    CGFloat mainHeight = self.collectionView.height;
    
    self.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    CGFloat roomItemWidth = mainHeight/0.7;
    //显示每个房间的item的大小
    self.itemSize =  CGSizeMake(roomItemWidth, mainHeight);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    
}
@end
