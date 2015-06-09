//
//  AddNewView.m
//  BirthdayP
//
//  Created by mc on 15/6/8.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AddNewView.h"
#import "GenderButton.h"
#import "StartScroll.h"

#define name_X                  20
#define name_label_size_width         40
#define name_textfield_size_width      100
#define name_size_height        20
#define name_Y                  20
#define name_label_color        HexRGB(0x333333)
#define name_label_font         14.f
#define name_textfield_color    HexRGB(0x333333)
#define name_textfield_font     14.f

#define gender_label_size_width 40
#define gender_btn_size_width   40

#define birth_label_size_width  40
#define birth_textfield_size_width 150

#define level_image_size_width        100
#define level_label_size_width         40

#define remark_textview_size_width      150
#define remark_textview_size_height     80

enum{
    GenderManTag = 100,
    GenderWomanTag
};


@interface AddNewView ()<StartScrollDelegate>
{
    UITextField     *nameTF;
    GenderButton    *menBtn;
    GenderButton    *womenBtn;
    
    UITextField     *birthTF;
    
    StartScroll *starview;
    UILabel     *levellabel;
    
    UITextView  *remarkView;
    
    UIDatePicker *myDatePicker;
    
    UIControl *_myControls;
}

@end

@implementation AddNewView



#pragma mark - public
-(void)submitToDb
{
    BirthModel *model = [[BirthModel alloc]init];
    model.bname = nameTF.text;
    model.bgender = @"1";
    model.blevel = levellabel.text;
    model.bbirthday = birthTF.text;
    model.buserid = [[NSDate date]description];
    [[BirthDatabase shareInstance]insertPIDataWithModel:model];
    
}




-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        [self initializeControls];
    }
    return self;
}


-(void)initializeControls
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:FRAME(name_X, name_Y, name_label_size_width, name_size_height)];
    label1.text = @"姓名:";
    label1.textAlignment = NSTextAlignmentRight;
    label1.textColor = name_label_color;
    label1.font = Label_font(name_label_font);
    [self addSubview:label1];
    
    nameTF = [[UITextField alloc]initWithFrame:FRAME(label1.right+10, name_Y, name_textfield_size_width, name_size_height)];
    nameTF.borderStyle = UITextBorderStyleBezel;
    nameTF.textColor = name_textfield_color;
    nameTF.font = Label_font(name_textfield_font);
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:nameTF];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:FRAME(name_X, label1.bottom + 10, gender_label_size_width, name_size_height)];
    label2.text = @"性别:";
    label2.textAlignment = NSTextAlignmentRight;
    label2.textColor = name_label_color;
    label2.font = Label_font(name_label_font);
    [self addSubview:label2];
    
    
    menBtn = [[GenderButton alloc]initWithFrame:FRAME(label2.right+10, label1.bottom + 10,gender_btn_size_width , name_size_height)withNameStr:@"男"];
    menBtn.tag = GenderManTag;
    [menBtn addTarget:self action:@selector(genderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menBtn];
    
    
    
    womenBtn = [[GenderButton alloc]initWithFrame:FRAME(menBtn.right+10, label1.bottom + 10,gender_btn_size_width , name_size_height)withNameStr:@"女"];
    womenBtn.tag = GenderWomanTag;
    [womenBtn addTarget:self action:@selector(genderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:womenBtn];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:FRAME(name_X, label2.bottom+10, birth_label_size_width, name_size_height)];
    label3.text = @"生日:";
    label3.textAlignment = NSTextAlignmentRight;
    label3.textColor = name_label_color;
    label3.font = Label_font(name_label_font);
    [self addSubview:label3];
    
    birthTF = [[UITextField alloc]initWithFrame:FRAME(label3.right+10, label2.bottom+10, birth_textfield_size_width, name_size_height)];
    birthTF.borderStyle = UITextBorderStyleBezel;
    birthTF.textColor = name_textfield_color;
    birthTF.font = Label_font(name_textfield_font);
    birthTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:birthTF];
    
    myDatePicker = [[UIDatePicker alloc]initWithFrame:FRAME(0, 0, kScreenWidth, 200)];
    myDatePicker.datePickerMode = UIDatePickerModeDate;
    [myDatePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    birthTF.inputView = myDatePicker;
    
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:FRAME(name_X, label3.bottom+10, birth_label_size_width, name_size_height)];
    label4.text = @"等级:";
    label4.textAlignment = NSTextAlignmentRight;
    label4.textColor = name_label_color;
    label4.font = Label_font(name_label_font);
    [self addSubview:label4];
    
    starview = [[StartScroll alloc]initWithFrame:FRAME(label3.right+10, label3.bottom+10, level_image_size_width, name_size_height) numberOfStar:5];
    starview.delegate=self;
    [self addSubview:starview];
    
    levellabel = [[UILabel alloc]initWithFrame:FRAME(starview.right+10, label3.bottom+10, level_label_size_width, name_size_height)];
    levellabel.text = @"0.0";
    levellabel.textAlignment = NSTextAlignmentRight;
    levellabel.textColor = name_label_color;
    levellabel.font = Label_font(name_label_font);
    [self addSubview:levellabel];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:FRAME(name_X, label4.bottom+10, birth_label_size_width, name_size_height)];
    label5.text = @"备注:";
    label5.textAlignment = NSTextAlignmentRight;
    label5.textColor = name_label_color;
    label5.font = Label_font(name_label_font);
    [self addSubview:label5];
    
    remarkView = [[UITextView alloc]initWithFrame:FRAME(label5.right+10, label4.bottom+10, remark_textview_size_width, remark_textview_size_height)];
    remarkView.backgroundColor = HexRGB(0xeeeeee);
    [self addSubview:remarkView];
    
    
    _myControls = [[UIControl alloc]initWithFrame:FRAME(0, 0, self.width, self.height)];
    [_myControls addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_myControls];

    [self sendSubviewToBack:_myControls];
    
}



#pragma mark - actions
-(void)genderBtnClick:(GenderButton*)button
{
    if(button.tag == GenderManTag)
    {
        menBtn.isTap = YES;
        womenBtn.isTap = NO;
    }
    else{
        menBtn.isTap = NO;
        womenBtn.isTap = YES;
    }
}

-(void)datePickerChange:(UIDatePicker*)sender
{
    NSDate *select  = [sender date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    birthTF.text = dateAndTime;
}

-(void)controlClick:(id)sender
{
    [nameTF resignFirstResponder];
    [birthTF resignFirstResponder];
    [remarkView resignFirstResponder];
}


#pragma mark - StarDelegate
-(void)startScroll:(StartScroll *)view score:(float)score
{
    levellabel.text = [NSString stringWithFormat:@"%0.2f",score*10];
}



@end
