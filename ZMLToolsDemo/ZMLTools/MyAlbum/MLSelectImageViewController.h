//
//  MLSelectImageViewController.h
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMLToolsHelper.h"
@protocol MLSelectImageDelegate <NSObject>

- (void)sureSelectImageWithArray:(NSArray *)imageArray;

@end

@interface MLSelectImageViewController : UIViewController

@property (nonatomic, strong) ALAssetsGroup *assetGroup;


@property (nonatomic,strong) id<MLSelectImageDelegate> delegate;
@end
