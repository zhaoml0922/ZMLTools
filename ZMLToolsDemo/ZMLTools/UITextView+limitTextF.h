//
//  UITextView+limitTextF.h
//  Stars
//
//  Created by zhaoml on 2017/7/13.
//  Copyright © 2017年 hst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (limitTextF)

- (void)limitTextViewWithTextLength:(NSInteger)maxLength;
//需要在 textField: shouldChangeCharactersInRange: replacementString: 方法中实现

- (BOOL)isEnabledWithTextLength:(NSInteger)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string;


@end
