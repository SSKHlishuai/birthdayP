//
//  OneDateView.m
//  BirthdayP
//
//  Created by mc on 15/6/5.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "OneDateView.h"


@interface OneDateView ()
{
    UILabel *titleLabel;
    UIButton    *deleteButton;
}

@end

@implementation OneDateView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    
//    if(self.selected)
//    {
//        self.backgroundColor = [UIColor redColor];
//
//    }
//    else
//    {
//        self.backgroundColor = [UIColor blackColor];
//    }
    
    
    // Drawing code
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
    }
    
    
    return self;
}

-(instancetype)init
{
    self= [super init];
    if(self)
    {
        
    }
    return self;
}


-(void)setLabelAbtn
{
    self.backgroundColor = [UIColor greenColor];
    titleLabel = [[UILabel alloc]initWithFrame:FRAME(0, 0, self.frame.size.width, self.frame.size.height)];
    titleLabel.textAlignment= NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor purpleColor];
    titleLabel.layer.masksToBounds = YES;
    titleLabel.layer.cornerRadius = self.frame.size.width/2.f;
    [self addSubview:titleLabel];
    deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = FRAME(self.frame.size.width-10, 0, 10, 10);
    deleteButton.backgroundColor = [UIColor orangeColor];
    deleteButton.layer.cornerRadius=2.5f;
    [self addSubview:deleteButton];
    deleteButton.hidden=YES;
}


-(void)changeToRed
{
    titleLabel.backgroundColor=[UIColor redColor];
}

-(void)resetToP
{
    titleLabel.backgroundColor = [UIColor purpleColor];
}
-(void)setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
    titleLabel.text  = dateStr;
}

//抖动
- (void)doudong {
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.05];
    shake.toValue = [NSNumber numberWithFloat:0.05];
    shake.duration = 0.25;
    shake.autoreverses = YES;
    shake.repeatCount = 100;
    [self.layer addAnimation:shake forKey:@"imageView"];
    deleteButton.hidden=NO;
//    [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:nil];
    
}





@end
