//
//  BaseViewController.m
//  XYCMProject
//
//  Created by mc on 15/4/7.
//  Copyright (c) 2015年 信易云媒. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UILabel *middleLabel;
    UIButton *backButton;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;

    [self InitilizeNav];

    // Do any additional setup after loading the view.
}

-(void)InitilizeNav
{
    self.headView = [[UIImageView alloc]initWithFrame:FRAME(0, 0, kScreenWidth, 64)];
    _headView.backgroundColor = HexRGB(0x333333);
    _headView.userInteractionEnabled = YES;
    [self.view addSubview:_headView];
    middleLabel = [[UILabel alloc]initWithFrame:FRAME(kScreenWidth/4, 20, kScreenWidth/2, 44)];
    middleLabel.textAlignment = NSTextAlignmentCenter;
    middleLabel.font = Label_font(16.f);
    middleLabel.textColor = [UIColor whiteColor];
    [_headView addSubview:middleLabel];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = FRAME(0, 20, kScreenWidth/4, 44);
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backButton setImage:IMAGE_NAMED(@"cancel_normal") forState:UIControlStateNormal];
    [backButton setImage:IMAGE_NAMED(@"cancel_tap") forState:UIControlStateHighlighted];
    [_headView addSubview:backButton];
    
//    UIImageView *backimagev = [[UIImageView alloc]initWithFrame:FRAME(10, 11, 12.f,21.f )];
//    backimagev.contentMode = UIViewContentModeScaleAspectFit;
//    backimagev.image = IMAGE_NAMED(@"cancel_normal");
//    [backButton addSubview:backimagev];
    
}





-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)setMiddleTitle:(NSString *)middleTitle
{
    middleLabel.text = middleTitle;
}
-(void)hideBackbutton
{
    backButton.hidden = YES;
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
