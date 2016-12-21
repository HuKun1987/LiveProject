//
//  FCLoginInputBtn.h
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCRightImgBtn;

@interface FCLoginInputBtn : UIView

/**
 
 */
@property(nonatomic,weak)FCRightImgBtn* btn;
/**
 
 */
@property(nonatomic,weak)UITextField* inputTextField;

-(void)setShouldInputWithBgNorImg:(NSString*)bgNorImgName BgSelImg:(NSString*)bgSelImgName ImgName:(NSString*) imgName AndPlaceHoler:(NSString*)placeHolder;
@end
