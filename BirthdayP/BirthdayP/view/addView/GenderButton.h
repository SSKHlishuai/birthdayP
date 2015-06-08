//
//  GenderButton.h
//  BirthdayP
//
//  Created by mc on 15/6/8.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenderButton : UIButton

@property(nonatomic)BOOL isTap;

-(instancetype)initWithFrame:(CGRect)frame withNameStr:(NSString*)namestr;


@end
