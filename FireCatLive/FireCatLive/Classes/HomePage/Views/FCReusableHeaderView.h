//
//  FCReusableHeaderView.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCChannelModel;
@class FCReusableHeaderView;
@protocol FCReusableHeaderViewDelegate <NSObject>

@optional
-(void)toSeeMoreCurrentGameWithGid:(NSString*)gid;

@end

@interface FCReusableHeaderView : UICollectionReusableView

/**
 
 */
@property(nonatomic,strong)FCChannelModel* channelModel;
/**
 
 */
@property(nonatomic,weak)id<FCReusableHeaderViewDelegate> delegate;
@end
