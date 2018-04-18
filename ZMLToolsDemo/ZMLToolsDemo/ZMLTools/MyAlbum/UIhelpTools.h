//
//  UIhelpTools.h
//  UIHelperTools
//
//  Created by zhaoml on 16/5/26.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>

@interface UIhelpTools : NSObject

/*!
 *
 *  @brief 颜色转换 IOS中十六进制的颜色转换为UIColor
 *  @param color 字符串
 *
 *  @returnUIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color;


/*!
 *  @brief 压缩图片
 *
 *  @param source_image 原图
 *  @param maxSize      压缩比例
 *
 *  @return 二进制数据
 */
+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;



/*!
 *  @brief 根据特定的label文字内容获取特定的rect
 *
 *  @param custonLabel 原label
 *  @param content     内容
 *  @param lineSpace   行间距
 *  @param fontSpace   字间距
 *  @param alignment   布局样式
 *
 *  @return rect
 */
+ (CGRect)setContentLable:(UILabel *)custonLabel andWidth:(CGFloat)width andContenStr:(NSString *)content andlineSpace:(CGFloat)lineSpace andHeightSpace:(long)fontSpace andKtextAlignment:(NSTextAlignment)alignment;

/*!
 *  @author 赵明亮 , 16-05-25 15:05:07
 *
 *  @brief 输入金钱的判断
 *
 *  @param textString 已经有的字符串
 *  @param string     新输入的字符串
 *
 *  @return 能不能输入这个字符串
 */
+ (BOOL)adjustMoneyWithStartString:(NSString *)textString
                    andInputString:(NSString *)string;


/*!
 *  @author 赵明亮 , 16-05-26 10:05:28
 *
 *  @brief 设置TextField的placeHold的样式
 *
 *  @param textF  textField
 *  @param color  颜色
 *  @param number 大小
 */
+ (void)setTextFieldPlaceHoldTypeWithTextField:(UITextField *)textF
                                      andColor:(UIColor*)color
                                       andFont:(NSInteger)number;




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



/*!
 *  @author 赵明亮 , 16-04-11 11:04:11
 *
 *  @brief 去除空字符串
 *
 *  @param string 原字符串
 *
 *  @return 新字符串
 */
+ (NSString *)replaceNullString:(NSString *)string;


/*!
 *  @author 赵明亮 , 16-05-26 17:05:18
 *
 *  @brief 为View添加圆角
 *
 *  @param view   view
 *  @param topLeft   左上
 *  @param topRight  右上
 *  @param bottomLeft  左下
 *  @param bottomRight 右下
 *  @param circle 角度
 */
+ (void)makeViewCircleWithView:(UIView *)view
                       andTopLeft:(BOOL)topLeft
                      andTopRight:(BOOL)topRight
                         andBottomLeft:(BOOL)bottomLeft
                       andBbottomRight:(BOOL)bottomRight
                     andCircle:(CGFloat)circle;


@end
