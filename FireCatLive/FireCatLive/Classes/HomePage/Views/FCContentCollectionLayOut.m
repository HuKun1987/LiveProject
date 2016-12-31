//
//  FCContentCollectionLayOut.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/28.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCContentCollectionLayOut.h"

@implementation FCContentCollectionLayOut

-(void)prepareLayout
{
    [super prepareLayout];

    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    self.minimumLineSpacing = 0 ;
    self.minimumInteritemSpacing = 0;
    
    self.itemSize = self.collectionView.bounds.size;
    
}



@end
