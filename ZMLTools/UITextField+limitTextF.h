//
//  UITextField+limitTextF.h
//  Stars
//
//  Created by 魏鹏 on 2017/6/29.
//  Copyright © 2017年 hst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (limitTextF)


#pragma mark - 第一种方法实现，汉字、字母都算一个字符。
//你需要实现下面两个方法配合TextField代理使用。
//通知中实现
- (void)limitTextFieldWithLength:(NSInteger)maxLength;
//需要在 textField: shouldChangeCharactersInRange: replacementString: 方法中实现
- (BOOL)isEnabledWithLength:(NSInteger)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string;


#pragma mark - 第二种方法实现，汉字、字母都算一个字符。
// 这个方法和上面都能限制字数，感觉下面这个好点
-(BOOL)limitWithTextField:(UITextField *)textField changeWithRange:(NSRange)range replacementString:(NSString *)string withMaxLength:(NSInteger)maxLength;


@end
