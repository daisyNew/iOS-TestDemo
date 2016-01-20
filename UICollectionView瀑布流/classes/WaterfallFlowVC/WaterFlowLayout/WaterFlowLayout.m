//
//  WaterFlowLayout.m
//  UICollectionView瀑布流
//
//  Created by DaisyNiu on 16/1/19.
//  Copyright © 2016年 DaisyNiu. All rights reserved.
//

#import "WaterFlowLayout.h"

@implementation WaterFlowLayout {
    
    NSMutableArray *_columHeightAttay;
    NSMutableArray *_attributeArray;
}

- (void)setClomn:(NSInteger)clomn{
    
    if (_clomn != clomn) {
        _clomn = clomn;
        [self invalidateLayout];
    }
}

- (void)setItemSpace:(NSInteger)itemSpace{
    if (_itemSpace != itemSpace) {
        _itemSpace = itemSpace;
        [self invalidateLayout];
    }
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, edgeInsets)) {
        _edgeInsets = edgeInsets;
        [self invalidateLayout];
    }
}

- (void)prepareLayout {
    [super prepareLayout];
    
    
    _columHeightAttay = [NSMutableArray arrayWithCapacity:_clomn];
    _attributeArray = [NSMutableArray array];
    for (int index = 0; index < _clomn; index++) {
        _columHeightAttay[index] = @(_edgeInsets.top);
    }
   
    CGFloat totalWidth = self.collectionView.bounds.size.width;
    //每行所有的item
    CGFloat totalItemWidth = totalWidth - _edgeInsets.left - _edgeInsets.right - _itemSpace*(_clomn-1);
    //每个item
    CGFloat itemwidth = totalItemWidth/_clomn;
    //所有item的个数
    NSInteger totalItems = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < totalItems; i++) {
        NSInteger currentCol = [self minCurrentCol];
       
        
        CGFloat position_X = _edgeInsets.left+(itemwidth+_itemSpace)*currentCol;
        CGFloat positon_Y = [_columHeightAttay[currentCol] floatValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat itemHeight = 0.0;
        if (_delegate && [_delegate respondsToSelector:@selector(itemHeightLayOut:indexPath:)]) {
            itemHeight = [_delegate itemHeightLayOut:self indexPath:indexPath];
        }
        CGRect frame = CGRectMake(position_X, positon_Y, itemwidth, itemHeight);
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attribute.frame = frame;
        [_attributeArray addObject:attribute];
        CGFloat upDateY = [_columHeightAttay[currentCol] floatValue] + itemHeight + _itemSpace;
        _columHeightAttay[currentCol] = @(upDateY);
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in _attributeArray) {
        CGRect rect1 = attributes.frame;
        if (CGRectIntersectsRect(rect1, rect)) {
            [resultArray addObject:attributes];
        }
    }
    return resultArray;
}

- (CGSize)collectionViewContentSize {
    CGFloat width = self.collectionView.frame.size.width;
    NSInteger index = [self maxCuttentCol];
    CGFloat height = [_columHeightAttay[index] floatValue];
    return CGSizeMake(width, height);
}

- (NSInteger)maxCuttentCol {
    __block CGFloat maxHeight = 0.0;
    __block NSInteger maxIndex = 0;
    [_columHeightAttay enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat heightInArray = [_columHeightAttay[idx] floatValue];
        if (heightInArray > maxHeight ) {
            maxHeight = heightInArray;
            maxIndex = idx;
        }
    }];
    return maxIndex;
}

//每次取最小y的列
- (NSInteger)minCurrentCol {
    __block CGFloat minHeight = MAXFLOAT;
    __block NSInteger minCol = 0;
    [_columHeightAttay enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat heightInArray = [_columHeightAttay[idx] floatValue];
        if (heightInArray < minHeight ) {
            minHeight = heightInArray;
            minCol = idx;
        }
    }];
    return minCol;
}





@end
