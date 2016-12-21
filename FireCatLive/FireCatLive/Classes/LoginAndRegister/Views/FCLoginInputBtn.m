//
//  FCLoginInputBtn.m
//  FireCatLive
//
//  Created by 胡坤 on 2016/12/20.
//  Copyright © 2016年 hukun. All rights reserved.
//

#import "FCLoginInputBtn.h"
#import "FCRightImgBtn.h"
@interface FCLoginInputBtn ()<UITextFieldDelegate>


@end

@implementation FCLoginInputBtn


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.btn = ^
        {
            FCRightImgBtn* btn = [[FCRightImgBtn alloc]init];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.edges.offset(0);
            }];
            return btn;
        }();
        
        self.inputTextField = ^
        {
            UITextField * textfield = [[UITextField alloc]init];
            textfield.borderStyle = UITextBorderStyleNone;
            textfield.delegate = self;
            [self addSubview:textfield];
            [textfield mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.leading.equalTo(self.btn.imageView.mas_trailing).offset(20);
                
                make.trailing.equalTo(self.btn).offset(-5);
                
                make.centerY.offset(0);
            }];
            return textfield;
        }();
        
    }
    return self;
}

-(void)setShouldInputWithBgNorImg:(NSString*)bgNorImgName BgSelImg:(NSString*)bgSelImgName ImgName:(NSString*) imgName AndPlaceHoler:(NSString*)placeHolder
{
    UIImage* norImg = [UIImage imageNamed:bgNorImgName];
    
    norImg = [norImg stretchableImageWithLeftCapWidth:norImg.size.width*0.5 topCapHeight:norImg.size.width*0.5];
    
    [self.btn setBackgroundImage:norImg forState:UIControlStateNormal];
    UIImage* selImg = [UIImage imageNamed:bgSelImgName];
    
    selImg = [selImg stretchableImageWithLeftCapWidth:selImg.size.width*0.5 topCapHeight:selImg.size.width*0.5];
        
    [self.btn setBackgroundImage:selImg forState:UIControlStateSelected];
    
    [self.btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@ (2)",imgName]);
    [self.btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@ (2)",imgName]] forState:UIControlStateSelected];
    
    self.inputTextField.placeholder = placeHolder;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.btn.selected = textField.isFirstResponder;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.btn.selected = textField.isFirstResponder;
}

-(void)btnClick:(FCRightImgBtn*)sender
{
    self.btn.selected = !sender.selected;
    
    if (self.btn.selected)
    {
        [self.inputTextField becomeFirstResponder];
    }
    else
    {
        [self.inputTextField endEditing:YES];
    }
}
@end
