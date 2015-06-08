//
//  XZWCalendarView.h
//  5-5-DEMO
//
//  Created by 学之网研发 on 14-5-12.
//  Copyright (c) 2014年 学之网研发. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZWCalendarDelegate;

typedef enum _startWeekDay{
    startWeekDaySunday = 0,
    startWeekDayMonday = 1
    
}startWeekDay;

@interface XZWCalendarView : UIView
{
    startWeekDay startDay;//选择一周的开始是周几
    
}
@property (nonatomic, strong)NSDate *selectedDate;
@property (nonatomic, weak) id <XZWCalendarDelegate>delegate;

-(id)initWithStartDay:(startWeekDay)firstDay;
-(id)initWithStartDay:(startWeekDay)firstDay frame:(CGRect)frame;

-(void)setTitleFont:(UIFont*)font;
-(UIFont*)titleFont;

-(void)setTitleColor:(UIColor*)color;
-(UIColor*)titleColor;

-(void)setButtonColor:(UIColor*)color;

//-(void)setInnerBorederColor:(UIColor*)color;

-(void)setDayOfWeekFont:(UIFont*)font;
-(UIFont*)dayOfWeekFont;

-(void)setDayOfWeekTextColor:(UIColor*)color;
-(UIColor*)dayOfWeekTextColor;

-(void)setDayOfWeekBottomColor:(UIColor*)bottomColor topColor:(UIColor*)topColor;

-(void)setDateFont:(UIFont*)font;
-(UIFont*)dateFont;

-(void)setDateTextColor:(UIColor*)color;
-(UIColor*)dateTextColor;

-(void)setDateBackgroundColor:(UIColor*)color;
-(UIColor*)dateBackgroundColor;

-(void)setDateBorderColor:(UIColor*)color;
-(UIColor*)dateBorderColor;

@property (nonatomic, strong) UIColor *selectdeDateTextColor;
@property (nonatomic, strong) UIColor *selectedDteBackgroundColor;
@property (nonatomic, strong) UIColor *currentDateTextColor;
@property (nonatomic, strong) UIColor *currentDateBackgroundColor;
@property (nonatomic, strong) UIColor *mestruationDateBackgroundColor;

@property (nonatomic, strong) NSArray *startDataArray;
@property (nonatomic, strong) NSArray *endDateArray;

-(void)moveCalendarToNextMonth;
-(void)moveCalendarToPreviousMonth;

@end


@protocol XZWCalendarDelegate <NSObject>

-(void)calendar:(XZWCalendarView *)calendar didSelectDate:(NSDate*)date;
-(void)handleLeftSwipeGesture;//显示下一个月
-(void)handleRightSwipeGesture;

@end

