//
//  XZWCalendarView.m
//  5-5-DEMO
//
//  Created by 学之网研发 on 14-5-12.
//  Copyright (c) 2014年 学之网研发. All rights reserved.
//

#import "XZWCalendarView.h"
#import "CalendarDateView.h"

@class CALayer;
@class CAGradientLayer;

@interface GradientView:UIView

@property (nonatomic,strong,readonly)CAGradientLayer *gradientLayer;
-(void)setColors:(NSArray*)colors;

@end

@implementation GradientView

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

+(Class)layerClass
{
    return [CAGradientLayer class];
}

-(CAGradientLayer*)gradientLayer
{
    return (CAGradientLayer*)self.layer;
}

-(void)setColors:(NSArray *)colors
{
    NSMutableArray *cgColors = [NSMutableArray array];
    for(UIColor *color in colors){
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    self.gradientLayer.colors = cgColors;
}

@end

@interface DateButton : UIButton

@property (nonatomic, strong)NSDate *date;

@end

@implementation DateButton

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self.layer setCornerRadius:CGRectGetHeight(self.bounds)/2.f];
    [self.layer setMasksToBounds:YES];
    self.layer.borderColor = [HexRGB(0xdedede) CGColor];
    self.layer.borderWidth = 1.f;
    self.backgroundColor = [UIColor orangeColor];
}

-(void)setDate:(NSDate *)aDate
{
    _date = aDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"d";
    [self setTitle:[dateFormatter stringFromDate:_date] forState:UIControlStateNormal];
}

@end

@interface XZWCalendarView ()

@property (nonatomic, strong) UIView *highlight;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *prevButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) CalendarDateView *calendarContainer;
@property (nonatomic, strong) GradientView *daysHeader;
@property (nonatomic, strong) NSArray *dayOfWeekLabels;
@property (nonatomic, strong) NSMutableArray *dateButtons;

@property (nonatomic)startWeekDay calenndarStartDay;
@property (nonatomic, strong)NSDate *monthShowing;
@property (nonatomic, strong)NSCalendar *calendar;
@property float cellWidth;

@end

@implementation XZWCalendarView

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

-(id)init
{
    return [self initWithStartDay:startWeekDaySunday];
}
-(id)initWithStartDay:(startWeekDay)firstDay
{
    self.calenndarStartDay = firstDay;
    return [self initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
}
-(id)initWithStartDay:(startWeekDay)firstDay frame:(CGRect)frame
{
    self.calenndarStartDay = firstDay;
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"Chinese"];
        
        [self.calendar setLocale:locale];
        [self.calendar setFirstWeekday:self.calenndarStartDay];
        self.cellWidth = DEFAULT_CELL_WIDTH;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIButton *prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [prevButton setImage:[UIImage imageNamed:@"richeng_left_grey.png"] forState:UIControlStateNormal];
        prevButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [prevButton addTarget:self action:@selector(moveCalendarToPreviousMonthAndLoadRecored) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prevButton];
        self.prevButton = prevButton;
        
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nextButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [nextButton setImage:[UIImage imageNamed:@"richeng_right_grey.png"] forState:UIControlStateNormal];
        nextButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        //[nextButton addTarget:self action:@selector(moveCalendarToNextMonth) forControlEvents:UIControlEventTouchUpInside];
        [nextButton addTarget:self action:@selector(moveCalendarToNextMonthAndLoadRecored) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
        self.nextButton = nextButton;
        
        /*
         日历图
         */
        CalendarDateView *calendarContainer = [[CalendarDateView alloc]initWithFrame:CGRectZero];
        calendarContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        
        [self addSubview:calendarContainer];
        self.calendarContainer = calendarContainer;
        
        
        GradientView *daysHeader = [[GradientView alloc] initWithFrame:CGRectZero];
        daysHeader.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self.calendarContainer addSubview:daysHeader];
        self.daysHeader = daysHeader;
        
        NSMutableArray *weekNames = [NSMutableArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
        NSMutableArray *labels = [NSMutableArray array];
        for (NSString *s in weekNames) {
            UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            dayOfWeekLabel.text = s;
            dayOfWeekLabel.textAlignment = NSTextAlignmentCenter;
            dayOfWeekLabel.backgroundColor = [UIColor clearColor];
            [labels addObject:dayOfWeekLabel];
            [self.calendarContainer addSubview:dayOfWeekLabel];
        }
        
        self.dayOfWeekLabels = labels;
        
        NSMutableArray *dateButtons = [NSMutableArray array];
        dateButtons = [NSMutableArray array];
        for (int i = 0; i < 43; i++) {
            DateButton *dateButton = [DateButton buttonWithType:UIButtonTypeCustom];
            [dateButton setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [dateButton addTarget:self action:@selector(dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [dateButtons addObject:dateButton];
            
        }
        self.dateButtons = dateButtons;
        
        // initialize the thing
        self.monthShowing = [NSDate date];
        [self setDefaultStyle];

    }
    //[self layoutSubviews];
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat containerWidth = self.bounds.size.width - (CALENDAR_MARGIN*2);
    self.cellWidth = containerWidth/7.0 - CELL_BORDER_WIDTH;
    //在这里再加上一定高度，从而使self的height增加，使最下面的日期可点击
    CGFloat otherHeight = (IS_iPHONE5 ? 80 : 50);
    
    CGFloat containerHeight = (6 * (self.cellWidth + CELL_BORDER_HEIGHT) + DAYS_HEADER_HEIGHT + CELL_yOFFSET + otherHeight);
    
    
    CGRect newFrame = self.frame;
    newFrame.size.height = containerHeight + CALENDAR_MARGIN + TOP_HEIGHT;
    self.frame = newFrame;
    
    self.highlight.frame = CGRectMake(1, 1, self.bounds.size.width - 2, 1);
    
    self.titleLabel.frame = CGRectMake(0, TITLE_yOFFSET, self.bounds.size.width, TOP_HEIGHT);
    
    CGRect frame = self.titleLabel.frame;
    
    self.prevButton.frame = CGRectMake(BUTTON_xOFFSET, frame.origin.y + frame.size.height/2.f - 38/2.f, 48, 38);
    self.nextButton.frame = CGRectMake(self.bounds.size.width - 48 - BUTTON_xOFFSET, self.prevButton.frame.origin.y, 48, 38);
    
    self.calendarContainer.frame = CGRectMake(CALENDAR_MARGIN, CALENDAR_CONTAINER_yOFFSET, containerWidth, containerHeight);
    
    self.daysHeader.frame = CGRectMake(0, 0, self.calendarContainer.frame.size.width, DAYS_HEADER_HEIGHT);
    
    
    CGRect lastDayFrame = CGRectMake( - CELL_BORDER_WIDTH/2.f, 0, 0, 0);
    
    for (UILabel *dayLabel in self.dayOfWeekLabels) {
        dayLabel.frame = CGRectMake(CGRectGetMaxX(lastDayFrame) + CELL_BORDER_WIDTH, lastDayFrame.origin.y, self.cellWidth, self.daysHeader.frame.size.height);
        lastDayFrame = dayLabel.frame;
    }
    
    for (DateButton *dateButton in self.dateButtons) {
        [dateButton removeFromSuperview];
    }
    
    NSDate *date = [self firstDayOfMonthContainingDate:self.monthShowing];
    NSLog(@"%@",date);
    uint dateButtonPosition = 0;
    
    
    while ([self dateIsInMonthShowing:date])
    {
        DateButton *dateButton = [self.dateButtons objectAtIndex:dateButtonPosition];
        
        dateButton.date = date;
        
        [dateButton setBackgroundImage:nil forState:UIControlStateNormal];
        
#define mark - 设定一个生理期数组，并进行比较，再设定背景颜色
        
        if ([self dateIsToday:dateButton.date]) {
            [dateButton setTitleColor:self.currentDateTextColor forState:UIControlStateNormal];
            dateButton.backgroundColor = HexRGB(0xf8b651);
           
        } else if ([dateButton.date isEqualToDate:self.selectedDate]) {
            
            dateButton.backgroundColor = [UIColor clearColor];
            [dateButton setTitleColor:self.selectdeDateTextColor forState:UIControlStateNormal];
            
        } else {
            dateButton.backgroundColor = [UIColor clearColor];
            [dateButton setTitleColor:[self dateTextColor] forState:UIControlStateNormal];
            
            //计算生理期并设定背景
            if (self.startDataArray && self.startDataArray.count && self.endDateArray && (self.endDateArray.count == self.startDataArray.count)) {
                for (int i = 0; i < self.startDataArray.count; i++) {
                    long  startDate = (long)([[self.startDataArray objectAtIndex:i]longLongValue]/1000);
                    long  endDate = (long)([[self.endDateArray objectAtIndex:i] longLongValue]/1000);
                    if (startDate > endDate) {
                        continue;
                    }
                    long thisDate = (long)[dateButton.date timeIntervalSince1970];
              
                    
                    if (thisDate >= startDate && thisDate <= endDate) {
                        dateButton.backgroundColor = [self mestruationDateBackgroundColor];
                    }
                    
                }
            }
        }
        
        
        
        dateButton.frame = [self calculateDayCellFrame:date];
        
        [self.calendarContainer addSubview:dateButton];
        
        date = [self nextDay:date];
        dateButtonPosition++;
    }
}
- (void)setInnerBorderColor:(UIColor *)color {
    self.calendarContainer.layer.borderColor = color.CGColor;
}

- (void)setDefaultStyle {
    self.backgroundColor = UIColorFromRGB(0x393B40);
    
    [self setTitleColor:HexRGB(0x000000)];
    [self setTitleFont:[UIFont systemFontOfSize:17.0]];
    
    [self setDayOfWeekFont:[UIFont boldSystemFontOfSize:12.0]];
    [self setDayOfWeekTextColor:UIColorFromRGB(0x999999)];
    [self setDayOfWeekBottomColor:UIColorFromRGB(0xCCCFD5) topColor:[UIColor whiteColor]];
    
    [self setDateFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self setDateTextColor:UIColorFromRGB(0x393B40)];
    [self setDateBackgroundColor:UIColorFromRGB(0xF2F2F2)];
    [self setDateBorderColor:UIColorFromRGB(0xDAE1E6)];
    
    [self setSelectdeDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setSelectedDteBackgroundColor:UIColorFromRGB(0x88B6DB)];
    
    [self setCurrentDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setCurrentDateBackgroundColor:[UIColor lightGrayColor]];
    
    [self setMestruationDateBackgroundColor:UIColorFromRGB(0xF2F2F2)];
}
- (void)setMonthShowing:(NSDate *)aMonthShowing {
    _monthShowing = aMonthShowing;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.dateFormat = @"MMMM YYYY";
    dateFormatter.dateFormat = @"YYYY";
    NSString *year = [dateFormatter stringFromDate:aMonthShowing];
    dateFormatter.dateFormat = @"MM";
    NSString *month = [dateFormatter stringFromDate:aMonthShowing];
    self.titleLabel.text = [NSString stringWithFormat:@"%@年 %@月", year, month];
    [self setNeedsLayout];
}

//datebtn  Frame
- (CGRect)calculateDayCellFrame:(NSDate *)date {
    int row = [self weekNumberInMonthForDate:date] - 1;
    
    NSLog(@"row= %d, dayOfWeek=%d", row+1, [self dayOfWeekForDate:date]);
    if([self dayOfWeekForDate:date]==7)
    {
        row++;
    }
    
    int placeInWeek = (([self dayOfWeekForDate:date] - 1) - self.calendar.firstWeekday + 8) % 7;
    
    return CGRectMake(placeInWeek * (self.cellWidth + CELL_BORDER_WIDTH)+3, (row * (33.5 )) + CELL_BORDER_HEIGHT + CELL_yOFFSET, self.cellWidth, 32.5);
}

#pragma mark - 推挤动画
- (void)beginAnimationWithSubtype:(NSString *)subtype
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = subtype;
    [[self.calendarContainer layer] addAnimation:animation forKey:@"animation"];
}

- (void)moveCalendarToNextMonth {
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:1];
    self.monthShowing = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
    //[self beginAnimationWithSubtype:kCATransitionFromRight];
}

- (void)moveCalendarToPreviousMonth {
    //    self.monthShowing = [[self firstDayOfMonthContainingDate:self.monthShowing] dateByAddingTimeInterval:-100000];
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:-1];
    self.monthShowing = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
    //[self beginAnimationWithSubtype:kCATransitionFromLeft];
}
//以下俩方法是我新增的，用来加载对应日期的记录数据
- (void)moveCalendarToPreviousMonthAndLoadRecored
{
    if ([self.delegate respondsToSelector:@selector(handleLeftSwipeGesture)]) {
        [self.delegate handleRightSwipeGesture];
    }
}

- (void)moveCalendarToNextMonthAndLoadRecored
{
    if ([self.delegate respondsToSelector:@selector(handleRightSwipeGesture)]) {
        [self.delegate handleLeftSwipeGesture];
    }
}


- (void)dateButtonPressed:(id)sender {
    DateButton *dateButton = sender;
    self.selectedDate = dateButton.date;
    [self.delegate calendar:self didSelectDate:self.selectedDate];
    //[self setNeedsLayout];
}

#pragma mark - Theming getters/setters

- (void)setTitleFont:(UIFont *)font {
    self.titleLabel.font = font;
}
- (UIFont *)titleFont {
    return self.titleLabel.font;
}

- (void)setTitleColor:(UIColor *)color {
    self.titleLabel.textColor = color;
}
- (UIColor *)titleColor {
    return self.titleLabel.textColor;
}

#pragma mark - 设置左右箭头 及颜色
- (void)setButtonColor:(UIColor *)color {
    [self.prevButton setImage:[XZWCalendarView imageNamed:@"left_arrow.png" withColor:color] forState:UIControlStateNormal];
    [self.nextButton setImage:[XZWCalendarView imageNamed:@"right_arrow.png" withColor:color] forState:UIControlStateNormal];
}



- (void)setDayOfWeekFont:(UIFont *)font {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.font = font;
    }
}
- (UIFont *)dayOfWeekFont {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).font : nil;
}

- (void)setDayOfWeekTextColor:(UIColor *)color {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.textColor = color;
    }
}
- (UIColor *)dayOfWeekTextColor {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).textColor : nil;
}

- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor {
    [self.daysHeader setColors:[NSArray arrayWithObjects:topColor, bottomColor, nil]];
}

- (void)setDateFont:(UIFont *)font {
    for (DateButton *dateButton in self.dateButtons) {
        dateButton.titleLabel.font = font;
    }
}
- (UIFont *)dateFont {
    return (self.dateButtons.count > 0) ? ((DateButton *)[self.dateButtons lastObject]).titleLabel.font : nil;
}

- (void)setDateTextColor:(UIColor *)color {
    for (DateButton *dateButton in self.dateButtons) {
        [dateButton setTitleColor:color forState:UIControlStateNormal];
    }
}
- (UIColor *)dateTextColor {
    return (self.dateButtons.count > 0) ? [((DateButton *)[self.dateButtons lastObject]) titleColorForState:UIControlStateNormal] : nil;
}

- (void)setDateBackgroundColor:(UIColor *)color {
    for (DateButton *dateButton in self.dateButtons) {
        dateButton.backgroundColor = color;
    }
}
- (UIColor *)dateBackgroundColor {
    return (self.dateButtons.count > 0) ? ((DateButton *)[self.dateButtons lastObject]).backgroundColor : nil;
}

- (void)setDateBorderColor:(UIColor *)color {
    self.calendarContainer.backgroundColor = color;
}
- (UIColor *)dateBorderColor {
    return self.calendarContainer.backgroundColor;
}

#pragma mark - Calendar helpers
//一个月的第一天
- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:1];
    return [self.calendar dateFromComponents:comps];
}

- (NSArray *)getDaysOfTheWeek {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
    
    [dateFormatter setLocale:locale];
    
    // adjust array depending on which weekday should be first
    NSArray *weekdays = [dateFormatter shortWeekdaySymbols];
    NSUInteger firstWeekdayIndex = [self.calendar firstWeekday] -1;
    if (firstWeekdayIndex > 0)
    {
        weekdays = [[weekdays subarrayWithRange:NSMakeRange(firstWeekdayIndex, 7-firstWeekdayIndex)]
                    arrayByAddingObjectsFromArray:[weekdays subarrayWithRange:NSMakeRange(0,firstWeekdayIndex)]];
    }
    return weekdays;
}

- (int)dayOfWeekForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return comps.weekday;
}

- (BOOL)dateIsToday:(NSDate *)date {
    NSDateComponents *otherDay = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

- (int)weekNumberInMonthForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSWeekOfMonthCalendarUnit) fromDate:date];
    return comps.weekOfMonth;
}

- (int)numberOfWeeksInMonthContainingDate:(NSDate *)date {
    return [self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}

- (BOOL)dateIsInMonthShowing:(NSDate *)date {
    NSDateComponents *comps1 = [self.calendar components:(NSMonthCalendarUnit) fromDate:self.monthShowing];
    NSDateComponents *comps2 = [self.calendar components:(NSMonthCalendarUnit) fromDate:date];
    return comps1.month == comps2.month;
}

- (NSDate *)nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}


+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
    UIImage *img = [UIImage imageNamed:name];
    
    UIGraphicsBeginImageContext(img.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImg;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
