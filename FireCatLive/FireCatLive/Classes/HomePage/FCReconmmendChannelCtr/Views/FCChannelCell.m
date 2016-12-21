//
//  FCChannelCell.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCChannelCell.h"
#import "FCChannelDataModel.h"
@interface FCChannelCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (weak, nonatomic) IBOutlet UILabel *channelNameLable;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;

@property (weak, nonatomic) IBOutlet UIButton *vistorCountbutton;


@end

@implementation FCChannelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];

    self.bgImgView.image = [UIImage imageNamed:@"huomao_default_Heng"];
    self.userNameLable.text = @"曲大帅比";
    self.channelNameLable.text = @"直播lol";
    [self.vistorCountbutton setTitle:@"1.8万" forState:UIControlStateNormal];
    
}
-(void)setChannelData:(FCChannelDataModel *)channelData
{
    NSString* urlString = channelData.image?channelData.image: channelData.img;
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:urlString ]placeholderImage:[UIImage imageNamed:@"huomao_default_Heng"]];
    self.userNameLable.text = channelData.username;
    self.channelNameLable.text = channelData.channel;
    [self.vistorCountbutton setTitle:channelData.views forState:UIControlStateNormal];

}
@end
