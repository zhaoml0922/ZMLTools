//
//  GetImageGroups.h
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMLToolsHelper.h"
@interface GetImageGroups : NSObject


+ (void)getGroupsWithArrayBlock:(void (^) (NSMutableArray *imageArray,ALAssetsLibrary *library,NSString *error))block;

@end
