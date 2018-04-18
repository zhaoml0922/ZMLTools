//
//  RegularExpression.m
//  JiFen
//
//  Created by wangchao on 2017/5/24.
//  Copyright © 2017年 tyhd. All rights reserved.
//



#import "RegularExpression.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>

@implementation RegularExpression

/* 是否为手机号 */
+ (BOOL)isMobileNumber:(NSString *)tel
{
    NSString* numRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate* numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    return [numTest evaluateWithObject:tel];
}

/* 是否为数字加字母组合 */
+ (BOOL)isNumLetterCombination:(NSString *)pass
{
    BOOL result = false;
    
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    
    return result;
}
/* 是否为重复连续数字 */
+ (BOOL)isRepeatConsecutiveNumbers:(NSString *)str {
//    {
//        NSString *regex = @"^\\d{6}$";  // 不是6位数字
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//        BOOL eva = [predicate evaluateWithObject:str];
//        if (!eva) { return NO; }
//    }
    {
        NSString *regex = @"^(\\d)\\1+$";  // 全一样
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL eva = [predicate evaluateWithObject:str];
        if (eva) { return YES; }
    }
    {
        // 顺序123456
        NSMutableString *stringM = [NSMutableString string];
        for (int i = 0; i < str.length; i++) {
            NSString *c = [str substringWithRange:NSMakeRange(i, 1)];
            [stringM appendString:[NSString stringWithFormat:@"%ld", c.integerValue - i]];
        }
        NSString *regex = @"^(\\d)\\1+$";  // 全一样
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL eva = [predicate evaluateWithObject:stringM];
        if (eva) { return YES; }
    }
    {
        // 逆序654321
        NSMutableString *stringM = [NSMutableString string];
        for (int i = 0; i < str.length; i++) {
            NSString *c = [str substringWithRange:NSMakeRange(i, 1)];
            [stringM appendString:[NSString stringWithFormat:@"%ld", c.integerValue + i]];
        }
        NSString *regex = @"^(\\d)\\1+$";  // 全一样
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL eva = [predicate evaluateWithObject:stringM];
        if (eva) { return YES; }
    }
    
    return NO;
}

/* 是否为有效密码 6位数字且不为重复连续数字 */
+ (BOOL)isValidPassword:(NSString *)str {
    {
        NSString *regex = @"^\\d{6}$";  // 不是6位数字
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL eva = [predicate evaluateWithObject:str];
        if (!eva) { return NO; }
    }
    {
        NSString *regex = @"^(\\d)\\1+$";  // 全一样
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL eva = [predicate evaluateWithObject:str];
        if (eva) { return NO; }
    }
    {
        // 顺序123456
        NSMutableString *stringM = [NSMutableString string];
        for (int i = 0; i < str.length; i++) {
            NSString *c = [str substringWithRange:NSMakeRange(i, 1)];
            [stringM appendString:[NSString stringWithFormat:@"%ld", c.integerValue - i]];
        }
        NSString *regex = @"^(\\d)\\1+$";  // 全一样
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL eva = [predicate evaluateWithObject:stringM];
        if (eva) { return NO; }
    }
    {
        // 逆序654321
        NSMutableString *stringM = [NSMutableString string];
        for (int i = 0; i < str.length; i++) {
            NSString *c = [str substringWithRange:NSMakeRange(i, 1)];
            [stringM appendString:[NSString stringWithFormat:@"%ld", c.integerValue + i]];
        }
        NSString *regex = @"^(\\d)\\1+$";  // 全一样
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL eva = [predicate evaluateWithObject:stringM];
        if (eva) { return NO; }
    }
    
    return YES;
}

/* 返回中英数字符号字符串 */
+ (NSString *)cnEnNumberCharacter:(NSString *)str{
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    NSString *string = [self filterCharactor:str withRegex:@"[^a-zA-Z\u4e00-\u9fa5\\u0000-\u00FF\uFF00-\uFFFF\\d。、“”]"];
    
    return string;
}

//根据正则，过滤特殊字符
+ (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:0 range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}

/*  获得maxLength长度的字符 */
+ (NSString *)getSubString:(NSString*)string maxLength:(NSUInteger)maxLength
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [string dataUsingEncoding:encoding];
    NSInteger length = [data length];
    
    if (length > maxLength) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(0, maxLength)];
        NSString *content = [[NSString alloc] initWithData:data1 encoding:encoding];//注意：当截取kMaxLength长度字符时把中文字符截断返回的content会是nil
        if (!content || content.length == 0) {
            data1 = [data subdataWithRange:NSMakeRange(0, maxLength - 1)];
            content =  [[NSString alloc] initWithData:data1 encoding:encoding];
        }
        return content;
    }
    return nil;
}

+ (NSString *)generateMsgString
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *msgString = [self getSHA512String:[NSString stringWithFormat:@"%@%@%@",[defaults objectForKey:@"visitorToken"],@"tyhdydd",[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]]];
    
    return msgString;
}

//SHA512加密
+ (NSString *) getSHA512String:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes,(CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


@end
