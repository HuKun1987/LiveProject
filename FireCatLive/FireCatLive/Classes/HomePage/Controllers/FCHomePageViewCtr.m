//
//  FCHomePageViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCHomePageViewCtr.h"
#import "FCRecommendChannelsView.h"
#import "FCDetailChannelCtr.h"
#import "FCReconmmendCtr.h"
#import "FCRecommendChannelInfo.h"
#import "FCChannelLable.h"
#define ChannelsViewHeight 44
#define maxCommonChannelCount 6
@interface FCHomePageViewCtr ()<UIScrollViewDelegate>
{
    //推荐频道标签
    FCRecommendChannelsView* _recommendChannelsView;
    /*
     *展示
     **/
//    UIScrollView* _contentScrollView;
}

/**
 
 */
@property(nonatomic,strong)NSMutableArray<FCRecommendChannelInfo*>* commaonChannels;

/**
 
 */
@property(nonatomic,weak) UIScrollView* contentScrollView ;

@end

@implementation FCHomePageViewCtr
//懒加载常用频道标签，默认第一个是推荐，并且不能移除
-(NSMutableArray<FCRecommendChannelInfo *> *)commaonChannels
{
    if (!_commaonChannels)
    {
        FCRecommendChannelInfo* info = [[FCRecommendChannelInfo alloc]init];
        info.gid = 0;
        info.cname = @"推荐";
        _commaonChannels = [NSMutableArray arrayWithObject:info];
    }
    return _commaonChannels;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //取消自动布局
     self.automaticallyAdjustsScrollViewInsets = NO;
    __weak typeof(self)weakSelf = self;
    //获取加工后的常用频道标签
    [FCNetWorkDataFactory homeDefaultRecommendChannelWithCallBack:^(NSArray<FCRecommendChannelInfo *> *recommendChannelList)
    {
        [recommendChannelList enumerateObjectsUsingBlock:^(FCRecommendChannelInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {//默认加载的常用标签数量不能超过6个
            if (idx < maxCommonChannelCount - 1)
            {
               [weakSelf.commaonChannels addObject:obj];
            }
        }];
        _recommendChannelsView.channeList = weakSelf.commaonChannels;
        [self updateContentScrollViewWithCommanChannels:weakSelf.commaonChannels];
    }];
   
    [self intializationRecommendChannelsView];
    [self intializationContentScrollView];
}
-(void)intializationRecommendChannelsView
{
    _recommendChannelsView = ^
    {
        FCRecommendChannelsView *reconmmendView = [[FCRecommendChannelsView alloc]init];
        [self.view addSubview:reconmmendView];
        
        [reconmmendView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.right.offset(0);
            make.top.offset(64);
            make.height.offset(ChannelsViewHeight);
        }];
        return reconmmendView;
    }();
    
    __weak typeof(self) weakSelf = self;
    _recommendChannelsView.scrollBackPage = ^(NSInteger currentPage)
    {
        [weakSelf.contentScrollView setContentOffset:CGPointMake(currentPage* weakSelf.contentScrollView.width, 0) animated:YES];
        
    };
}
//初始化内容视图
-(void)intializationContentScrollView
{
    self.contentScrollView = ^
    {
        UIScrollView* scroll = [[UIScrollView alloc]init];
        
        scroll.backgroundColor = [UIColor groupTableViewBackgroundColor];
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scroll];
        
        scroll.delegate = self;
        [scroll mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.right.offset(0);
            make.top.equalTo(_recommendChannelsView.mas_bottom);
            make.bottom.offset(-49);
        }];
        return scroll;
    }();
    
    [self addContentViews];
}
#pragma mark --内容视图的代理方法；
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging)
    {
        //1.计算滚动的偏移量
        CGFloat value =  scrollView.contentOffset.x / scrollView.bounds.size.width;
        
        //处理在最左边还往右边滚动
        if (value<0 || value > (_recommendChannelsView.channelLabels.count -1)) {
            return;
        }
        //2.计算当前滚动到了第几页
        int currentPage =  scrollView.contentOffset.x / scrollView.bounds.size.width;
        
        //3.获取右边的缩放比率
        CGFloat rightScale = value - currentPage;
        
        //4.左边的缩放比率
        CGFloat leftScale = 1 - rightScale;
        
        //5.左边的索引
        int leftIndex = currentPage;
        
        //6.右边的索引
        int rightIndex = leftIndex + 1;
        
        //7.取出左边的ChannelLabel
        FCChannelLable *leftChannelLabel =  _recommendChannelsView.channelLabels[leftIndex];
        
        leftChannelLabel.scale = leftScale;
        
        //8.取出右边的ChannelLabel
        if (rightIndex < _recommendChannelsView.channelLabels.count )
        {
            FCChannelLable *rightChannelLabel =  _recommendChannelsView.channelLabels[rightIndex];
            rightChannelLabel.scale = rightScale;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    _recommendChannelsView.selectedLable = _recommendChannelsView.channelLabels[currentPage];
    
    [_recommendChannelsView updateLablesWhenSelectedNew];
}
//添加内容视图
-(void)addContentViews
{
    [self updateContentScrollViewWithCommanChannels:self.commaonChannels];
}
//通过常用频道标签数据更新内容视图的布局
-(void)updateContentScrollViewWithCommanChannels:(NSMutableArray<FCRecommendChannelInfo*>*) commaonChannels
{
    //推荐
    FCReconmmendCtr* recommendCtr = [[FCReconmmendCtr alloc]init];
    
    [self.contentScrollView addSubview:recommendCtr.view];
    
    [self addChildViewController:recommendCtr];
    
    [recommendCtr didMoveToParentViewController:self];
    
    if (commaonChannels.count > 1)
    {
        NSMutableArray* ctrArr = [NSMutableArray arrayWithCapacity:1];
        
        for (NSInteger i = 0; i <commaonChannels.count; i++)
        {
            FCRecommendChannelInfo* infor = commaonChannels[i];
            
                if ( i == 0)
                {
                    [ctrArr addObject:recommendCtr.view];
                }
                else
                {
                    //其他
                    FCDetailChannelCtr* detailCtr = [[FCDetailChannelCtr alloc]init];
                    
                    detailCtr.gid = infor.gid;
                    
                    [self.contentScrollView addSubview:detailCtr.view];
                    
                    [self addChildViewController:detailCtr];
                    
                    [detailCtr didMoveToParentViewController:self];
                    
                    [ctrArr addObject:detailCtr.view];
                }
        }
        
        [ctrArr.copy mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        
        [ctrArr enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL * _Nonnull stop)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.top.bottom.offset(0);
                 make.width.height.equalTo(self.contentScrollView);
             }];
        }];
    }
    else
    {
        [recommendCtr.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.width.height.equalTo(self.contentScrollView);
        }];
    }
}

@end
