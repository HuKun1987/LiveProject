//
//  FCReusableHeaderView.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCReusableHeaderView.h"
#import "FCChannelModel.h"
@interface FCReusableHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;


@end
@implementation FCReusableHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreCurrentCatagaryGameCheck:)];
    
    [self addGestureRecognizer:tap];
    
}
-(void)moreCurrentCatagaryGameCheck:(UITapGestureRecognizer*)tapGestyre
{
    FCReusableHeaderView* reusableView = (FCReusableHeaderView*)tapGestyre.view;
    
    if ([self.delegate respondsToSelector:@selector(toSeeMoreCurrentGameWithGid:)])
    {
        [self.delegate toSeeMoreCurrentGameWithGid:reusableView.channelModel.gid];
    }
    
    

}

-(void)setChannelModel:(FCChannelModel *)channelModel
{
    _channelModel = channelModel;
    
       [self.iconView sd_setImageWithURL:[NSURL URLWithString:channelModel.icon] placeholderImage:[UIImage imageNamed:@"recommand_dota"]];
    
    self.nameLable.text = channelModel.cname;
}



@end
