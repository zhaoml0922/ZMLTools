//
//  MLAlbumListViewController.m
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//

#import "MLAlbumListViewController.h"
#import "GetImageGroups.h"
#import "MLAlbumListTableViewCell.h"
#import "MLSelectImageViewController.h"

@interface MLAlbumListViewController ()<UITableViewDelegate,UITableViewDataSource,MLSelectImageDelegate>
{
    UITableView *table;
    NSMutableArray *dataArray;
    ALAssetsLibrary *assetsLibrary;
}
@end

@implementation MLAlbumListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    dataArray = [NSMutableArray array];
    assetsLibrary = [[ALAssetsLibrary alloc] init];
    [self creatNav];
    [self creatUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)setTotalNumber:(NSInteger)totalNumber {
    [SinglePhotoNumber shareSinglePhotoNumber].totalNumber = totalNumber;
}

- (void)creatNav {
    
    self.navigationController.navigationBar.barTintColor = NavColor;
    self.view.backgroundColor = BackGround_Color;
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    self.navigationItem.hidesBackButton = YES;
    /// 隐藏掉导航底部的线条
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        UIView *view = [[UIView alloc]initWithFrame:imageView2.bounds];
                        view.backgroundColor = [UIhelpTools colorWithHexString:@"dddddd"];
                        [imageView2 addSubview:view];
                    }
                }
            }
        }
    }
    
    UIButton *leftBarItemCustomButton =
    [ [UIButton alloc]initWithFrame:CGRectMake(8,0,30,22) ];
    [leftBarItemCustomButton setTitle:@"取消" forState:UIControlStateNormal];
    leftBarItemCustomButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBarItemCustomButton addTarget:self
                                action:@selector(leftClick)
                      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                 initWithCustomView:leftBarItemCustomButton];
    self.navigationItem.rightBarButtonItem = leftItem;
    
    
    self.title = @"相册列表";
    
}

- (void)leftClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatUI {
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    table.separatorColor = [UIColor clearColor];
}

- (void)loadData {
    [GetImageGroups getGroupsWithArrayBlock:^(NSMutableArray *imageArray, ALAssetsLibrary *library, NSString *error) {
        dataArray = imageArray;
        assetsLibrary = library;
        if (error.length != 0) {
            [[MLAlertCenter defaultCenter] postAlertWithContent:error];
        }
        [table reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLAlbumListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"album"];
    if (!cell) {
        cell = [[MLAlbumListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"album"];
    }
    if (dataArray.count != 0) {
        ALAssetsGroup *g = (ALAssetsGroup*)[dataArray objectAtIndex:indexPath.row];
        [cell configCellWithALAssetsGroups:g];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [SinglePhotoNumber shareSinglePhotoNumber].photoNumber = 0;///一张照片没有选择
    MLSelectImageViewController *msVC = [[MLSelectImageViewController alloc]init];
    msVC.assetGroup = [dataArray objectAtIndex:indexPath.row];
    msVC.delegate = self;
    [self.navigationController pushViewController:msVC animated:YES];
}


- (void)sureSelectImageWithArray:(NSArray *)imageArray {
    [self.delegate returnImageArray:imageArray];
    [self leftClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
