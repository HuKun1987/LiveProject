//
//  FCCatagaryCollectionCell.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/19.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCCatagaryCollectionCell.h"
#import "FCRecommendChannelInfo.h"
@interface FCCatagaryCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *cnameLable;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;


@end

@implementation FCCatagaryCollectionCell
-(void)awakeFromNib{
    [super awakeFromNib];

}

-(void)setInfo:(FCRecommendChannelInfo *)info
{
    _info  = info;

    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:info.images] placeholderImage:[UIImage imageNamed:@"huomao_default_Ver"]];
    self.cnameLable.text = info.cname;

}

@end
