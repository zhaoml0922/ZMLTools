//
//  NSString+Category.h
//  GoodHall
//
//  Created by zhaoml on 2018/3/14.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
/**
 判断一个字符串是否为空
 
 @return 结果
 */
- (BOOL)isBlankString;

/**
 判断一个字符串是否都是空格
 
 @return 结果
 */
- (BOOL)isAllSpace;


/**
 移除小数末尾的0
 
 @return 结果
 */
- (NSString *)removeDecimalEndZero;


/**
 移除字符串首尾空格
 
 @return 处理后的字符串
 */
- (NSString *)removeWhitespaceCharacterSet;

/**
 移除所有的空格
 
 @return 处理后的字符串
 */
- (NSString *)removeAllSpace;

/**
 移除字符串首尾空格 和 换行符
 
 @return 处理后的字符串
 */
- (NSString *)removeWhitespaceCharacterSetAndNewLine;


/**
 把连续的空格替换成一个空格
 
 @return 结果
 */
-(NSString *)replaceContinuousSpaces;


/**
 判断是否含有表情
 
 @param string 字符
 @return yes or no
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 * 替换字符串
 *
 * @param originalStr 原始的字符串
 * @param oldStr      查找的字符串
 * @param newStr      需要替换的字符串
 *
 * @return 新的字符串
 */
+ (NSString*)replaceString:(NSString *)originalStr withOldString:(NSString *)oldStr withNewString:(NSString *)newStr;

@end
