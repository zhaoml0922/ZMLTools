//
//  MLAlbumListTableViewCell.h
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMLToolsHelper.h"
@interface MLAlbumListTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UIImageView *image;

- (void)configCellWithALAssetsGroups:(ALAssetsGroup *)g;
@end
