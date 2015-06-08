//
//  ListViewController.m
//  BirthdayP
//
//  Created by mc on 15/6/4.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "ListViewController.h"
#import "BirthCanlendarView.h"


@interface ListViewController ()
{
    BirthCanlendarView *bir;

}
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    bir = [[BirthCanlendarView alloc]initWithStartDay:startWeekDaySunday frame:FRAME(0, 64, kScreenWidth, kScreenHeight-100)];
    [self.view addSubview:bir];
    [self initializeNav];
    
    
    // Do any additional setup after loading the view.
}

-(void)initializeNav
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = FRAME(kScreenWidth-100, 20, 80, 44);
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:rightBtn];
}

-(void)rightBtnClick
{
    
    [bir intoEditing];
}



//-(void)calendar:(XZWCalendarView *)calendar didSelectDate:(NSDate*)date
//{
//    
//    
//    
//}
//-(void)handleLeftSwipeGesture//显示下一个月
//{
//    NSLog(@"下一个月");
//    [CKCalendar moveCalendarToNextMonth];
//}
//-(void)handleRightSwipeGesture
//{
//    NSLog(@"上一个月");
//    [CKCalendar moveCalendarToPreviousMonth];
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
