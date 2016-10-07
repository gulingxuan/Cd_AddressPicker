//
//  AddressPickerView.m
//  AddressPicker
//
//  Created by 顾泠轩 on 16/9/9.
//  Copyright © 2016年 cd. All rights reserved.
//

#import "CDAddressPickerView.h"

#define AddressPV_BTN_Height 50
#define SCW [[UIScreen mainScreen]bounds].size.width
#define SCH [[[UIScreen mainScreen]bounds].size.height
#define BtnHeight 40

@interface CDAddressPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic, strong)UIPickerView *addressPV;
@property (nonatomic,strong) NSArray *addressArr; // 解析出来的最外层数组
@property (nonatomic,strong) NSArray *provinceArr; // 省
@property (nonatomic,strong) NSArray *countryArr; // 市
@property (nonatomic,strong) NSArray *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (nonatomic,copy) NSString *address;//选择的城市

@property (nonatomic,strong)NSMutableArray *btnArr;//确定、取消按钮数组

@end

@implementation CDAddressPickerView

-(NSMutableArray *)btnArr
{
    if (!_btnArr)
    {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (NSArray *)provinceArr
{
    if (_provinceArr == nil) {
        _provinceArr = [[NSArray alloc] init];
    }
    return _provinceArr;
}
-(NSArray *)countryArr
{
    if(_countryArr == nil)
    {
        _countryArr = [[NSArray alloc] init];
    }
    return _countryArr;
}

- (NSArray *)districtArr
{
    if (_districtArr == nil) {
        _districtArr = [[NSArray alloc] init];
    }
    return _districtArr;
}

-(NSArray *)addressArr
{
    if (_addressArr == nil) {
        _addressArr = [[NSArray alloc] init];
    }
    return _addressArr;
}

-(NSString *)address
{
    if (!_address)
    {
        _address = [NSString string];
    }
    return _address;
}

-(void)setComponts:(NSInteger)componts
{
    _componts = componts;
    [self.addressPV reloadAllComponents];
}

-(void)setBtnFont:(UIFont *)btnFont
{
    _btnFont = btnFont;
    for (UIButton *btn in self.btnArr)
    {
        btn.titleLabel.font = btnFont;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadFirstData];
        self.bgView = [[UIView alloc]initWithFrame: CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        self.addressPV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, AddressPV_BTN_Height, frame.size.width, frame.size.height - AddressPV_BTN_Height)];
        self.addressPV.dataSource = self;
        self.addressPV.delegate = self;
        self.componts = 3;
        [self.bgView addSubview:self.addressPV];
        [self createBtn];
        self.bgView.layer.borderWidth = 0.5;
        self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.bgView.layer.masksToBounds = YES;
    }
    return self;
}

-(void)createBtn
{
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW,BtnHeight)];
    btnView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, SCW, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [btnView addSubview:lineView];
    NSArray *arr = @[@"取消",@"确定"];
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * SCW / 2, 0, SCW / 2 , BtnHeight);
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置字体
//        btn.titleLabel.font = [UIFont fontWithName:FONT_NAME size:16];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        btn.tag = 100000 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 0.5;
        [btnView addSubview:btn];
        [self.btnArr addObject:btn];
    }
    [self.bgView addSubview:btnView];
    [self addSubview:self.bgView];
}

//点击取消及确定按钮
-(void)btnClick:(UIButton *)btn
{
    if (btn.tag%2)
    {
        NSMutableString *detailAddress = [[NSMutableString alloc] init];
        if (self.index1 < self.provinceArr.count) {
            NSString *firstAddress = self.provinceArr[self.index1];
            [detailAddress appendString:firstAddress];
        }
        if (self.index2 < self.countryArr.count) {
            NSString *secondAddress = self.countryArr[self.index2];
            [detailAddress appendString:secondAddress];
        }
        if (self.componts == 3 && self.index3 < self.districtArr.count) {
            NSString *thirfAddress = self.districtArr[self.index3];
            [detailAddress appendString:thirfAddress];
        }
        // 此界面显示
        self.address = detailAddress;
        NSLog(@"adress = %@",self.address);
        
        // 回调到上一个界面
        if (self.selectAddressBlock)
        {
            self.selectAddressBlock(self.address);
        }
        
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.alpha = 0;
    }];
}

//显示地址选择器
-(void)showAddressPicker
{
    self.alpha = 1;
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
    }];
    
}

//收起地址选择器
-(void)closeAddressPicker
{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.alpha = 0;
    }];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        
        //设置字体
//        pickerLabel.font = [UIFont fontWithName:FONT_NAME size:14];

        pickerLabel.font = [UIFont systemFontOfSize:14];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = UITextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)loadFirstData
{
    // 注意JSON后缀的东西和Plist不同，Plist可以直接通过contentOfFile抓取，Json要先打成字符串，然后用工具转换
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSLog(@"%@",path);
    NSString *jsonStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    self.addressArr = [self JSONObject:jsonStr];
    //        NSLog(@"josnStr = %@",self.addressArr);
    
    
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.addressArr)
    {
        NSString *name = dict.allKeys.firstObject;
        [firstName addObject:name];
    }
    // 第一层是省份 分解出整个省份数组
    self.provinceArr = firstName;
    NSLog(@"省份：%@",self.provinceArr);
    
}

// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData
{
    // 拿出省的数组
    [self loadFirstData];
    
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    // 根据省的index1，默认是0，拿出对应省下面的市
    for (NSDictionary *cityName in [self.addressArr[self.index1] allValues].firstObject) {
        
        NSString *name1 = cityName.allKeys.firstObject;
        [cityNameArr addObject:name1];
    }
    // 组装对应省下面的市
    self.countryArr = cityNameArr;
    //                             index1对应省的字典         市的数组 index2市的字典   对应市的数组
    // 这里的allValue是取出来的大数组，取第0个就是需要的内容
    self.districtArr = [[self.addressArr[self.index1] allValues][0][self.index2] allValues][0];
}

-(id)JSONObject:(NSString *)jsonStr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([jsonStr isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)jsonStr) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    } else if ([jsonStr isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)jsonStr options:kNilOptions error:nil];
    }
    
    return dic;
}

//addressPV 有多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.componts ? self.componts : 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr.count;
        case 1: return self.countryArr.count;
        case 2:return self.districtArr.count;
        default:break;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr[row];break;
        case 1: return self.countryArr[row];break;
        case 2:return self.districtArr[row];break;
        default:break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            self.index1 = row;
            self.index2 = 0;
            self.index3 = 0;
            //            [self calculateData];
            // 滚动的时候都要进行一次数组的刷新
            [self calculateFirstData];
            [pickerView reloadComponent:1];
            if (self.componts == 3)
            {
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
            [pickerView selectRow:0 inComponent:1 animated:YES];
            if (self.componts == 3)
            {
                //                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            //            [self calculateData];
            [self calculateFirstData];
            if (self.componts == 3)
            {
                [pickerView selectRow:0 inComponent:2 animated:YES];
                [pickerView reloadComponent:2];
            }
            
        }
            break;
        case 2:
            if (self.componts == 3)
            {
                self.index3 = row;
            }
            break;
        default:break;
    }
}

@end
