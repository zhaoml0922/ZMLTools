//
//  LookImageView.m
//  MLAlbum
//
//  Created by zhaoml on 16/8/12.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import "LookImageView.h"

@implementation LookImageView
{
    UIImageView *imageV;
    UITapGestureRecognizer *tap;
    UIButton *selectBtn;
}
- (id)init {
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}


- (void)tapClick {
    [UIView animateWithDuration:0.2 animations:^{
        self.frame =self.rect;
        imageV.frame = self.bounds;
        imageV.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)selectClick:(UIButton *)btn {
    SinglePhotoNumber *phone = [SinglePhotoNumber shareSinglePhotoNumber];
    if (phone.photoNumber >= phone.totalNumber && !btn.selected) {
        [[MLAlertCenter defaultCenter] postAlertWithContent:[NSString stringWithFormat:@"您最多能选择%ld张照片",(long)phone.totalNumber]];
        return;
    }
    
    btn.selected = !btn.selected;
    NSString *imageName = btn.selected?@"选中":@"未选中";
    [selectBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

    [self.delegate bigImageSelectImageWithIndex:self.index andIfSelect:btn.selected];
}

- (void)creatUI {
    self.backgroundColor = [UIColor blackColor];
    self.frame = MyWindow.bounds;
    self.clipsToBounds = YES;
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
    
    imageV = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:imageV];
    
    selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    selectBtn.frame = CGRectMake(SCREEN_WIDTH - 15-25, SCREEN_HEIGHT - 10-15-25, 40, 40);
    selectBtn.imageEdgeInsets = UIEdgeInsetsMake(12.5, 12.5, 12.5, 12.5);
    [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectBtn];
}

- (void)setSelect:(BOOL)select {
    selectBtn.selected = select;
    NSString *imageName = selectBtn.selected?@"选中":@"未选中";
    [selectBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}


- (void)show {
    self.frame = self.rect;
    UIImage *image = [UIImage imageWithCGImage:self.result.aspectRatioThumbnail];
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = width * (image.size.height/image.size.width);
    if (height>= SCREEN_HEIGHT) {
        height = SCREEN_HEIGHT;
        width = height * (image.size.width/image.size.height);
    }
    self.frame = self.rect;
    imageV.frame = self.bounds;
    imageV.image = image;
    [MyWindow addSubview:self];

    [UIView animateWithDuration:0.2 animations:^{
        self.frame = MyWindow.bounds;
        imageV.frame = CGRectMake(0, 0, width, height);
        imageV.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    }];
}

@end
