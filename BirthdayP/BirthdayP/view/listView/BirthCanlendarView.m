//
//  BirthCanlendarView.m
//  BirthdayP
//
//  Created by mc on 15/6/5.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "BirthCanlendarView.h"
#import "BirthCanlendarShow.h"


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





@class CALayer;
@class CAGradientLayer;

@interface BGradientView:UIView

@property (nonatomic,strong,readonly)CAGradientLayer *gradientLayer;
-(void)setColors:(NSArray*)colors;

@end

@implementation BGradientView

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

@interface BirthCanlendarView ()

@property (nonatomic, strong) UIView *highlight;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *prevButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) NSArray *dayOfWeekLabels;
@property (nonatomic, strong) NSMutableArray *dateButtons;
@property (nonatomic, strong) BirthCanlendarDateView *calendarContainer;
@property (nonatomic, strong) BGradientView *daysHeader;
@property (nonatomic)startWeekDay calenndarStartDay;
@property (nonatomic, strong)NSDate *monthShowing;
@property (nonatomic, strong)NSCalendar *calendar;
@property (nonatomic,strong)BirthCanlendarShow *dateShowView;

@end
@implementation BirthCanlendarView



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
        [self initialize];
    }
    return self;
}


#pragma mark - initialize
-(void)initialize
{
    self.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"Chinese"];
    
    [self.calendar setLocale:locale];
    [self.calendar setFirstWeekday:self.calenndarStartDay];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
  //  [prevButton setImage:[UIImage imageNamed:@"richeng_left_grey.png"] forState:UIControlStateNormal];
    prevButton.backgroundColor = [UIColor blueColor];
    prevButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
  //  [prevButton addTarget:self action:@selector(moveCalendarToPreviousMonthAndLoadRecored) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:prevButton];
    self.prevButton = prevButton;
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  //  [nextButton setImage:[UIImage imageNamed:@"richeng_right_grey.png"] forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor blueColor];
    nextButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
  //  [nextButton addTarget:self action:@selector(moveCalendarToNextMonthAndLoadRecored) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextButton];
    self.nextButton = nextButton;
    
    /*
     日历图
     */
    BirthCanlendarDateView *calendarContainer = [[BirthCanlendarDateView alloc]initWithFrame:CGRectZero];
    calendarContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    calendarContainer.myDelegate=self;
    [self addSubview:calendarContainer];
    self.calendarContainer = calendarContainer;
    
    
    BGradientView *daysHeader = [[BGradientView alloc] initWithFrame:CGRectZero];
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
    
    self.highlight.frame = CGRectMake(1, 1, self.bounds.size.width - 2, 1);
    
    self.titleLabel.frame = CGRectMake(0, TITLE_yOFFSET, self.bounds.size.width, TOP_HEIGHT);
    
    CGRect frame = self.titleLabel.frame;
    
    self.prevButton.frame = CGRectMake(BUTTON_xOFFSET, frame.origin.y + frame.size.height/2.f - 38/2.f, 48, 38);
    self.nextButton.frame = CGRectMake(self.bounds.size.width - 48 - BUTTON_xOFFSET, self.prevButton.frame.origin.y, 48, 38);
    
    self.calendarContainer.frame = CGRectMake(CALENDAR_MARGIN, CALENDAR_CONTAINER_yOFFSET, kScreenWidth-CALENDAR_MARGIN*2, 300);
    
    self.daysHeader.frame = CGRectMake(0, 0, self.calendarContainer.frame.size.width, DAYS_HEADER_HEIGHT);
    
    self.daysHeader.backgroundColor = [UIColor grayColor];
    self.titleLabel.backgroundColor = [UIColor yellowColor];
    self.calendarContainer.backgroundColor = [UIColor greenColor];
    
    CGRect lastDayFrame = CGRectMake( - CELL_BORDER_WIDTH/2.f, 0, 0, 0);
    
    for (UILabel *dayLabel in self.dayOfWeekLabels) {
        dayLabel.frame = CGRectMake(CGRectGetMaxX(lastDayFrame) + CELL_BORDER_WIDTH, lastDayFrame.origin.y, 40, self.daysHeader.frame.size.height);
        lastDayFrame = dayLabel.frame;
    }
    
    
    self.monthShowing = [NSDate date];
    self.calendarContainer.calendar = self.calendar;
    self.calendarContainer.monthShowing = self.monthShowing;
    
    
    
    BirthCanlendarShow *birhtDateShow = [[BirthCanlendarShow alloc]initWithFrame:FRAME(10, self.calendarContainer.bottom+10, kScreenWidth-20, 100)];
    [self addSubview:birhtDateShow];
    self.dateShowView = birhtDateShow;
    
    
    
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

-(void)intoEditing
{
    [self.calendarContainer intoEditing];
}

#pragma mark - BirthDayDelegate
-(void)changeCurrentSelete:(NSString *)currentId
{
    self.dateShowView.isSelecting=YES;
}

-(void)moveEndCurrnetSelect
{
    self.dateShowView.isSelecting=NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
