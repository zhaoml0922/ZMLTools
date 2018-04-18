//
//  NSString+Category.m
//  GoodHall
//
//  Created by zhaoml on 2018/3/14.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+ (NSString*)replaceString:(NSString *)originalStr withOldString:(NSString *)oldStr withNewString:(NSString *)newStr
{
    //字符串的长度
    NSUInteger count = [originalStr length];
    //遍历字符串中的每一个字符
    for(int i =0; i < count; i++)
    {
        if ([originalStr containsString:oldStr]){
            NSRange rang = [originalStr rangeOfString:oldStr];
            originalStr = [originalStr stringByReplacingCharactersInRange:rang withString:newStr];
        }
    }
    return originalStr;
}


- (BOOL) isBlankString {
    
    NSString * s = [self copy];
    
    if ([s isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([s isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([s isEqualToString:@"null"]) {
        return YES;
    }
    
    if ([s isEqualToString:@"nil"]) {
        return YES;
    }
    if ([s isEqualToString:@"<nil>"]) {
        return YES;
    }
    if (s == nil || s == NULL){
        return YES;
    }
    
    if ([s isKindOfClass:[NSNull class]]){
        return YES;
    }
    
    if ([[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        return YES;
    }
    
    return NO;
}

- (BOOL)isAllSpace {
    NSString * handleStr = [self copy];
    if (self.length == 0) {
        return NO;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [handleStr stringByTrimmingCharactersInSet:set];
    if ([trimedString length] == 0) {
        return YES;
    } else {
        return NO;
    }
}


+(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    NSArray *arr = @[@"➋",@"➌",@"➍",@"➎",@"➏",@"➐",@"➑",@"➒"];
    if ([arr containsObject:string]) {
        return returnValue;
    }
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
- (NSString *)removeDecimalEndZero{
    NSString *str = [self copy];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    if (arr.count == 2 ) {//含有小数
        
        while ([str hasSuffix:@"0"]) {
            str = [str substringToIndex:[str length]-1];
        }
        
        if ([str hasSuffix:@"."]) {
            str = [str substringToIndex:[str length]-1];
        }
        
    }
    return str;
    
}

- (NSString *)removeWhitespaceCharacterSet{
    
    NSString *str = [self copy];
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)removeAllSpace{
    NSString *str = [self copy];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

- (NSString *)removeWhitespaceCharacterSetAndNewLine{
    
    NSString *str = [self copy];
    
    NSRange r;
    
    while ((r = [str rangeOfString:@"\n" options:NSRegularExpressionSearch]).location != NSNotFound)
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)replaceContinuousSpaces{
    NSString *s = [self copy];
    
    NSError *error1 = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s{2,}" options:NSRegularExpressionCaseInsensitive error:&error1];
    NSArray *arr = [regex matchesInString:s options:NSMatchingReportCompletion range:NSMakeRange(0, s.length)];
    arr = [[arr reverseObjectEnumerator] allObjects];
    for (NSTextCheckingResult *str in arr) {
        s = [s stringByReplacingCharactersInRange:[str range] withString:@" "];
    }
    return s;
}

@end
