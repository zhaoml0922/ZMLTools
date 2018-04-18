//
//  MLSelectImageCollectionViewCell.h
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectImageDelegate <NSObject>

- (void)selectImageWithIndex:(NSInteger)index andIfSelect:(BOOL)isSelect;

@end

@interface MLSelectImageCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIButton *selectBtn;
@property (nonatomic,strong)UIImageView *image;

@property (nonatomic,strong)id<SelectImageDelegate> delegate;


@end
