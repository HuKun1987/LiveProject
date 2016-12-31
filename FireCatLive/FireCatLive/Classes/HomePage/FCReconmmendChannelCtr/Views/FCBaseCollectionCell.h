//
//  FCBaseCollectionCell.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCChannelDataModel;
@interface FCBaseCollectionCell : UICollectionViewCell
/**
 
 */
@property(nonatomic,strong)FCChannelDataModel* channelData;


/**
 
 */
@property(nonatomic,strong)NSArray<FCChannelDataModel *> * hotBannerList;

@property(nonatomic,strong)NSArray<FCRecommendCycleBanner *> *cycleDataList;
@end
