//
//  FCMinePageViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCMinePageViewCtr.h"
#import "FCSettingViewCtr.h"
#import "FCSetingTabCell.h"
#import "FCSettingModel.h"
#import "FCUserInfoView.h"
#import "FCCatagarySettingCell.h"
#import "FCLoginViewCtr.h"
#import "FCMineUserDetailCtr.h"
static NSString* firstSectionCellID = @"firstSectionCellID";
static NSString* secondSectionCellID = @"secondSectionCellID";


@interface FCMinePageViewCtr ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView* _bgImgView;
    UITableView* _settingTab;
}
/**
 
 */
@property(nonatomic,strong)NSArray<FCSettingModel*>* settingList;
/**
 
 */
@property(nonatomic,strong)NSArray<FCSettingModel*>* catagarySettingList;
@end


#define UserInfoHeaderHeight  64
#define BackGroundImgViewHeight 108



@implementation FCMinePageViewCtr

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    [self initaliztionSettingTab];
  
}
#pragma mark  -- dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 1;
    }
    return self.settingList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        FCCatagarySettingCell* cell = [tableView dequeueReusableCellWithIdentifier:firstSectionCellID forIndexPath:indexPath];
        /*
         *点击跳转
         **/
        cell.tapItemActionHandler = ^(NSString* pushVcName)
        {
            NSLog(@"%@",pushVcName);
        };
        
        cell.catagarySetting = self.catagarySettingList;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    FCSetingTabCell* cell = [tableView dequeueReusableCellWithIdentifier:secondSectionCellID forIndexPath:indexPath];
    cell.model = self.settingList[indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateBackGroundViewHeightWithOffsetY:scrollView.contentOffset.y];
}
//根据偏移量改变背景图片的高度
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 10 ;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1) {
        return  [tableView rowHeight];
    }
    return 84;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
    }
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
        tab.tableHeaderView = ^
        {
            FCUserInfoView* header = [[FCUserInfoView alloc]initWithFrame:CGRectMake(0, 0, 0, UserInfoHeaderHeight)];
            /*
             *点击去登录或打开详情
             **/
            __weak typeof(self)weakSelf = self;
            header.tapUserInfoHandler = ^
            {
                //没有登录时提示去登录
                if (!self.isLogin)
                {
                    FCLoginViewCtr* loginCtr = [[FCLoginViewCtr alloc]init];
    
                    [weakSelf.navigationController pushViewController:loginCtr animated:YES];
                }
                else
                {
                    FCMineUserDetailCtr* userDetail = [[FCMineUserDetailCtr alloc]init];
                    
                     [weakSelf.navigationController pushViewController:userDetail animated:YES];
                
                }

            };
            return header;
        }();
        //设置属性；
        tab.delegate = self;
        tab.dataSource = self;
        tab.contentInset = UIEdgeInsetsMake(BackGroundImgViewHeight-UserInfoHeaderHeight, 0, 0, 0);
        tab.contentOffset = CGPointMake(0, -UserInfoHeaderHeight);
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tab registerClass:[FCCatagarySettingCell class] forCellReuseIdentifier:firstSectionCellID];
        [tab registerClass:[FCSetingTabCell class] forCellReuseIdentifier:secondSectionCellID];
  
        return tab;
    }();
}
//懒加载数据
-(NSArray *)settingList
{
    if (!_settingList)
    {
        _settingList = [FCSettingModel settingWithContentOfUrl:[[NSBundle mainBundle]URLForResource:@"FCSetting" withExtension:@"plist"]];
    }
    return _settingList;
}
-(NSArray *)catagarySettingList
{
    if (!_catagarySettingList)
    {
        _catagarySettingList = [FCSettingModel settingWithContentOfUrl:[[NSBundle mainBundle]URLForResource:@"FCCatagarySetting" withExtension:@"plist"]];
    }
    return _catagarySettingList;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 self.navigationController.navigationBar.hidden = YES;
    /*
     *清楚选中状态；
     **/
    [_settingTab.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.selected = NO;
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
     self.navigationController.navigationBar.hidden = NO;

}
@end
