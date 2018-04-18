//
//  UITextView+limitTextF.m
//  Stars
//
//  Created by zhaoml on 2017/7/13.
//  Copyright © 2017年 hst. All rights reserved.
//

#import "UITextView+limitTextF.h"

@implementation UITextView (limitTextF)


- (void)limitTextViewWithTextLength:(NSInteger)maxLength {
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
- (BOOL)isEnabledWithTextLength:(NSInteger)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
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


@end
