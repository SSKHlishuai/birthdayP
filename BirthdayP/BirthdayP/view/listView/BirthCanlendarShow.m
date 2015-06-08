//
//  BirthCanlendarShow.m
//  BirthdayP
//
//  Created by mc on 15/6/8.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "BirthCanlendarShow.h"

#define Origin_x    10
#define Size_w      40
#define Origin_y    10
#define Size_h      20

@interface BirthCanlendarShow ()
{
    
    UILabel *nameLabel;
    UILabel *genderLabel;
    UILabel *dateLabel;
    UILabel *remarksLabel;
    UILabel *levelLabel;
}

@end
@implementation BirthCanlendarShow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.isSelecting=NO;
    }
    return  self;
}


-(void)setIsSelecting:(BOOL)isSelecting
{
    _isSelecting = isSelecting;
    if(_isSelecting)
    {
        self.hidden=NO;
        [self setNeedsDisplay];
    }
    else
    {
        self.hidden=YES;
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.alignment = NSTextAlignmentRight;
    [@"姓名:" drawInRect:CGRectMake(Origin_x, Origin_y, Size_w , Size_h) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14.f],NSFontAttributeName ,HexRGB(0x63b8ff),NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil]];
    [@"性别:" drawInRect:CGRectMake(self.width/2+Origin_x, Origin_y, Size_w , Size_h) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14.f],NSFontAttributeName ,HexRGB(0x63b8ff),NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil]];
    [@"生日日期:" drawInRect:CGRectMake(Origin_x, Origin_y*2+Size_h, Size_w , Size_h) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14.f],NSFontAttributeName ,HexRGB(0x63b8ff),NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil]];
    [@"重要级别:" drawInRect:CGRectMake(self.width/2+Origin_x, Origin_y*2+Size_h, Size_w , Size_h) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14.f],NSFontAttributeName ,HexRGB(0x63b8ff),NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil]];
    [@"备注:" drawInRect:CGRectMake(Origin_x, Origin_y*3+Size_h*2, Size_w , Size_h) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14.f],NSFontAttributeName ,HexRGB(0x63b8ff),NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil]];
    
    
    
}



@end
