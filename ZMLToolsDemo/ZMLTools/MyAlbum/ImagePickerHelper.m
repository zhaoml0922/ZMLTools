//
//  ImagePickerHelper.m
//  MLAlbum
//
//  Created by zhaoml on 16/8/12.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import "ImagePickerHelper.h"
static ImagePickerHelper *picker = nil;

@implementation ImagePickerHelper

+ (ImagePickerHelper *)defaultImagePickerHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picker = [[ImagePickerHelper alloc]init];
    });
    return picker;
}

/*!
 *  @author 赵明亮 , 16-08-12 16:08:48
 *
 *  @brief 选择照片
 *
 *  @param target      self
 *  @param imageNumber 应该选择照片的张数
 *  @param block       返回值
 */
- (void)showImagePickerWithTarget:(id)target
                    andImageNumber:(NSInteger)imageNumber
                    andreturnBlock:(myblock)block {
    self.bl = block;
    MLAlbumListViewController *mla = [[MLAlbumListViewController alloc]init];
    mla.totalNumber = imageNumber;
    mla.delegate = self;
    UINavigationController *nav= [[UINavigationController alloc]initWithRootViewController:mla];
    [target presentViewController:nav animated:YES completion:nil];
}


- (void)returnImageArray:(NSArray *)imageArray {
    self.bl(imageArray);
}
@end
