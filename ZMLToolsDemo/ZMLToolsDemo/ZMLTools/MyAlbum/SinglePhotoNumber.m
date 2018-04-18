//
//  SinglePhotoNumber.m
//  MLAlbum
//
//  Created by zhaoml on 16/8/12.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import "SinglePhotoNumber.h"

static SinglePhotoNumber *single = nil;

@implementation SinglePhotoNumber


+ (SinglePhotoNumber *)shareSinglePhotoNumber {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[SinglePhotoNumber alloc] init];
    });
    return single;
}
@end
