//
//  BirthCanlendarView.h
//  BirthdayP
//
//  Created by mc on 15/6/5.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirthCanlendarDateView.h"


typedef enum _startWeekDay{
    startWeekDaySunday = 0,
    startWeekDayMonday = 1
    
}startWeekDay;


@interface BirthCanlendarView : UIView<BirthCanlendarDateViewDelegate>
{
    startWeekDay startDay;//选择一周的开始是周几

}
-(id)initWithStartDay:(startWeekDay)firstDay frame:(CGRect)frame;


-(void)intoEditing;
@end
