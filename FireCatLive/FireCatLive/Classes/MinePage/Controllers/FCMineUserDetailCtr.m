//
//  FCMineUserDetailCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/21.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCMineUserDetailCtr.h"

@interface FCMineUserDetailCtr ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 
 */
@property(nonatomic,weak)UIButton* userIconButton;
@end

@implementation FCMineUserDetailCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userIconButton =^{
        UIButton* btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(selectedNewIconForUser) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.width.height.offset(80);
            make.right.offset(-25);
            make.top.offset(89);
        }];
        
        return btn;
    }();
    
    
    
    // Do any additional setup after loading the view.
}

-(void)selectedNewIconForUser
{
    //打开相机
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    
    picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

//    NSLog(@"%@",info);
    UIImage* img = info[@"UIImagePickerControllerOriginalImage"];
    
 
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
           [self.userIconButton setBackgroundImage:img forState:UIControlStateNormal];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
