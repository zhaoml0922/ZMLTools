//
//  ZMLToolsHelper.h
//  ZMLToolsDemo
//
//  Created by zhaoml on 2018/4/18.
//  Copyright © 2018年 赵明亮. All rights reserved.
//
// 判断设备
#define iphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MyWindow             [UIApplication sharedApplication].keyWindow


#define NavColor     [UIColor colorWithHexString:@"030100"]
#define LineColor    [UIColor colorWithHexString:@"e3e3e3"]
#define TabbarClickColor  [UIColor colorWithHexString:@"cca857"]
#define BackGround_Color  [UIColor colorWithHexString:@"f3f3f3"]


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MLAlertCenter.h"
#import "NSString+Category.h"
#import "RegularExpression.h"
#import "UIColor+HexString.h"
#import "UITextView+limitTextF.h"
#import "UITextField+limitTextF.h"
#import "Util.h"
#import "MLAlbumHeaders.h"
#import "UIViewExt.h"
#import "ImagePickerHelper.h"

@interface ZMLToolsHelper : NSObject

@end
