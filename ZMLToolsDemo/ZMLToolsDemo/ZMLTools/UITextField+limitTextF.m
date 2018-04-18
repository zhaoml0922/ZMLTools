//
//  UITextField+limitTextF.m
//  Stars
//
//  Created by 魏鹏 on 2017/6/29.
//  Copyright © 2017年 hst. All rights reserved.
//

#import "UITextField+limitTextF.h"

@implementation UITextField (limitTextF)

#pragma mark - 第一种方法实现，汉字、字母都算一个字符。

- (void)limitTextFieldWithLength:(NSInteger)maxLength {
    NSString* toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    if(!position){
        if (toBeString.length > maxLength) {
            
            [self showAlerV];
        }
        [self cutTextFieldString:toBeString bytesLength:maxLength];
    }
}

//需要在 textField: shouldChangeCharactersInRange: replacementString: 方法中实现
- (BOOL)isEnabledWithLength:(NSInteger)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    
    NSString* toBeString = [self.text stringByReplacingCharactersInRange:range withString:string];
    
    
    NSUInteger charLen = toBeString.length;
    if (charLen > maxLength) {
        
        if (![string isEqualToString:@""]) {
            if (self.text.length != maxLength) {
                [self cutTextFieldString:toBeString bytesLength:maxLength];
            }
            //获取高亮部分
            UITextRange *selectedRange = [self markedTextRange];
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            if(position){
                return YES;
            }else{
                
                [self showAlerV];
                return NO;
            }
            
        }
    }
    return YES;
}

- (void)cutTextFieldString:(NSString *)textString bytesLength:(NSInteger)maxLength {
    
    NSString *toBeString = self.text;
    NSString *lang = [self.textInputMode primaryLanguage];
    UITextRange *tmpRange = self.selectedTextRange;//记录下开始时候的光标位置
    
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            while (toBeString.length > maxLength && toBeString.length > 1) {
                
                toBeString = [toBeString substringToIndex:toBeString.length - 1];
            }
            self.text = toBeString;
            self.selectedTextRange = tmpRange;
            
        }
    }
    // 中文输入法以外（英文和emoji）的直接对其统计限制即可
    else
    {
        if (toBeString.length > maxLength)
        {
            while (toBeString.length > maxLength) {
                if (toBeString.length > 1) {
                    toBeString = [toBeString substringToIndex:toBeString.length - 1];
                }
            }
            self.text = toBeString;
            self.selectedTextRange = tmpRange;
        }
    }
}


- (void)showAlerV
{
    UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"字数达到最高限制" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [aler show];
}

#pragma mark - 第二种方法实现，汉字、字母都算一个字符。

-(BOOL)limitWithTextField:(UITextField *)textField changeWithRange:(NSRange)range replacementString:(NSString *)string withMaxLength:(NSInteger)maxLength{
    
    // 删除回退的时候返回yes
    if (string.length == 0 && range.length == 1) {
        return YES;
    }
    
    if (!maxLength) {
        maxLength = 50;
    }
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
    if (existedLength - selectedLength + replaceLength > maxLength) {
        [self showAlerV];
        return NO;
    }

    return YES;
    
}

@end
