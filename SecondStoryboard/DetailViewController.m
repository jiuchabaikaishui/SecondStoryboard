//
//  DetailViewController.m
//  SecondStoryboard
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "DetailViewController.h"

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

#pragma mark - 点击触摸方法
- (IBAction)clearSurvey:(UIButton *)sender {
    
}
- (IBAction)addSurvey:(UIButton *)sender {
    
}

#pragma mark - 自定义方法
- (void)configureView {
    if (self.detailItem) {
        
    }
}

@end
