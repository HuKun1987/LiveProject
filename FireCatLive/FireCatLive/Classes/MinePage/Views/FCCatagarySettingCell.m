//
//  FCCatagarySettingCell.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCCatagarySettingCell.h"
#import "FCCatagarySettingItem.h"
#import "FCSettingModel.h"
@interface FCCatagarySettingCell ()<FCCatagarySettingItemDelegate>
/**
 
 */
@property(nonatomic,weak)FCCatagarySettingItem* myRead;
/**
 
 */
@property(nonatomic,weak)FCCatagarySettingItem* myHistory;
/**
 
 */
@property(nonatomic,weak)FCCatagarySettingItem* recharge;

@end

@implementation FCCatagarySettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
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
    
    self.myRead = ^
    {
        FCCatagarySettingItem* item = [[FCCatagarySettingItem alloc]init];
        item.delegate = self;
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.offset(20);
            make.top.offset(20);
            make.bottom.offset(0);
        }];
        return item;
    }();
    UIView* firstLine = [self creatLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myRead.mas_right).offset(20);
        make.width.offset(0.2*[UIScreen mainScreen].scale);
        make.height.offset(self.height-20);
        make.centerY.offset(0);
    }];
    
    self.myHistory  = ^
    {
        FCCatagarySettingItem* item = [[FCCatagarySettingItem alloc]init];
        item.delegate = self;
        [self addSubview:item];
        return item;
    }();
    
    [self.myHistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLine.mas_right).offset(20);
        make.top.width.height.equalTo(self.myRead);
    }];
    
    UIView* secondLine = [self creatLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myHistory.mas_right).offset(20);
        make.width.offset(0.2*[UIScreen mainScreen].scale);
        make.height.offset(self.height-20);
        make.centerY.offset(0);
    }];
    self.recharge = ^
    {
        FCCatagarySettingItem* item = [[FCCatagarySettingItem alloc]init];
        item.delegate = self;
        [self addSubview:item];
        return item;
    }();
    [self.recharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondLine.mas_right).offset(20);
        make.top.width.height.equalTo(self.myRead);
        make.right.equalTo(self).offset(-20);
    }];
}
-(UIView*)creatLine
{
    UIView* lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    return lineView;
}

-(void)setCatagarySetting:(NSArray *)catagarySetting{
    _catagarySetting = catagarySetting;
   
    NSInteger index = 0;
    for (UIView* obj in self.subviews)
    {
        if ([obj isKindOfClass:[FCCatagarySettingItem class]])
        {
            FCCatagarySettingItem* item = (FCCatagarySettingItem*)obj;
            item.model = catagarySetting[index%3];
            
            index ++;
        };
    }
}

-(void)tapGesturePreformItem:(FCCatagarySettingItem *)item
{
//    NSLog(@"%@",item.model.name);
    self.tapItemActionHandler(item.model.pushVCName);
}


@end
