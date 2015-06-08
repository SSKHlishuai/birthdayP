//
//  GenderButton.m
//  BirthdayP
//
//  Created by mc on 15/6/8.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "GenderButton.h"


#define UNTapImage  @"gender_untaped"
#define TapImage    @"gender_taped"

@interface GenderButton ()
{
    UIImageView *bgImage;
    UILabel *namelabel;
}

@end
@implementation GenderButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame withNameStr:(NSString*)namestr
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initialize:namestr];
    }
    return self;
}

-(void)initialize:(NSString*)namestr
{
    bgImage = [[UIImageView alloc]initWithFrame:FRAME(0, 0, self.width/3.f, self.height)];
    bgImage.image = IMAGE_NAMED(UNTapImage);
    bgImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:bgImage];
    
    
    namelabel = [[UILabel alloc]initWithFrame:FRAME(bgImage.right, 0, self.width*2.f/3.f, self.height)];
    namelabel.text = namestr;
    namelabel.textAlignment = NSTextAlignmentCenter;
    namelabel.textColor = HexRGB(0x444444);
    namelabel.font = Label_font(14.f);
    [self addSubview:namelabel];
}


-(void)setIsTap:(int)isTap
{
    _isTap = isTap;
    if(_isTap)
    {
        bgImage.image = IMAGE_NAMED(TapImage);
    }
    else
    {
        bgImage.image = IMAGE_NAMED(UNTapImage);
    }
    
}

@end
