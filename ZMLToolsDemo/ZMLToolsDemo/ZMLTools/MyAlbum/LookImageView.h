//
//  LookImageView.h
//  MLAlbum
//
//  Created by zhaoml on 16/8/12.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMLToolsHelper.h"
@protocol LookImageViewDelegate <NSObject>

- (void)bigImageSelectImageWithIndex:(NSInteger)index andIfSelect:(BOOL)isSelect;

@end

@interface LookImageView : UIView

@property (nonatomic,strong)ALAsset *result;
@property (nonatomic,assign)CGRect rect;
@property (nonatomic,assign)BOOL select;
@property (nonatomic,assign)NSInteger index;

@property (nonatomic,strong)id<LookImageViewDelegate>delegate;

- (void)show;


@end
