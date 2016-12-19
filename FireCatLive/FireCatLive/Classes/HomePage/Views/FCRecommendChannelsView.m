

#import "FCRecommendChannelsView.h"
#import "FCChannelLable.h"
@interface FCRecommendChannelsView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *channelsView;
@property (weak, nonatomic) IBOutlet UIButton *moreChannels;

/**
 
 */
@property(nonatomic,strong)FCChannelLable* selectedLable;
@end

@implementation FCRecommendChannelsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
        
     [self setUPUI];
    }
    return [[[NSBundle mainBundle]loadNibNamed:@"FCRecommendChannelsView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUPUI];
}

-(void)setUPUI
{
    self.channelsView.delegate = self;
  
    self.channelsView.bounces = YES;
  
    
}

- (IBAction)moreChannelsToSelected:(UIButton *)sender
{
    
}

-(NSArray *)channeList
{
    if (!_channeList) {
        _channeList = @[@"推荐",@"DoTa",@"英雄联盟",@"CS:GO",@"万智牌",@"猫秀场"];
    }
    return _channeList;
}
-(void)updateChannelsViewWithChannelList:(NSArray*)channelArr
{
    if (self.subviews.count!= 0)
    {
        for (UIView* view in self.channelsView.subviews)
        {
            [view removeFromSuperview];
        }
    }
    NSMutableArray* temp = [NSMutableArray arrayWithCapacity:1];
    CGFloat width = 0;
    for (NSString* channelName in channelArr)
    {
         FCChannelLable* lable = [FCChannelLable lableWithTextColor:[UIColor blackColor] TextFont:[UIFont systemFontOfSize:18]];
         lable.text = channelName;
        lable.textAlignment = NSTextAlignmentCenter;
        [lable sizeToFit];
        
        lable.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLableChannel:)];
        [lable addGestureRecognizer:tap];
        
        [self.channelsView addSubview:lable];
        width += lable.width;
        [temp addObject:lable];
    }
    
    [temp mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:0];
    
    
    
    [temp enumerateObjectsUsingBlock:^(FCChannelLable* lable, NSUInteger idx, BOOL * _Nonnull stop)
     {
         [lable mas_updateConstraints:^(MASConstraintMaker *make)
          {
              make.centerY.equalTo(self.channelsView);
              make.height.equalTo(self.channelsView).offset(10);
          }];
     }];
    self.channelsView.contentSize = CGSizeMake(width+30, 0);
}
/*
 *手势的响应事件
 **/
-(void)tapLableChannel:(UITapGestureRecognizer*)tapGesture
{
    self.selectedLable.isSelected = NO;
    
    FCChannelLable * lable = (FCChannelLable *)tapGesture.view;
    
    lable.isSelected = YES;
    self.selectedLable = lable;
}

-(void)layoutSubviews{
    [super layoutSubviews];
      [self updateChannelsViewWithChannelList:self.channeList];
}
@end
