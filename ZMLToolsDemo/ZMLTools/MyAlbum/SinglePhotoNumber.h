//
//  SinglePhotoNumber.h
//  MLAlbum
//
//  Created by zhaoml on 16/8/12.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SinglePhotoNumber : NSObject


+ (SinglePhotoNumber *)shareSinglePhotoNumber;

@property (nonatomic,assign)NSInteger photoNumber;
@property (nonatomic,assign)NSInteger totalNumber;

@end
