//
//  FCCatagarySettingItem.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCSettingModel;
@class FCCatagarySettingItem;
@protocol FCCatagarySettingItemDelegate <NSObject>

@optional
-(void)tapGesturePreformItem:(FCCatagarySettingItem*)item;

@end

@interface FCCatagarySettingItem : UIView
/**
 
 */
@property(nonatomic,strong)FCSettingModel* model;
/**
 
 */
@property(nonatomic,weak)id<FCCatagarySettingItemDelegate> delegate;

@end
