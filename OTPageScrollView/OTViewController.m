//
//  OTViewController.m
//  OTPageScrollView
//
//  Created by akron on 7/22/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import "OTViewController.h"
#import "OTPageScrollView.h"
#import "OTPageView.h"

@interface OTViewController ()<OTPageScrollViewDataSource,OTPageScrollViewDelegate>

@end

@implementation OTViewController{
    NSArray *_dataArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    OTPageView *PScrollView = [[OTPageView alloc] initWithFrame:CGRectMake(0, 60, 320, 200)];
    PScrollView.pageScrollView.dataSource = self;
    PScrollView.pageScrollView.delegate = self;
    PScrollView.pageScrollView.padding =50;
    PScrollView.pageScrollView.leftRightOffset = 10;
    PScrollView.pageScrollView.pageScrollViewType = OTPageScrollViewTypeCenter;
    PScrollView.pageScrollView.frame = CGRectMake(85, 60, 150, 100);
    PScrollView.backgroundColor = [UIColor redColor];
    _dataArray = [NSArray arrayWithObjects:
                          @"1 Google",
                          @"2 百　度",
                          @"3 网　易",
                          @"4 微 博",
                          @"5 优 酷 网",
                          @"6 淘 宝 网",
                          @"7 亚 马 逊",
                          @"8 MSN中文网",
                          @"9 猫　扑", @"10 123",nil];
     [PScrollView.pageScrollView reloadData];
     [self.view addSubview:PScrollView];
    UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake(158, 260, 4, 10)];
    arrowView.backgroundColor = [UIColor redColor];
    [self.view addSubview:arrowView];
}

- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return [_dataArray count];
}

- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, cell.frame.size.width-40, cell.frame.size.height - 40)];
    label.text = _dataArray[index];
    [cell addSubview:label];
    return cell;
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    return CGSizeMake(100, 100);
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    NSLog(@"你点击了第%ld个cell",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
