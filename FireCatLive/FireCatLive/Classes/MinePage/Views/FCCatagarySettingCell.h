//
//  FCCatagarySettingCell.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCSettingModel;
@interface FCCatagarySettingCell : UITableViewCell
/**
 
 */
@property(nonatomic,strong)NSArray* catagarySetting;
/**
 
 */
@property(copy,nonatomic)void(^tapItemActionHandler)(NSString* pushVCName);
@end
