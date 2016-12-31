//
//  FCCycleScrollCell.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/26.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCBaseCollectionCell.h"

@interface FCCycleScrollCell : FCBaseCollectionCell
/**
 
 */
@property(copy,nonatomic)void(^tapCycleImgCallBack)(NSInteger indx);
@end
