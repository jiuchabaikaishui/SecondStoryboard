//
//  InfoViewController.m
//  SecondStoryboard
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (weak,nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size;
    size.width = 420;
    size.height = 175;
    //用于任何容器布局子控制器，弹出窗口的原始大小来自视图控制器的此属性
    self.preferredContentSize = size;
    
    self.infoLabel.text = self.displayText;
}

@end
