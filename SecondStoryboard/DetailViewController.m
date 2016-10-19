//
//  DetailViewController.m
//  SecondStoryboard
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "InfoViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation DetailViewController

#pragma mark - 属性方法
- (void)setDetailItem:(NSDictionary *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        [self configureView];
    }
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    InfoViewController *nextCtr = (InfoViewController *)segue.destinationViewController;
//    if ([segue.identifier isEqualToString:@"InfoViewController"]) {
//        NSDate *date = [NSDate date];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy年MM月dd日"];
//        nextCtr.displayText = [formatter stringFromDate:date];
//    }
//}

#pragma mark - 点击触摸方法
- (IBAction)clearSurvey:(UIButton *)sender {
    self.firstNameTextField.text = @"";
    self.lastNameTextField.text = @"";
    self.addressTextField.text = @"";
    self.phoneNumberTextField.text = @"";
    self.ageTextField.text = @"";
}
- (IBAction)addSurvey:(UIButton *)sender {
    if ([self isBlankString:self.firstNameTextField.text]) {
        [self showAlertMsg:@"请输入姓氏！"];
        return;
    }
    if ([self isBlankString:self.lastNameTextField.text]) {
        [self showAlertMsg:@"请输入名字！"];
        return;
    }
    if ([self isBlankString:self.addressTextField.text]) {
        [self showAlertMsg:@"请输入地址！"];
        return;
    }
    if ([self isBlankString:self.phoneNumberTextField.text]) {
        [self showAlertMsg:@"请输入电话！"];
        return;
    }
    if ([self isBlankString:self.ageTextField.text]) {
        [self showAlertMsg:@"请输入年龄！"];
        return;
    }
    NSArray *keys = [NSArray arrayWithObjects:@"firstName", @"lastName", @"address", @"phone", @"age", nil];
    NSArray *objcts = [NSArray arrayWithObjects:self.firstNameTextField.text, self.lastNameTextField.text, self.addressTextField.text, self.phoneNumberTextField.text, [NSNumber numberWithInteger:[self.ageTextField.text integerValue]], nil];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objcts forKeys:keys];
    
    UINavigationController *navCtr = [self.splitViewController.viewControllers firstObject];
    MasterViewController *masterController = (MasterViewController *)navCtr.topViewController;
    [masterController addSurveyDataArray:dic];
    
    //清除数据
    [self clearSurvey:nil];
}
#define ios8            ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
- (IBAction)infoAction:(UIButton *)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    InfoViewController *infoViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    infoViewController.displayText = [formatter stringFromDate:date];
    
//    if (ios8) {
//        UIPopoverPresentationController *popCtr = [[UIPopoverPresentationController alloc] initWithPresentedViewController:infoViewController presentingViewController:self];
//    }
//    else
//    {
        UIPopoverController *popViewController = [[UIPopoverController alloc] initWithContentViewController:infoViewController];
        popViewController.popoverContentSize = CGSizeMake(200, 100); //弹出窗口大小，如果屏幕画不下，会挤小的。这个值默认是320x1100
        CGRect rect = CGRectMake(0, 0, 0, 0);
        [popViewController presentPopoverFromRect:rect inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }
}

#pragma mark - 自定义方法
- (void)configureView {
    if (self.detailItem) {
        self.firstNameTextField.text = self.detailItem[@"firstName"];
        self.lastNameTextField.text = self.detailItem[@"lastName"];
        self.addressTextField.text = self.detailItem[@"address"];
        self.phoneNumberTextField.text = self.detailItem[@"phone"];
        self.ageTextField.text = [self.detailItem[@"age"] stringValue];
    }
}
/**
 *  字符串判空
 *
 *  @param string 需要判断的字符串
 *
 *  @return 是否为空
 */
- (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
        return YES;
    
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    return NO;
}
/**
 *  显示提示框
 *
 *  @param message 提示的内容
 */
- (void)showAlertMsg:(NSString *)message
{
    if (![self isBlankString:message]) {
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alerController addAction:cancelAction];
        [self presentViewController:alerController animated:YES completion:nil];
    }
}

@end
