//
//  ImagePickerHelper.h
//  MLAlbum
//
//  Created by zhaoml on 16/8/12.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLAlbumListViewController.h"

typedef void (^myblock) (NSArray *imageArray);

@interface ImagePickerHelper : NSObject<MyAlbumDelegate>

@property (nonatomic,copy)myblock bl;

+ (ImagePickerHelper *)defaultImagePickerHelper;

- (void)showImagePickerWithTarget:(id)target
                    andImageNumber:(NSInteger)imageNumber
                    andreturnBlock:(myblock)block;

@end
