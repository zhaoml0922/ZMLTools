//
//  Util.h
//  GoodHall
//
//  Created by zhaoml on 2018/3/14.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMLToolsHelper.h"
@interface Util : NSObject

/*!
 *  @author 赵明亮 , 16-05-17 13:05:12
 *
 *  @brief 看字符串里是否都是空格
 *
 *  @param string 字符串
 *
 *  @return 是否都是空格
 */
+ (BOOL)ifAllBlank:(NSString *)string;

+ (NSString *)replaceNullString:(NSString *)string;

+ (void)startCountdownProcessBlock:(void(^)(NSString *currentTime))processBlock
                       andEndBlock:(void(^)(BOOL success))endBlock;

/**
 *  获取某个字符串中子字符串的位置数组
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
+ (NSMutableArray *)ls_getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString;

 //富文本(如果有相同的元素，就取最后一个元素，这里为了不影响之前的使用，重新写了一个方法)
+ (NSMutableAttributedString *)getLastAttributedStringWithLeftStr:(NSString *)leftStr withleftFont:(CGFloat )leftFont withLeftColor:(UIColor *)leftColor withRightStr:(NSString *)rightStr withRightFont:(CGFloat )rightFont withRightColor:(UIColor *)rightColor;

/**
 文字加向右剪头的布局

 @param title 标题
 @return View
 */
+ (UIView *)creatTitleRightCuspWithTitle:(NSString *)title;

+(CGFloat)getHeightWithStr:(NSString *)str andWidth:(CGFloat)width andTextFont:(int)num andFontType:(BOOL)sys;

@end
