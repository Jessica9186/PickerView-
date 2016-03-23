//
//  ViewController.m
//  pick
//
//  Created by zxy on 15/10/16.
//  Copyright © 2015年 ZCHding. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
@property (nonatomic,weak) UIPickerView *pickView;
@property (nonatomic,weak) UITextField *areaTextField;

@property (strong, nonatomic) NSArray *areaArr;
@property (strong, nonatomic) NSMutableArray *teamArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(leftClick:)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *button = [NSArray arrayWithObjects:space,right,nil];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    toolbar.barStyle = UIBarStyleDefault;
    
    [toolbar setItems:button animated:YES];
    
    UITextField *text = [[UITextField alloc] init];
    text.frame  = CGRectMake(10, 100, 100, 20);
    [self.view addSubview:text];
    text.backgroundColor = [UIColor grayColor];
    self.areaTextField = text;
    
    UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216 - 44, [UIScreen mainScreen].bounds.size.width, 216)];
//    [self.view addSubview:pickView];
    pickView.showsSelectionIndicator = YES;
    pickView.delegate = self;
    pickView.dataSource = self;
    self.pickView = pickView;
//    [pickView addSubview:toolbar];
    
    self.areaTextField.inputAccessoryView = toolbar;
    
    
    
    text.inputView = self.pickView;
    
    
    self.areaArr = @[@"工商银行",@"中国银行",@"建设银行",@"农业银行",@"其它"];
    self.teamArr = [NSMutableArray array];
    [self.teamArr addObject:@[@""]];
    [self.teamArr addObject:@[@""]];
    [self.teamArr addObject:@[@""]];
    [self.teamArr addObject:@[@""]];
    [self.teamArr addObject:@[@"花旗银行",@"交通银行",@"浦发银行",@"信用社"]];
    
}
- (void)leftClick:(UIBarButtonItem *)sender
{
//    NSLog(@"1234");
//    [self.pickView removeFromSuperview];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (NSInteger )numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.areaArr count];
    }else{
        NSInteger countRow = [pickerView selectedRowInComponent:0];
        return [self.teamArr[countRow] count];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.areaArr[row];
    }else{
        NSInteger countRow = [pickerView selectedRowInComponent:0];
        return self.teamArr[countRow][row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:1];
    NSInteger areaRow = [pickerView selectedRowInComponent:0];
    NSInteger teamRow = [pickerView selectedRowInComponent:1];
    NSString *str = [NSString stringWithFormat:@"%@%@",self.areaArr[areaRow],self.teamArr[areaRow][teamRow]];
    
    if ([self.areaArr[areaRow] containsString:@"其它"]) {
        str = self.teamArr[areaRow][teamRow];
    }else{
        str = self.areaArr[areaRow];
    }
    [self.areaTextField setText:str];
//    [self.view endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
}
@end
