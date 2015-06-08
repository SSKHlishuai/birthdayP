//
//  BirthCanlendarDateView.m
//  BirthdayP
//
//  Created by mc on 15/6/5.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "BirthCanlendarDateView.h"
#import "OneDateView.h"
#define BUTTON_MARGIN 0
#define BUTTON_xOFFSET 40

#define TOP_HEIGHT 18
#define TITLE_yOFFSET (IS_iPHONE5 ? 73/2.f : 43/2.f)
//#define TITLE_yOFFSET 0

//#define TOP_HEIGHT (IS_iPHONE5 ? 192/2.f : 142/2.f)
#define CALENDAR_CONTAINER_yOFFSET (IS_iPHONE5 ? 192/2.f : 102/2.f)
//#define CALENDAR_CONTAINER_yOFFSET 20
#define DAYS_HEADER_HEIGHT 20
//(IS_iPHONE5 ? 60/2.f : 50/2.f)   43
#define DEFAULT_CELL_WIDTH 100
#define CELL_BORDER_WIDTH (29/2.f)
#define CELL_BORDER_HEIGHT (IS_iPHONE5 ? 44/2.f : 24/2.f)

#define CELL_yOFFSET (IS_iPHONE5 ? 0.f : 20/2.f)

#define CALENDAR_MARGIN (15 - CELL_BORDER_WIDTH/2.f)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define IS_iPHONE5 ([[[UIApplication sharedApplication] delegate] window].frame.size.height > 500.0f)


@implementation BirthCanlendarDateView
{
    NSMutableArray *dateButtons;
    NSInteger currentSelect;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)setMonthShowing:(NSDate *)monthShowing
{
    _monthShowing = monthShowing;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if(!dateButtons)
    {
        dateButtons = [[NSMutableArray alloc]init];
    }
    for (OneDateView *dateButton in dateButtons) {
        [dateButton removeFromSuperview];
    }
    NSLog(@"%@",_monthShowing);
    NSDate *date = [self firstDayOfMonthContainingDate:_monthShowing];
    NSLog(@"%@",date);
    uint dateButtonPosition = 0;
    
    
    while ([self dateIsInMonthShowing:date]&&date)
    {
        OneDateView *dateButton = [[OneDateView alloc]init];
        dateButton.frame = [self calculateDayCellFrame:date];
        [dateButton setLabelAbtn];

        dateButton.date = date;
        dateButton.dateStr = [NSString day:date];
        //[dateButton setBackgroundImage:nil forState:UIControlStateNormal];
        
#define mark - 设定一个生理期数组，并进行比较，再设定背景颜色
        
//        if ([self dateIsToday:dateButton.date]) {
//            dateButton.backgroundColor = HexRGB(0xf8b651);
//            
//        } else if ([dateButton.date isEqualToDate:self.selectedDate]) {
//            
//            dateButton.backgroundColor = [UIColor clearColor];
//            
//        } else {
//            dateButton.backgroundColor = [UIColor clearColor];
//            
//            //计算生理期并设定背景
//            if (self.startDataArray && self.startDataArray.count && self.endDateArray && (self.endDateArray.count == self.startDataArray.count)) {
//                for (int i = 0; i < self.startDataArray.count; i++) {
//                    long  startDate = (long)([[self.startDataArray objectAtIndex:i]longLongValue]/1000);
//                    long  endDate = (long)([[self.endDateArray objectAtIndex:i] longLongValue]/1000);
//                    if (startDate > endDate) {
//                        continue;
//                    }
//                    long thisDate = (long)[dateButton.date timeIntervalSince1970];
//                    
//                    
//                    if (thisDate >= startDate && thisDate <= endDate) {
//                        dateButton.backgroundColor = [self mestruationDateBackgroundColor];
//                    }
//                    
//                }
//            }
//        }
        
        
        
        [self addSubview:dateButton];
        date = [self nextDay:date];
        [dateButtons addObject:dateButton];
        dateButtonPosition++;
    }

    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    
    if (touch) {
        touchPoint = [touch locationInView:self];
        for (int i=0; i<dateButtons.count; i++) {
            OneDateView * buttonTemp = ((OneDateView *)[dateButtons objectAtIndex:i]);

            
            if (CGRectContainsPoint(buttonTemp.frame,touchPoint)) {
                [buttonTemp setSelected:YES];
                
                [buttonTemp changeToRed];
                currentSelect = i;
                
                
                if([self.myDelegate respondsToSelector:@selector(changeCurrentSelete:)])
                {
                    [self.myDelegate performSelector:@selector(changeCurrentSelete:) withObject:[NSString stringWithFormat:@"%ld",currentSelect]];
                }
                
                break;
                
                
                
            }
        }
        
       // [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    if (touch) {
        touchPoint = [touch locationInView:self];
        for (int i=0; i<dateButtons.count; i++) {
            OneDateView * buttonTemp = ((OneDateView *)[dateButtons objectAtIndex:i]);
            if (CGRectContainsPoint(buttonTemp.frame,touchPoint)) {
                    if(currentSelect == i)
                    {
                        continue;
                    }
                else
                {
                    if(currentSelect == -1)
                    {
                        currentSelect=i;
                    }
                    else
                    {
                        OneDateView * buttonTempLast = ((OneDateView *)[dateButtons objectAtIndex:currentSelect]);
                        [buttonTempLast resetToP];
                    }
                    
                    [buttonTemp changeToRed];
                    currentSelect = i;
                    
                    
                   if([self.myDelegate respondsToSelector:@selector(changeCurrentSelete:)])
                   {
                       [self.myDelegate performSelector:@selector(changeCurrentSelete:) withObject:[NSString stringWithFormat:@"%ld",currentSelect]];
                   }


                    
                }
                
            }
        }
        //[self setNeedsDisplay];
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
   
    
    OneDateView * buttonTempLast = ((OneDateView *)[dateButtons objectAtIndex:currentSelect]);
    [buttonTempLast resetToP];
    
    currentSelect = -1;
    
    
    if([self.myDelegate respondsToSelector:@selector(moveEndCurrnetSelect)])
    {
        [self.myDelegate performSelector:@selector(moveEndCurrnetSelect)];
    }
    
    
}


#pragma mark - 进入抖动
-(void)intoEditing
{
    for (int i=0; i<dateButtons.count; i++) {
        OneDateView * buttonTemp = ((OneDateView *)[dateButtons objectAtIndex:i]);
        [buttonTemp doudong];
    }
}




- (NSDate *)nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

- (CGRect)calculateDayCellFrame:(NSDate *)date {
    int row = [self weekNumberInMonthForDate:date] - 1;
    
   // NSLog(@"row= %d, dayOfWeek=%d", row+1, [self dayOfWeekForDate:date]);
    if([self dayOfWeekForDate:date]==7)
    {
        row++;
    }
    
    int placeInWeek = (([self dayOfWeekForDate:date] - 1) - self.calendar.firstWeekday + 8) % 7;
    
    return CGRectMake(placeInWeek * (30+(self.frame.size.width-216)/6)+3, (row * (33.5 )) + CELL_BORDER_HEIGHT + CELL_yOFFSET, 30, 30);
}
- (int)weekNumberInMonthForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSWeekOfMonthCalendarUnit) fromDate:date];
    return comps.weekOfMonth;
}
- (int)dayOfWeekForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return comps.weekday;
}
- (BOOL)dateIsInMonthShowing:(NSDate *)date {
    NSDateComponents *comps1 = [self.calendar components:(NSMonthCalendarUnit) fromDate:self.monthShowing];
    NSDateComponents *comps2 = [self.calendar components:(NSMonthCalendarUnit) fromDate:date];
    return comps1.month == comps2.month;
}
- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:1];
    return [self.calendar dateFromComponents:comps];
}
- (BOOL)dateIsToday:(NSDate *)date {
    NSDateComponents *otherDay = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}


@end
