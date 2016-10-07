//
//  ViewController.m
//  AddressPicker
//
//  Created by 顾泠轩 on 16/9/9.
//  Copyright © 2016年 cd. All rights reserved.
//

#import "ViewController.h"
#import "CDAddressPickerView.h"

#define SCW [[UIScreen mainScreen]bounds].size.width
#define SCH [[[UIScreen mainScreen]bounds].size.height

@interface ViewController ()

@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)CDAddressPickerView *addressPV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self createUI];

    
    
    
}

-(void)createUI
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCW /2  - 80 , 100, 160, 50);
    [btn setTitle:@"选取地址" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:btn];
    
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, SCW - 100, 30)];
    self.addressLabel.textColor = [UIColor blackColor];
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    self.addressLabel.text = @"地址";
    [self.view addSubview:self.addressLabel];
    
    self.addressPV = [[CDAddressPickerView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-240, [[UIScreen mainScreen]bounds].size.width, 240)];
    self.addressPV.btnFont = [UIFont systemFontOfSize:10];
//    self.addressPV.pickerFont = [UIFont fontWithName:@"Courier" size:8];
    [self.view addSubview:self.addressPV];
    
    
    
    
}

-(void)btnClick
{
    NSLog(@"点击选取地址按钮");
    [self.addressPV showAddressPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
