//
//  UIhelpTools.m
//  UIHelperTools
//
//  Created by zhaoml on 16/5/26.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import "UIhelpTools.h"

@implementation UIhelpTools

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(UIImage *)getRestImage:(UIImage *)source_image maxSize:(NSInteger)maxSize{
    NSData *imageData=[self resetSizeOfImageData:source_image maxSize:maxSize];
    return [UIImage imageWithData:imageData];
}
+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    return imageData;
}


+ (CGRect)setContentLable:(UILabel *)custonLabel
                 andWidth:(CGFloat)width
             andContenStr:(NSString *)content
             andlineSpace:(CGFloat)lineSpace
           andHeightSpace:(long)fontSpace
        andKtextAlignment:(NSTextAlignment)alignment
{
    
    if(content==nil){
        content = @"";
    }
    NSMutableAttributedString *str
    = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpace];//行间距
    [style setAlignment:alignment];
    CFNumberRef num
    = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&fontSpace);
    [str addAttribute:(id)kCTKernAttributeName
                value:(__bridge id)num
                range:NSMakeRange(0, content.length)];
    CFRelease(num);//字间距
    [str addAttribute:NSParagraphStyleAttributeName
                value:style
                range:NSMakeRange(0, [str length])];
    [str addAttribute:NSFontAttributeName
                value:custonLabel.font
                range:NSMakeRange(0, str.length)];
    [str addAttribute:NSForegroundColorAttributeName
                value:custonLabel.textColor
                range:NSMakeRange(0, str.length)];
    [custonLabel setAttributedText:str];
    
    CGRect rect = [str
                   boundingRectWithSize:CGSizeMake(width, 0)
                   options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                   context:nil];
    if(rect.size.height<30){
        rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 30);
    }
    return rect;
}


+ (BOOL)adjustMoneyWithStartString:(NSString *)textString andInputString:(NSString *)string {
    if (string.length == 0)///如果输入的是删除  可以走
    {
        return YES;
    }
    else
    {
        if (textString.length==0)///输入第一个字符时候
        {
            if (([string compare:@"0"]>=0 && [string compare:@"9"]<=0))///只能输入0到9
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            ///输入不是第一个字符
            NSRange range = [textString rangeOfString:@"."];
            if (range.location!=NSNotFound)///如果里面已经有点了
            {
                ///只能输入0到9
                if (([string compare:@"0"]>=0 && [string compare:@"9"]<=0))
                {
                    if (textString.length - range.location>2)///小数点后超过2个字符，不能输入
                    {
                        return NO;
                    }
                    else
                    {
                        return YES;
                    }
                }
                else
                {///输入的不是0到9
                    return NO;
                }
            }
            else
            {///没有.时候，只能输入0到9和.
                if (([string compare:@"0"]>=0 && [string compare:@"9"]<=0) || [string isEqualToString:@"."])
                {
                    return YES;
                }
                else
                {
                    return NO;
                }
            }
        }
    }
}


+ (void)setTextFieldPlaceHoldTypeWithTextField:(UITextField *)textF
                                      andColor:(UIColor *)color
                                       andFont:(NSInteger)number {
    [textF setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [textF setValue:[UIFont systemFontOfSize:number] forKeyPath:@"_placeholderLabel.font"];
}

/*!
 *  @author 赵明亮 , 16-05-17 13:05:12
 *
 *  @brief 看字符串里是否都是空格
 *
 *  @param string 字符串
 *
 *  @return 是否都是空格
 */
+ (BOOL)ifAllBlank:(NSString *)string {
    NSString *strings = [UIhelpTools replaceNullString:string];
    for(int i=0;i<strings.length;i++) {
        NSString *charStr = [strings substringWithRange:NSMakeRange(i, 1)];
        if (![charStr isEqualToString:@" "]) {
            return NO;
        }
    }
    return YES;
}

+ (NSString *)replaceNullString:(NSString *)string {
    if ([string isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",string];
    }
    if([string isKindOfClass:[NSNull class]]|| string== nil){
        return @"";
    }
    return string;
}

+ (void)makeViewCircleWithView:(UIView *)view
                    andTopLeft:(BOOL)topLeft
                   andTopRight:(BOOL)topRight
                 andBottomLeft:(BOOL)bottomLeft
               andBbottomRight:(BOOL)bottomRight
                     andCircle:(CGFloat)circle{

    UIRectCorner upLeft;
    UIRectCorner upRight;
    UIRectCorner downLeft ;
    UIRectCorner downRight;
    if (topLeft) {
        upLeft = UIRectCornerTopLeft;
    }
    if (topRight) {
        upRight = UIRectCornerTopRight;
    }
    if (bottomLeft) {
        downLeft = UIRectCornerBottomLeft;
    }
    if (bottomRight) {
        downRight = UIRectCornerBottomRight;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:upLeft | upRight | downLeft| downRight cornerRadii:CGSizeMake(circle, circle)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
}

@end
