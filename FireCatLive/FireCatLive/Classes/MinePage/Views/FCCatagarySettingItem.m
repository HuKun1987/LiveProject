//
//  FCCatagarySettingItem.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCCatagarySettingItem.h"
#import "FCSettingModel.h"
@interface FCCatagarySettingItem ()

/**
 
 */
@property(nonatomic,weak)UIImageView * iconView;
/**
 
 */
@property(nonatomic,weak)UILabel* nameLable;
@end

@implementation FCCatagarySettingItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
       [self setUpUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpUI];
}
-(void)setUpUI
{
    self.iconView = ^
    {
        UIImageView* iconView = [[UIImageView alloc]init];
        iconView.image = [UIImage imageNamed:@"user_rec_big"];
        [iconView sizeToFit];
        [self addSubview:iconView];
     
        [iconView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.offset(0);
            make.centerX.offset(5);
        }];
        return iconView;
    }();
    
    self.nameLable = ^
    {
        UILabel* lable = [UILabel lableWithTextColor:[UIColor lightGrayColor] TextFont:[UIFont systemFontOfSize:15]];
        lable.text = @"历史记录";
        [self addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.iconView.mas_bottom).offset(10);
            make.centerX.equalTo(self.iconView);
        }];
        return lable;
    }();
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItm:)];
    [self addGestureRecognizer:tap];
    
}
-(void)setModel:(FCSettingModel *)model
{
    _model = model;
    self.iconView.image = [UIImage imageNamed:model.icon];
    self.nameLable.text = model.name;
}
-(void)tapItm:(FCCatagarySettingItem*)item
{
    if ([self.delegate respondsToSelector:@selector(tapGesturePreformItem:)])
    {
        [self.delegate tapGesturePreformItem:self];
    }
}
@end
