//
//  MasterViewController.m
//  SecondStoryboard
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property (assign,nonatomic) NSInteger currentIndex;

@end

@implementation MasterViewController

#pragma mark - 属性方法
- (NSMutableArray *)surveyDataArray
{
    if (_surveyDataArray == nil) {
        NSString *pathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/surveyData.XML"];
        NSData *data = [NSData dataWithContentsOfFile:pathStr];
        if (data) {
            NSError *error = NULL;
            _surveyDataArray = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:&error];
        }
        else
        {
            _surveyDataArray = [NSMutableArray arrayWithCapacity:1];
        }
    }
    
    return _surveyDataArray;
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    //clearsSelectionOnViewWillAppear：UITableViewController的属性，设为YES每次清空对cell的选择
    //isCollapsed:UISplitViewController的只读属性，是否将主视图控制器和俯视图控制器折叠在一起。
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

#pragma mark - 自定义方法
- (void)addSurveyDataArray:(NSDictionary *)dic
{
    [self.surveyDataArray addObject:dic];
    [self.tableView reloadData];
}
- (void)moveNext
{
    NSInteger index = self.surveyDataArray.count - 1;
    if (self.currentIndex < index) {
        NSDictionary *dic = self.surveyDataArray[++self.currentIndex];
        self.detailViewController.detailItem = dic;
    }
}
- (void)movePrevious
{
    if (self.currentIndex > 0) {
        NSDictionary *dic = self.surveyDataArray[--self.currentIndex];
        self.detailViewController.detailItem = dic;
    }
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.surveyDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.surveyDataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@%@",dic[@"firstName"],dic[@"lastName"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.surveyDataArray[indexPath.row];
    
    [self.detailViewController setDetailItem:dic];
    self.detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
    
    self.currentIndex = indexPath.row;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.surveyDataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

@end
