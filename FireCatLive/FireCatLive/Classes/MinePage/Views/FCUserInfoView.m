//
//  FCUserInfoView.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCUserInfoView.h"

@interface FCUserInfoView ()

/**
 
 */
@property(nonatomic,weak)UIImageView* userIconView;
/**
 
 */
@property(nonatomic,weak)UILabel* userScreenName;
/**
 
 */
@property(nonatomic,weak)UILabel* catCoinLable;
/**
 
 */
@property(nonatomic,weak)UILabel* catPeasLable;
/**
 
 */
@property(nonatomic,weak)UIImageView* accessoryView;
@end

@implementation FCUserInfoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
      [self setUpUI];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpUI];
    
}
-(void)setUpUI
{/*
  *头像
  **/
    self.userIconView = ^
    {
        UIImageView* userIcon = [[UIImageView alloc]init];
        
        userIcon.image = [UIImage imageNamed:@"huomaotv_user_logo"];
        userIcon.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:userIcon];
        
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.offset(5);
            make.bottom.offset(-10);
            make.left.offset(20);
            make.width.offset(self.height-5);
        }];
        return userIcon;
    }();
    /*
     *昵称
     **/
    self.userScreenName = ^
    {
        UILabel * lable = [UILabel lableWithTextColor:[UIColor whiteColor] TextFont:[UIFont systemFontOfSize:19]];
        
        lable.text = @"未登录";
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerY.equalTo(self.userIconView);
            make.leading.equalTo(self.userIconView.mas_trailing).offset(10);
        }];
    
        return lable;
    }();
    
    /*
     *向右箭头
     **/
    self.accessoryView = ^
    {
        UIImageView* iconView = [[UIImageView alloc]init];
        
        iconView.image = [UIImage imageNamed:@"right_05"];
        [iconView sizeToFit];
        [self addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.right.offset(-20);
            make.centerY.offset(0);
        }];
        return iconView;
    }();
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2LoginOrVisitDetail)];
    [self addGestureRecognizer:tap];
}
-(void)tap2LoginOrVisitDetail
{
    self.tapUserInfoHandler();

}
@end
