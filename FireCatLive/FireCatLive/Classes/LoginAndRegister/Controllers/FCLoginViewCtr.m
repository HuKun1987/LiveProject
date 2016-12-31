//
//  FCLoginViewCtr.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/18.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCLoginViewCtr.h"
#import "FCLoginInputBtn.h"
#import "FCRightImgBtn.h"


@interface FCLoginViewCtr ()
/**
 
 */
@property(nonatomic,weak)FCLoginInputBtn * userAccoutInput;
/**
 
 */
@property(nonatomic,weak)FCLoginInputBtn * passWordInput;

/**
 
 */
@property(nonatomic,weak)UIButton* loginBtn;
@end

@implementation FCLoginViewCtr

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUI];    
}


-(void)loginBtnAction:(UIButton*)sender
{
    [self.userAccoutInput endEditting];
    [self.passWordInput endEditting];
    NSString* userAcount = self.userAccoutInput.fileText;
    NSString* password = self.passWordInput.fileText;
    
     NSString* msg = nil;
    
    if (!userAcount.length && password.length )
    {
        msg = @"用户名为空";
    }
   
    if (!password.length && userAcount.length)
    {
         msg = @"密码为空";
       
    }
    
    if (!password.length && !userAcount.length)
    {
      msg = @"用户名和密码不能为空";
   
    }
    
    if (!msg)
    {

        NSDictionary* para = @{@"username":userAcount,@"password":password};
        
        NSLog(@"%@",para);
        [FCNetWorkDataFactory requestToLoginWithUrlString:@"http://localhost/login.php" Para:para.copy FinishedCallBack:^(id responseResult)
        {
            if (responseResult != nil)
            {
                
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:KApploginState];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    else
    {
         [self promoteErroInfoWithAlertActionWithErroMessage:msg];
    }
}

//点击注册按钮
-(void)registerNewAccount
{


}

-(void)setUpUI
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.rightBarButtonItems = nil;
    self.title = @"登录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerNewAccount)];
    
    self.userAccoutInput = ^
    {
        FCLoginInputBtn* userAccount = [[FCLoginInputBtn alloc]init];
        [userAccount setShouldInputWithBgNorImg:@"top_gray_04" BgSelImg:@"top_red_04" ImgName:@"iconfont-zhanghao01" AndPlaceHoler:@"请输入用户名"];
        [self.view addSubview:userAccount];
        [userAccount mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.offset(84);
             make.left.offset(25);
             make.right.offset(-25);
             make.height.offset(54);
         }];
        return userAccount;
    }();
 
    self.passWordInput = ^
    {
        FCLoginInputBtn* password = [[FCLoginInputBtn alloc]init];
        [password setShouldInputWithBgNorImg:@"low_gray_08" BgSelImg:@"low_red_08" ImgName:@"iconfont-mima" AndPlaceHoler:@"请输入密码"];
        
        [self.view addSubview:password];
        
        [password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userAccoutInput.mas_bottom).offset(1);
            make.trailing.leading.equalTo(self.userAccoutInput);
            make.height.offset(54);
        }];
        return password;
    }();
    
    
    self.loginBtn = ^
    {
        UIButton* btn = [[UIButton alloc]init];
        [btn setBackgroundImage:[UIImage imageNamed:@"btnBackground"] forState:UIControlStateNormal];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        btn.tintColor = [UIColor whiteColor];
        
        [btn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.bottom.offset(-40);
            make.left.offset(40);
            make.right.offset(-40);
            make.height.offset(44);
        }];
        return btn;
    }();

    
}
//提示错误信息
-(void)promoteErroInfoWithAlertActionWithErroMessage:(NSString*)msg
{
    UIAlertController* alertCtr = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
    {
        [self.userAccoutInput becomeFirstResponder];
    }];
    
    [alertCtr addAction:action];
    
    [self presentViewController:alertCtr animated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    
    CGPoint loc = [touch locationInView:self.view];
    
    
     BOOL isInUser = [self.userAccoutInput.layer containsPoint:loc];

     BOOL isInPassword = [self.passWordInput.layer containsPoint:loc];
    
    if (!isInUser && !isInPassword)
    {
        [self.userAccoutInput endEditting];
        [self.passWordInput endEditting];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.userAccoutInput becomeFirstResponder];

}

@end
