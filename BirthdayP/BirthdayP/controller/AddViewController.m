//
//  AddViewController.m
//  BirthdayP
//
//  Created by mc on 15/6/4.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AddViewController.h"
#import "AddNewView.h"


@interface AddViewController ()
{
    AddNewView *_addview;
}
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAddview];
    // Do any additional setup after loading the view.
}



#pragma mark - Initialize
-(void)initializeAddview
{
    _addview = [[AddNewView alloc]initWithFrame:FRAME(0, NavaStatusHeight, kScreenWidth, kScreenHeight-NavaStatusHeight-49)];
    _addview.backgroundColor = HexRGB(0xffffff);
    [self.view addSubview:_addview];
}

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
