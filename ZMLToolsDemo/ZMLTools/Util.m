//
//  Util.m
//  GoodHall
//
//  Created by zhaoml on 2018/3/14.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import "Util.h"

@implementation Util

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
    NSString *strings = [Util replaceNullString:string];
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

+ (void)startCountdownProcessBlock:(void (^)(NSString *))processBlock
                       andEndBlock:(void (^)(BOOL))endBlock{
    
    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                endBlock(YES);
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                processBlock(strTime);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

+ (UIView *)creatTitleRightCuspWithTitle:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 14)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHexString:@"535e69"];
    label.text = title;
    [view addSubview:label];
    [label sizeToFit];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(label.right+6.5, 2, 6, 10)];
    image.image = [UIImage imageNamed:@"quanbuyou"];
    [view addSubview:image];
    
    view.frame = CGRectMake(0, 0, image.right + 15, 14);
    return view;
}


/**
 *  获取某个字符串中子字符串的位置数组
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
+ (NSMutableArray *)ls_getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString {
    
    NSMutableArray *arrayRanges = [NSMutableArray array];
    
    if (subString == nil && [subString isEqualToString:@""]) {
        return nil;
    }
    
    NSRange rang = [totalString rangeOfString:subString];
    
    if (rang.location != NSNotFound && rang.length != 0) {
        
        [arrayRanges addObject:[NSNumber valueWithRange:rang]];
        
        NSRange      rang1 = {0,0};
        NSInteger location = 0;
        NSInteger   length = 0;
        
        for (int i = 0;; i++) {
            
            if (0 == i) {
                
                location = rang.location + rang.length;
                length = totalString.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            } else {
                
                location = rang1.location + rang1.length;
                length = totalString.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            
            rang1 = [totalString rangeOfString:subString options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0) {
                
                break;
            } else {
                
                [arrayRanges addObject:[NSNumber valueWithRange:rang1]];
            }
        }
        
        return arrayRanges;
    }
    
    return nil;
}

+ (NSMutableAttributedString *)getLastAttributedStringWithLeftStr:(NSString *)leftStr withleftFont:(CGFloat )leftFont withLeftColor:(UIColor *)leftColor withRightStr:(NSString *)rightStr withRightFont:(CGFloat )rightFont withRightColor:(UIColor *)rightColor{
    
    NSString *divisionStr = leftStr.length>0?leftStr:@"";
    NSString *topStr = rightStr.length>0?rightStr:@"";
    NSString *sectionTitleStr = [NSString stringWithFormat:@"%@%@",divisionStr,topStr];
    NSMutableAttributedString *infoStr = [[NSMutableAttributedString alloc]initWithString:sectionTitleStr];
    NSRange range = [sectionTitleStr rangeOfString:divisionStr];
    [infoStr setAttributes:@{
                             NSFontAttributeName:[UIFont systemFontOfSize:leftFont],
                             NSForegroundColorAttributeName:leftColor
                             } range:range];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[Util ls_getRangeWithTotalString:sectionTitleStr SubString:topStr]];
    NSRange range1;
    if (arr.count>0) {
        NSInteger arrCount = arr.count-1;
        NSNumber * rangNum = arr[arrCount];
        range1 = [rangNum rangeValue];
    } else {
        range1 = [sectionTitleStr rangeOfString:topStr];
    }
    
    
    
    [infoStr setAttributes:@{
                             NSFontAttributeName:[UIFont boldSystemFontOfSize:rightFont],
                             NSForegroundColorAttributeName:rightColor
                             } range:range1];
    
    return infoStr;
    
}


+(CGFloat)getHeightWithStr:(NSString *)str andWidth:(CGFloat)width andTextFont:(int)num andFontType:(BOOL)sys
{
    if(str.length>0)
    {
        UIFont *font;
        if(sys)
        {
            font=[UIFont systemFontOfSize:num];
        }
        else
        {
            font=[UIFont boldSystemFontOfSize:num];
        }
        CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        float height = rect.size.height;
        return height+2;
    }else{
        return 5;
    }
}

@end
