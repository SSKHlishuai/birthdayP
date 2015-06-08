
//
//  GeneralDefine.h
//  BirthdayP
//
//  Created by mc on 15/6/4.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#ifndef BirthdayP_GeneralDefine_h
#define BirthdayP_GeneralDefine_h




//加载图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#define BLACK_GROUND_IMAGE(name)[UIColor colorWithPatternImage:[UIImage imageNamed:name]]


#define IMAGE_NAMED(name) [UIImage imageNamed:name]


//    数据库路径
#define MNDB_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"GB.db"]



#define Screen_width  [[UIScreen mainScreen] bounds].size.width
#define Screen_height [[UIScreen mainScreen]bounds].size.height
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136),[[[UIScreen mainScreen] currentMode] size]):NO)


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define FRAME(a,b,c,d) CGRectMake(a,b,c,d)

#define HexRGBA(rgbValue,al) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:al]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]

#define COLOR_VAULE(vaule)[UIColor colorWithRed:vaule/255.0 green:vaule/255.0 blue:vaule/255.0 alpha:1.0]

#define COLOR_DIFFERENT_VAULE(a,b,c)[UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]

#define ISNULL(s) [s isKindOfClass:[NSNull class]]

#define GET @"GET"
#define POST @"POST"

#define NSStringFormat(str)      ([NSString stringWithFormat:@"%@",str])
#define NSFormatString(str)      ((![NSStringFormat(str) isEqualToString:@"<null>"]&&![NSStringFormat(str) isEqualToString:@"(null)"])?NSStringFormat(str):@"")

#define SYSTEM_FONT(fontName,fontSize) [UIFont boldSystemFontOfSize:fontSize];
#define Label_font(fontSize) [UIFont systemFontOfSize:fontSize];

#define NavaStatusHeight    64.f




//LOG
#define LOG_CLASS(clazz) NSLog(@"%@",[NSString stringWithUTF8String:class_getName(clazz)]);

#define __LOG_TYPE__ 0 /** 日志级别:0,debug;1,info,2,warn,3,error **/

#if DEBUG   /**调试模式下输出格式定义**/

#define __PROTOCOL_TYPE__  2 /**协议类别：0、本地协议；1、网路协议；2、测试服务端 **/

#if __LOG_TYPE__==0

#define LOG_ME_DEBUG(fmt, ...) NSLog((@"[DEBUG] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LOG_ME_WARN(fmt, ...) NSLog((@"[WARN] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LOG_ME_ERROR(fmt, ...) NSLog((@"[ERROR] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LOG_ME_INFO(fmt, ...) NSLog((@"[INFO] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#elif __LOG_TYPE__==1

#define LOG_ME_DEBUG(fmt, ...)
#define LOG_ME_WARN(fmt, ...) NSLog((@"[WARN] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LOG_ME_ERROR(fmt, ...) NSLog((@"[ERROR] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LOG_ME_INFO(fmt, ...) NSLog((@"[INFO] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#elif __LOG_TYPE__==2

#define LOG_ME_DEBUG(fmt, ...)
#define LOG_ME_WARN(fmt, ...) NSLog((@"[WARN] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LOG_ME_ERROR(fmt, ...) NSLog((@"[ERROR] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LOG_ME_INFO(fmt, ...)

#elif __LOG_TYPE__==3

#define LOG_ME_DEBUG(fmt, ...)
#define LOG_ME_WARN(fmt, ...)
#define LOG_ME_ERROR(fmt, ...) NSLog((@"[ERROR] %s [Line %d] --- " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LOG_ME_INFO(fmt, ...)

#endif
#else

#define __PROTOCOL_TYPE__  1 /**协议类别：0、本地协议；1、网路协议 **/
#define LOG_ME_DEBUG(s,...)
#define LOG_ME_WARN(s,...)
#define LOG_ME_ERROR(s,...)
#define LOG_ME_INFO(s,...)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#endif


#endif
