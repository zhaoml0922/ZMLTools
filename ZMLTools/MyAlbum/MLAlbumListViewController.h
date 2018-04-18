//
//  MLAlbumListViewController.h
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyAlbumDelegate <NSObject>

- (void)returnImageArray:(NSArray *)imageArray;

@end
@interface MLAlbumListViewController : UIViewController

@property (nonatomic,assign)NSInteger totalNumber;

@property (nonatomic,strong)id<MyAlbumDelegate>delegate;

@end
