//
//  MasterViewController.h
//  SecondStoryboard
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *surveyDataArray;
@property (strong, nonatomic) DetailViewController *detailViewController;
- (void)addSurveyDataArray:(NSDictionary *)dic;
- (void)moveNext;
- (void)movePrevious;


@end

