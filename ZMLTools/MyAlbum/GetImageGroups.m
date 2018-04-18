//
//  GetImageGroups.m
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import "GetImageGroups.h"

@implementation GetImageGroups


+ (void)getGroupsWithArrayBlock:(void (^)(NSMutableArray *, ALAssetsLibrary *, NSString *))block{
    NSMutableArray *imageArray = [NSMutableArray array];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSString *errorb = @"";
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       @autoreleasepool {
                           
                           // Group enumerator Block
                           void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                           {
                               if (group == nil) {
                                   return;
                               }
                               
                               // added fix for camera albums order
                               NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                               NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                               NSLog(@"%@",[sGroupPropertyName lowercaseString]);
                               if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                                   [imageArray insertObject:group atIndex:0];
                               }
                               else {
                                   [imageArray addObject:group];
                               }
                               block(imageArray,assetsLibrary,errorb);
                           };
                           
                           // Group Enumerator Failure Block
                           void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                               
                               if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
                                   NSString *errorMessage = @"您未对相册授权，请在设置中打开权限设置。";
                                   block(imageArray,assetsLibrary,errorMessage);
                                   
                               } else {
                                   NSString *errorMessage = [NSString stringWithFormat:@"相册错误: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]];
                                  block(imageArray,assetsLibrary,errorMessage);
                               }
                           };
                           
                           // Enumerate Albums
                           [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                                             usingBlock:assetGroupEnumerator
                                                           failureBlock:assetGroupEnumberatorFailure];
                           
                       }
                   });

}
@end
