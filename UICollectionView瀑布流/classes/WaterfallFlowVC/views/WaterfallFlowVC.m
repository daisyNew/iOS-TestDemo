//
//  WaterfallFlowVC.m
//  UICollectionView瀑布流
//
//  Created by DaisyNiu on 16/1/19.
//  Copyright © 2016年 DaisyNiu. All rights reserved.
//

#import "WaterfallFlowVC.h"
#import "CustomCollectionViewCell.h"
#import "ImageViewModel.h"
#import "WaterFlowLayout.h"
#import "MJRefresh.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WaterfallFlowVC ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterLayoutDelegate>

@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ImageViewModel   *model;

@end

@implementation WaterfallFlowVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
    [self getData];
    [self addHeader];
    [self addFooter];
}


- (void)initUI{
    
    WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc]init];
    flowLayout.itemSpace = 5;
    flowLayout.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.clomn = 2; // 列数;
    flowLayout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
     self.collectionView = collectionView;
    
    [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
 
}

- (void)getData{
    
    ImageViewModel *model = [[ImageViewModel alloc]init];

     model.page = 30;
    
    [model setBlockWithReturnBlock:^(id returnValue) {
        
        self.dataSource = returnValue;
        [self.collectionView reloadData];
        
    }];
    [model requestData];
    self.model = model;
}

- (void)addFooter{
    
    __weak typeof(self)weakSelf = self;
    
    [self.collectionView addFooterWithCallback:^{
        
        weakSelf.model.page += 10;

        [weakSelf.model setBlockWithReturnBlock:^(id returnValue) {
            
            [weakSelf.dataSource removeAllObjects];

            [weakSelf.dataSource addObjectsFromArray:returnValue];
            
            [weakSelf.collectionView reloadData];
            
            [weakSelf.collectionView footerEndRefreshing];
        }];
        [weakSelf.model requestData];
    }];
}

- (void)addHeader{
    
    __weak typeof(self)weakSelf = self;

    [self.collectionView addHeaderWithCallback:^{
        [weakSelf.collectionView headerEndRefreshing];
    }];
    
    [self.collectionView headerBeginRefreshing];
}

#pragma mark collectionViewDelegateAndDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageModel *model = self.dataSource[indexPath.row];
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell"
                                                                               forIndexPath:indexPath];
    [cell setModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了第%ld个cell",(long)indexPath.row);

}

#pragma mark WaterFlowDelegate
- (CGFloat)itemHeightLayOut:(WaterFlowLayout *)layOut indexPath:(NSIndexPath *)indexPath
{
    ImageModel *model = self.dataSource[indexPath.row];
    
    if (model.height < 0 || !model) {
        
        return 100;
    }
    else{
        return model.height;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
