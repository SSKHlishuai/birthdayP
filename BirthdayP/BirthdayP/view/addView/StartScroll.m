//
//  StartScroll.m
//  ImageParctice
//
//  Created by sskh on 13-11-1.
//  Copyright (c) 2013年 shengshikanghe. All rights reserved.
//

#import "StartScroll.h"

@interface StartScroll()

@property (nonatomic,strong)UIView *starBackgroundView;
@property (nonatomic,strong)UIView *starForegroundView;

@end

@implementation StartScroll

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return [self initWithFrame:frame numberOfStar:5];
}


-(id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    self=[super initWithFrame:frame];
    if(self){
        _numberOfStar = number;
        self.starBackgroundView =[self builedStarViewWithImageName:@"backgroundStar"];
        self.starForegroundView = [self builedStarViewWithImageName:@"foregroundStar"];
        [self addSubview:self.starBackgroundView];
        [self addSubview:self.starForegroundView];
        
    }
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect, point))
    {
        [self changeStarForegroundViewWithPoint:point];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    StartScroll *star = self;
    [UIView transitionWithView:self.starForegroundView duration:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [star changeStarForegroundViewWithPoint:point];
    } completion:^(BOOL finished) {
        
    }];
    
}


-(UIView*)builedStarViewWithImageName:(NSString*)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc]initWithFrame:frame];
    //超出范围不画出来
    view.clipsToBounds=YES;
    for(int i=0;i<self.numberOfStar;i ++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame =CGRectMake(i*frame.size.width/self.numberOfStar, 0, frame.size.width/self.numberOfStar, frame.size.height);
        [view addSubview:imageView];
       
    }
    
    return view;
}

-(void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    //判断触发的是否超出边界
    CGPoint p=point;
    if(p.x < 0)
    {
        p.x=0;
    }
    else if(p.x>self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    
    NSString *str = [NSString stringWithFormat:@"%0.2f",p.x/self.frame.size.width ];
    float score =[str floatValue];
    p.x = score*self.frame.size.width;
    self.starForegroundView.frame=CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(startScroll: score:)])
    {
        [self.delegate startScroll:self score:score];
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
