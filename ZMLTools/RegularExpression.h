//
//  RegularExpression.h
//  JiFen
//
//  Created by wangchao on 2017/5/24.
//  Copyright © 2017年 tyhd. All rights reserved.
//

/* 正则表达式 */

#import <Foundation/Foundation.h>

@interface RegularExpression : NSObject

/* 是否为手机号 */
+ (BOOL)isMobileNumber:(NSString *)tel;
/* 是否为数字加字母组合 */
+ (BOOL)isNumLetterCombination:(NSString *)pass;
/* 是否为重复连续数字 YES为重复连续数字*/
+ (BOOL)isRepeatConsecutiveNumbers:(NSString *)str;
/* 是否为有效密码 6位数字且不为重复连续数字 YES为可用密码*/
+ (BOOL)isValidPassword:(NSString *)str;
/* 返回中英数字符号字符串 */
+ (NSString *)cnEnNumberCharacter:(NSString *)str;
/* 获得maxLength长度的字符 中文为两个字符*/
+ (NSString *)getSubString:(NSString*)string maxLength:(NSUInteger)maxLength;
/* 获得加密字符串 SHA512*/
+ (NSString *)generateMsgString;
@end
