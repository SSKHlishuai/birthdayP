//
//  OneDateView.h
//  BirthdayP
//
//  Created by mc on 15/6/5.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneDateView : UIView


@property (nonatomic, strong)NSDate *date;
@property (nonatomic)BOOL   selected;

@property (nonatomic)BOOL   success;


@property (nonatomic,copy)NSString* dateStr;


-(void)setLabelAbtn;

-(void)changeToRed;

-(void)resetToP;


- (void)doudong;


@end
