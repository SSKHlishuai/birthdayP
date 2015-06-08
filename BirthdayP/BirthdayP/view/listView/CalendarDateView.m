//
//  CalendarDateView.m
//  lexuezhushou1.0
//
//  Created by 学之网研发 on 14-5-21.
//
//

#import "CalendarDateView.h"

@implementation CalendarDateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//67.7

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    for(int i=0;i<7;i++)
    {
        CGContextBeginPath(context);
        CGPoint myStartPoint = CGPointMake(-10, 22+33*i);
        CGContextSetStrokeColorWithColor(context, [HexRGB(0xdedede) CGColor]);
        
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        
        
        CGContextAddLineToPoint(context,320,22+33*i);
        
        
        CGContextStrokePath(context);

    }
    for(int i=0;i<6;i++)
    {
        CGContextBeginPath(context);
        CGPoint myStartPoint = CGPointMake(44+44*i, 22);
        CGContextSetStrokeColorWithColor(context, [HexRGB(0xdedede) CGColor]);
        
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        
        
        CGContextAddLineToPoint(context,44+44*i,220);
        
        
        CGContextStrokePath(context);
        
    }

    
    
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
