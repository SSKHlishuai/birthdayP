//
//  StartScroll.h
//  ImageParctice
//
//  Created by sskh on 13-11-1.
//  Copyright (c) 2013年 shengshikanghe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StartScroll;

@protocol StartScrollDelegate <NSObject>

@optional
-(void)startScroll:(StartScroll*)view score:(float)score;

@end


@interface StartScroll : UIView

-(id)initWithFrame:(CGRect)frame numberOfStar:(int)number;
@property (nonatomic,readonly)int numberOfStar;
@property (nonatomic,assign)id <StartScrollDelegate>delegate;

@end
