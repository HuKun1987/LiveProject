//
//  FCUserInfoView.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCUserInfor;
@interface FCUserInfoView : UIView
/**
 
 */
@property(nonatomic,assign)BOOL isLogin;
/**
 
 */
@property(nonatomic,strong)FCUserInfor *userInfo;

/**
 
 */
@property(copy,nonatomic)void(^tapUserInfoHandler)();
@end
