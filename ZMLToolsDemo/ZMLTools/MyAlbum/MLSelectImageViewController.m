//
//  MLSelectImageViewController.m
//  MLAlbum
//
//  Created by zhaoml on 16/8/5.
//  Copyright © 2016年 zhaoml. All rights reserved.
//



#import "MLSelectImageViewController.h"
#import "MLSelectImageCollectionViewCell.h"
#import "LookImageView.h"

@interface MLSelectImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SelectImageDelegate,LookImageViewDelegate>
{
    LookImageView *lookImage;
    NSMutableArray *dataArray;
    UICollectionView *collectView;
    NSMutableArray *selectArray;
}
@end

@implementation MLSelectImageViewController
static NSString *const cellId = @"MLCollectionCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    selectArray = [NSMutableArray array];
    [self creatNav];
    [self creatUI];
    [self loadData];
    // Do any additional setup after loading the view.
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
    [ [UIButton alloc]initWithFrame:CGRectMake(8,0,22,22) ];
    [leftBarItemCustomButton setImage:[UIImage imageNamed:@"返回按钮"]
                             forState:UIControlStateNormal];
    [leftBarItemCustomButton addTarget:self
                                action:@selector(leftClick)
                      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                 initWithCustomView:leftBarItemCustomButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    

    UIButton *rightBarItemCustomButton = [[UIButton alloc]initWithFrame:CGRectMake(8,0,22,22)];
    rightBarItemCustomButton.frame = CGRectMake(8, 0, 40, 22);
    [rightBarItemCustomButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightBarItemCustomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBarItemCustomButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBarItemCustomButton addTarget:self
                                 action:@selector(rightClick)
                       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithCustomView:rightBarItemCustomButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title = @"相册列表";
    
}
- (void)leftClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightClick {
    NSLog(@"完成");
    if (selectArray.count == 0) {
        [[MLAlertCenter defaultCenter] postAlertWithContent:@"请选择照片"];
        return;
    }
    NSMutableArray *returnArray = [NSMutableArray array];
    for ( ALAsset *result in selectArray) {
        UIImage *image = [UIImage imageWithCGImage:result.aspectRatioThumbnail];
        [returnArray addObject:image];
    }
    [self.delegate sureSelectImageWithArray:returnArray];
}


- (void)creatUI{
    
    lookImage = [[LookImageView alloc]init];
    lookImage.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    collectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];
    collectView.dataSource=self;
    collectView.delegate=self;
    [collectView setBackgroundColor:[UIColor whiteColor]];
    collectView.showsVerticalScrollIndicator = NO;
    collectView.minimumZoomScale = 5;
    [collectView registerClass:[MLSelectImageCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    [self.view addSubview:collectView];
}

-(void)loadData
{
    dataArray = [NSMutableArray array];
    @autoreleasepool {
        
        [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            
            if (result == nil) {
                return;
            }
            [dataArray addObject:result];
        }];
        [collectView reloadData];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLSelectImageCollectionViewCell *cell = [collectView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    cell.delegate = self;
    if (dataArray.count!= 0) {
        ALAsset *result = dataArray[indexPath.row];
        cell.selectBtn.tag = 9999999999+indexPath.row;
        cell.selectBtn.selected = NO;
        cell.image.image = [UIImage imageWithCGImage:result.thumbnail];
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((SCREEN_WIDTH-20)/3, (SCREEN_WIDTH-20)/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MLSelectImageCollectionViewCell * cell = (MLSelectImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect rect = CGRectMake(cell.frame.origin.x, cell.frame.origin.y - collectionView.contentOffset.y + 64, cell.frame.size.width, cell.frame.size.height);
    lookImage.rect = rect;
    ALAsset *result = dataArray[indexPath.row];
    lookImage.result = result;
    UIButton *btn = (UIButton *)[self.view viewWithTag:9999999999+indexPath.row];
    lookImage.select = btn.selected;
    lookImage.index = indexPath.row;
    [lookImage show];
}



- (void)bigImageSelectImageWithIndex:(NSInteger)index andIfSelect:(BOOL)isSelect{
   ALAsset *result = dataArray[index];
    if (isSelect) {
        [selectArray addObject:result];
        [SinglePhotoNumber shareSinglePhotoNumber] .photoNumber ++;
    }
    else {
        [SinglePhotoNumber shareSinglePhotoNumber] .photoNumber --;
        [selectArray removeObject:result];
    }
    UIButton *btn = (UIButton *)[self.view viewWithTag:9999999999+index];
    NSString *imageName = isSelect?@"选中":@"未选中";
    btn.selected = isSelect;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}


- (void)selectImageWithIndex:(NSInteger)index andIfSelect:(BOOL)isSelect {
    ALAsset *result = dataArray[index];
    if (isSelect) {
        NSLog(@"选择了第%ld个",(long)index);
        [selectArray addObject:result];
        [SinglePhotoNumber shareSinglePhotoNumber] .photoNumber ++;
    }
    else {
        [SinglePhotoNumber shareSinglePhotoNumber] .photoNumber --;
        [selectArray removeObject:result];
        NSLog(@"取消了第%ld个",(long)index);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
