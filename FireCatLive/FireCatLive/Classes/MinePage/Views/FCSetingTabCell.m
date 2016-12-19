//
//  FCSetingTabCell.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCSetingTabCell.h"
#import "FCSettingModel.h"
@interface FCSetingTabCell ()
/**
 
 */
@property(nonatomic,weak)UIImageView* iconView;
/**
 
 */
@property(nonatomic,weak)UILabel* nameLable;
/**
 
 */
@property(nonatomic,weak)UIImageView* accessoryImgView;

/**
 
 */
@property(nonatomic,weak)UIImageView* bottonmLine;
@end

@implementation FCSetingTabCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])
    {
        [self setUPUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUPUI];
}

-(void)setUPUI
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.textLabel.font  =  [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor lightGrayColor];
    self.bottonmLine = ^
    {
        UIImageView* line = [[UIImageView alloc]init];
        
//        line.contentMode = UIViewContentModeScaleToFill;
        
        line.image = [UIImage imageNamed:@"line_dym_04"];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.offset(0).offset(1);
            
            make.left.equalTo(self.textLabel);
            
            make.height.offset(0.2*[UIScreen mainScreen].scale);
        }];
        return line;
    }();
}

-(void)setModel:(FCSettingModel *)model
{
    _model = model;
    
    self.imageView.image = [UIImage imageNamed:model.icon];
    
    self.textLabel.text = model.name;
}

@end
