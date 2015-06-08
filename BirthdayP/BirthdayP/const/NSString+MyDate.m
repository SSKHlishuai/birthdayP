//
//  NSString+MyDate.m
//  MyDateDemo
//
//  Created by 学之网研发 on 14-5-13.
//  Copyright (c) 2014年 学之网研发. All rights reserved.
//

#import "NSString+MyDate.h"
#define NS_CALENDAR_UNIT NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond




@implementation NSString (MyDate)

-(NSString*)timeStamp:(NSDate *)parameterDate
{
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[parameterDate timeIntervalSince1970]];
    return timeStamp;
}



+(NSString*)returnCreateTime:(NSDate *)date
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:date];
    NSInteger year = [comp1 year];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    NSInteger hour = [comp1 hour];
    NSInteger minut = [comp1 minute];
    NSInteger sec = [comp1 second];
    
    return [NSString stringWithFormat:@"%ld%02ld%02ld%02ld%02ld%02ld",year,month,day,hour,minut,sec];
}


-(NSString*)hourToMinutes:(NSDate*)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger minut = [comp1 minute];
    NSInteger hour = [comp1 hour];
    
    return [NSString stringWithFormat:@"%02d:%02d",(int)hour,(int)minut];
}

-(NSString*)monthToDays:(NSDate*)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    
    return [NSString stringWithFormat:@"%02d月%02d日",(int)month,(int)day];
}

-(NSString*)yearToMonthToDays:(NSDate*)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger year = [comp1 year];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    
    return [NSString stringWithFormat:@"%2ld-%02ld-%02ld",(long)year,(long)month,(long)day];

}


+(NSString*)year:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger year = [comp1 year];
    
    return [NSString stringWithFormat:@"%d",(int)year];
}
+(NSString*)month:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger month = [comp1 month];
    
    return [NSString stringWithFormat:@"%ld",(long)month];
}

+(NSString*)week:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger week = [comp1 weekday];
    
    return [NSString stringWithFormat:@"%d",(int)(week-1)];
}

+(NSString*)getWeekName:(int)weekInt
{
    NSString *name=@"";
    switch (weekInt) {
        case 1:
            name= @"星期日";
            break;
        case 2:
            name= @"星期一";
            break;
        case 3:
            name= @"星期二";
            break;
        case 4:
            name= @"星期三";
            break;
        case 5:
            name= @"星期四";
            break;
        case 6:
            name= @"星期五";
            break;
        case 7:
            name= @"星期六";
            break;
            
            
        default:
            name = @"";
            break;
    }
    return name;
}

+(NSString*)day:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger day = [comp1 day];
    
    return [NSString stringWithFormat:@"%d",(int)day];
}

+(NSString*)hour:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger hour = [comp1 hour];
    
    return [NSString stringWithFormat:@"%d小时",(int)hour];
}

-(NSString*)minuts:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger minuts = [comp1 minute];
    
    return [NSString stringWithFormat:@"%d",(int)minuts];
}

-(NSString*)second:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger second = [comp1 second];
    
    return [NSString stringWithFormat:@"%d秒",(int)second];
}
+(NSInteger)getCountDayBetweenDate:(NSDate *)date withBugetDay:(NSString *)bugetDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    unsigned units = NS_CALENDAR_UNIT;
    
    comps = [calendar components:units fromDate:date];
    NSInteger day = [comps day];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    NSDateComponents *adcomps1 = [[NSDateComponents alloc] init];
    NSDate *newdate = nil;
    if ([bugetDay integerValue] <= [comps day]){
        
        [adcomps setYear:0];
        [adcomps setMonth:0];
        [adcomps setDay:[bugetDay integerValue] - day];
        newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        adcomps1 = [[NSDateComponents alloc] init];
        [adcomps1 setYear:0];
        [adcomps1 setMonth:1];
        [adcomps1 setDay:-1];
        
    }
    else{
        [adcomps setYear:0];
        [adcomps setMonth:0];
        [adcomps setDay:[bugetDay integerValue] - day-1];
        newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        [adcomps1 setYear:0];
        [adcomps1 setMonth:-1];
        [adcomps1 setDay:0];
        
    }
    NSDate *newdate1 = [calendar dateByAddingComponents:adcomps1 toDate:newdate options:0];
   
    NSInteger duratTiome = abs([newdate1 timeIntervalSinceDate:newdate]);
    NSInteger durationDay = duratTiome/(24*60*60)+1;
    return durationDay;
}
+ (NSInteger)getCountWeekBetweenDate:(NSDate *)date withBugetDay:(NSString *)bugetDay{
    NSInteger monCount = 0;
    NSInteger durationDay = [self getCountDayBetweenDate:date withBugetDay:bugetDay];
    NSInteger temp = 0;
    if ([[NSString week:date]integerValue] == 1){
        temp = durationDay;
        
    }
    else {
        temp = (durationDay - (7 - [[NSString week:date]integerValue]) - 1);
    }
    monCount = temp/7;
    durationDay%7 == 0?monCount:(monCount+=1);

    return monCount;
}
- (NSString *)hourAndMinute
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger minit = [comp1 minute];
    NSInteger hour = [comp1 hour];
    return [NSString stringWithFormat:@"%02ld:%02ld",hour,minit];
}

- (NSString *)todayHourAndMinute
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger minit = [comp1 minute];
    NSInteger hour = [comp1 hour];
    return [NSString stringWithFormat:@"今天%02ld:%02ld",hour,minit];
}



-(NSString*)AM_PM_Time
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger minit = [comp1 minute];
    NSInteger hour = [comp1 hour];
    if(hour>12)
    {
        return [NSString stringWithFormat:@"%02ld:%02ldpm",hour-12,minit];
    }
    else
    {
        return [NSString stringWithFormat:@"%02ld:%02ldam",hour,minit];
    }
}

- (NSString *)monthAndDayTimeNO
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    return [NSString stringWithFormat:@"%02d 月 %02d 日",(int)month,(int)day];
}
- (NSString *)yearAndmonthAndDayTimeNO
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger year = [comp1 year];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    return [NSString stringWithFormat:@"%d 年%02d 月 %02d 日",(int)year,(int)month,(int)day];
}

-(NSString*)nowMonthDays:(NSDate*)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger year = [comp1 year];
    NSInteger month = [comp1 month];

    
    if(month==1||month==3||month==5||month==7||month==8||month==10||month==12)
    {
        return [NSString stringWithFormat:@"%d",31];
    }
    else if(month ==4||month==6||month==9||month==11)
    {
        return [NSString stringWithFormat:@"%d",30];
    }
    else if((year % 4  == 0 && year % 100 != 0 ) || year % 400 == 0)
    {
        return [NSString stringWithFormat:@"%d",29];
    }
    else
    {
        return [NSString stringWithFormat:@"%d",28];
    }
}



@end
