//
//  FCMinePageViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCMinePageViewCtr.h"
#import "FCSettingViewCtr.h"

static NSString* firstSectionCellID = @"firstSectionCellID";
static NSString* secondSectionCellID = @"secondSectionCellID";
@interface FCMinePageViewCtr ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView* _bgImgView;
    UITableView* _settingTab;
}
/**
 
 */
@property(nonatomic,strong)NSArray* settingList;
@end
#define UserInfoHeaderHeight  64
#define BackGroundImgViewHeight 108
@implementation FCMinePageViewCtr

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self initaliztionSettingTab];
  
}
#pragma mark  -- dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }
    
    return self.settingList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:firstSectionCellID forIndexPath:indexPath];
        return cell;
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:secondSectionCellID forIndexPath:indexPath];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateBackGroundViewHeightWithOffsetY:scrollView.contentOffset.y];
}

-(void)updateBackGroundViewHeightWithOffsetY:(CGFloat) offsetY
{
   
    CGFloat bgImgViewHeight = BackGroundImgViewHeight - offsetY;

    if (bgImgViewHeight < 0)
    {
        return;
    }
    UIView* bgView = _settingTab.backgroundView.subviews.firstObject;
    
    [bgView mas_updateConstraints:^(MASConstraintMaker *make)
    {
        make.height.offset(bgImgViewHeight);
    }];
}
//初始化tableview
-(void)initaliztionSettingTab
{
    _settingTab = ^{
        UITableView* tab = [[UITableView alloc]init];
        
        [self.view addSubview:tab];
        
        [tab mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.edges.offset(0);
         }];
        //设置tab背景
        tab.backgroundView = ^
        {
            UIView* backgroundView = [[UIView alloc]init];
            UIImageView* imgView = [[UIImageView alloc]init];
            imgView.contentMode =  UIViewContentModeScaleAspectFill;
            imgView.image = [UIImage imageNamed:@"UserCenter_bg"];
            [backgroundView addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.leading.top.trailing.offset(0);
                 make.height.offset(BackGroundImgViewHeight);
             }];
            
            imgView.clipsToBounds = YES;
            
            return backgroundView;
        }();
        
        //设置header
        
        tab.tableHeaderView = ^{
            UIView* header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, UserInfoHeaderHeight)];
            header.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.3];
            return header;
        }();
        
        //设置属性；
        tab.delegate = self;
        tab.dataSource = self;
        tab.contentInset = UIEdgeInsetsMake(BackGroundImgViewHeight-UserInfoHeaderHeight+20, 0, 0, 0);
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:firstSectionCellID];
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:secondSectionCellID];
        return tab;
    }();
}

-(NSArray *)settingList
{
    if (!_settingList) {
        _settingList = [NSArray array];
    }
    return _settingList;
    
}
@end
