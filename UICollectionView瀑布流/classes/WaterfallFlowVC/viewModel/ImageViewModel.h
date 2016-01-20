//
//  ImageViewModel.h
//  UICollectionView瀑布流
//
//  Created by DaisyNiu on 16/1/19.
//  Copyright © 2016年 DaisyNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnValueBlock) (id returnValue);

@interface ImageViewModel : NSObject

@property (nonatomic, strong) ReturnValueBlock returnBlock;
@property (nonatomic, assign) NSInteger        page; // 一次刷新的个数

- (void)requestData;

- (void)setBlockWithReturnBlock:(ReturnValueBlock)returnBlock;
@end
