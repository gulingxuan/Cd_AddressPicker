//
//  AddressPickerView.h
//  AddressPicker
//
//  Created by 顾泠轩 on 16/9/9.
//  Copyright © 2016年 cd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDAddressPickerView : UIView

@property (nonatomic,assign)NSInteger componts;//有几个分区（几列）
@property (nonatomic,strong)UIFont *btnFont;//按钮字体

/*
 点击"确定"按钮回调
 param ： addStr 为选择器选择的地址
 */
@property (nonatomic,copy)void(^selectAddressBlock)(NSString * addStr);

//显示地址选择器
-(void)showAddressPicker;
//收起地址选择器
-(void)closeAddressPicker;



@end
