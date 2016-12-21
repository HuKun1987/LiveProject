//
//  FCCatagaryCollectionFlowLayOut.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCCatagaryCollectionFlowLayOut.h"

@implementation FCCatagaryCollectionFlowLayOut
-(void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.minimumLineSpacing = 10;
    
    self.minimumInteritemSpacing = 10;
    
    CGFloat width = (self.collectionView.width - 30)/3;
    
    self.itemSize = CGSizeMake(width, width*1.3);
    
    self.collectionView.showsVerticalScrollIndicator = NO;
}
@end
