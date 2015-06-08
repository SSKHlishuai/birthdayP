//
//  BaseViewController.h
//  XYCMProject
//
//  Created by mc on 15/4/7.
//  Copyright (c) 2015年 信易云媒. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController
{
    
}

@property (nonatomic,strong)UIView  *headView;
@property (nonatomic,strong)NSString    *middleTitle;



-(void)hideBackbutton;
-(void)backClick;





@end
