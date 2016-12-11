//
//  FCSettingViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/11.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCSettingViewCtr.h"
static NSString* firstSectionCellID = @"firstSectionCellID";
static NSString* secondSectionCellID = @"secondSectionCellID";
@interface FCSettingViewCtr ()<UITableViewDataSource,UITableViewDelegate>
/**
 
 */
@property(nonatomic,strong)NSArray* settingList;
@end

@implementation FCSettingViewCtr

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor groupTableViewBackgroundColor];

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


-(NSArray *)settingList
{
    if (!_settingList) {
        _settingList = [NSArray array];
    }
    return _settingList;
    
}

@end
