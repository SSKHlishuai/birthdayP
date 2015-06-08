//
//  BirthCanlendarDateView.h
//  BirthdayP
//
//  Created by mc on 15/6/5.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BirthCanlendarDateViewDelegate <NSObject>

-(void)changeCurrentSelete:(NSString*)currentId;

-(void)moveEndCurrnetSelect;

-(void)deleteCurrentSelete:(NSString*)currentId;

@end


@interface BirthCanlendarDateView : UIView


@property (nonatomic, strong)NSCalendar *calendar;
@property (nonatomic, strong)NSDate *monthShowing;

@property (nonatomic,assign)id <BirthCanlendarDateViewDelegate>myDelegate;


-(void)intoEditing;

@end
