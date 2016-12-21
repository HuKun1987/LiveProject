

#import "FCRecommendChannelsView.h"
#import "FCChannelLable.h"
@interface FCRecommendChannelsView ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *moreChannels;
@property (weak, nonatomic) IBOutlet UIView *bottomRedLine;


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
    
    self.channeList = [NSArray array];
}

- (IBAction)moreChannelsToSelected:(UIButton *)sender
{
    
}

-(void)setChanneList:(NSArray<FCRecommendChannelInfo *> *)channeList
{
    _channeList = channeList;
    
    [self updateChannelsViewWithChannelList:channeList];
    
}
//当获取当新的模型数组时更新
-(void)updateChannelsViewWithChannelList:(NSArray<FCRecommendChannelInfo *>*)channelArr
{
    if (self.subviews.count!= 0)
    {
        for (FCChannelLable* lable in self.channelLabels)
        {
            [lable removeFromSuperview];
        }
    }
    
    if (channelArr.count > 1)
    {
        CGFloat width = 0;
        for (FCRecommendChannelInfo * channel in channelArr)
        {
            FCChannelLable* lable = [[FCChannelLable alloc]init];
            lable.channel = channel;
        
            //lable的自带手势响应回调
            __weak typeof(self)weakSelf = self;
            lable.tapLableCallBack = ^(UITapGestureRecognizer* tapGesture)
            {
                [weakSelf performMethodWithGesture:tapGesture];
            };
            [self.channelsView addSubview:lable];
            width += lable.width;
            [self.channelLabels addObject:lable];
        }
        
        [self.channelLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:0];
    
        [self.channelLabels enumerateObjectsUsingBlock:^(FCChannelLable* lable, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [lable mas_updateConstraints:^(MASConstraintMaker *make)
              {
                  make.centerY.equalTo(self.channelsView);
                  make.height.equalTo(self.channelsView).offset(10);
              }];
         }];
        self.channelsView.contentSize = CGSizeMake(width+30, 0);
    }else
    {
        if (channelArr.count == 0)
        {
            return;
        }
        FCRecommendChannelInfo * channel = channelArr.firstObject;
        FCChannelLable* lable = [[FCChannelLable alloc]init];
        lable.channel = channel;
        //lable的自带手势响应回调
        __weak typeof(self)weakSelf = self;
        lable.tapLableCallBack = ^(UITapGestureRecognizer* tapGesture)
        {
            [weakSelf performMethodWithGesture:tapGesture];
        };
        
        [self.channelsView addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.offset(0);
            make.centerX.offset(self.channelsView.width*0.5);
        }];
    }
    //设置默认选中
    FCChannelLable* lable =  self.channelLabels.firstObject;
    self.selectedLable = lable;
    //设置底部红线的默认起始位置
    self.bottomRedLine.transform = CGAffineTransformMakeTranslation(12, 0);
    self.selectedLable.scale = 1.0;
    
}
-(void)performMethodWithGesture:(UITapGestureRecognizer*)tapGesture
{
    //获取到当前lable
    FCChannelLable * lable = (FCChannelLable *)tapGesture.view;
    
    if (lable  == self.selectedLable)
    {
        return;
    }
    //设置为选中
    self.selectedLable = lable;
    
    [self.channelLabels enumerateObjectsUsingBlock:^(FCChannelLable* subLable, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (self.selectedLable  == subLable)
         {
             self.scrollBackPage(idx);
         }
     }];
    
    [self updateLablesWhenSelectedNew];

}
/*
 *根据选择不同的lable更新所有lable的状态和大小的方法
 **/
-(void)updateLablesWhenSelectedNew
{
    //1.居中
    //计算应该滚动多少
    CGFloat needScrollOffsetX = self.selectedLable.center.x - self.channelsView.width * 0.5;
    //最大允许滚动的距离
    CGFloat maxAllowScrollOffsetX = self.channelsView.contentSize.width - self.channelsView.width;
    
    if (needScrollOffsetX<0)
    {
        needScrollOffsetX = 0;
    }
    
    if (needScrollOffsetX>maxAllowScrollOffsetX)
    {
        needScrollOffsetX = maxAllowScrollOffsetX;
    }
    
    [self.channelsView setContentOffset:CGPointMake(needScrollOffsetX, 0) animated:YES];
    
    //2.重置所有的ChannelLabel的选中状态
    for (FCChannelLable *channelLabel in self.channelLabels)
    {
        if (channelLabel == self.selectedLable)
        {
            channelLabel.scale = 1.0;
            
        }else
        {
            channelLabel.scale = 0.0;
        }
    }
    
         [self transfomBottomLineWhenSelectedLableWithoffsetX:CGPointMake(needScrollOffsetX, 0)];
}

-(void)transfomBottomLineWhenSelectedLableWithoffsetX:(CGPoint)offset
{
    CGRect frame = [self convertRect:self.selectedLable.frame toView:self];
    
    self.bottomRedLine.transform = CGAffineTransformMakeTranslation(frame.origin.x - offset.x, 0);
}

- (NSMutableArray *)channelLabels
{
    if (_channelLabels==nil)
    {
        _channelLabels = [NSMutableArray array];
    }
    return _channelLabels;
}
@end
