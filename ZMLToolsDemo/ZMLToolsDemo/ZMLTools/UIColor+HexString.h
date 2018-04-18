//
//  UIColor+HexString.h
//
//  Created by Micah Hainline
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (NSString *)hexStringForColor:(UIColor *)color;
@end
