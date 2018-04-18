//
//  MLAlbumListTableViewCell.m
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import "MLAlbumListTableViewCell.h"

@implementation MLAlbumListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, 10, 100, 65)];
        [self addSubview:_image];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_image.right+10, 10, SCREEN_WIDTH - (_image.right+10+12.5) , 16)];
        _nameLabel.textColor = [UIhelpTools colorWithHexString:@"444444"];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_nameLabel];
        
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(_image.right+10, _nameLabel.bottom+15, SCREEN_WIDTH - (_image.right+10+12.5) , 16)];
        _numberLabel.textColor = [UIhelpTools colorWithHexString:@"777777"];
        _numberLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_numberLabel];
        
        UIView *line  = [[UIView alloc]initWithFrame:CGRectMake(12.5, 84.5, SCREEN_WIDTH - 25, 0.5)];
        line.backgroundColor = [UIhelpTools colorWithHexString:@"dddddd"];
        [self addSubview:line];

    }
    return self;
}


- (void)configCellWithALAssetsGroups:(ALAssetsGroup *)g {
    _nameLabel.text = [g valueForProperty:ALAssetsGroupPropertyName];
    _numberLabel.text = [NSString stringWithFormat:@"(%ld张)",[g numberOfAssets]];
    UIImage* image = [UIImage imageWithCGImage:[g posterImage]];
    image = [self resize:image to:CGSizeMake(100, 65)];
    _image.image = image;
}


- (UIImage *)resize:(UIImage *)image to:(CGSize)newSize {

    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
