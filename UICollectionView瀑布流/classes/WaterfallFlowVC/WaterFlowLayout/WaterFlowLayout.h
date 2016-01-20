//
//  WaterFlowLayout.h
//  UICollectionView瀑布流
//
//  Created by DaisyNiu on 16/1/19.
//  Copyright © 2016年 DaisyNiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;
@protocol WaterLayoutDelegate <NSObject>

@required
/**
 *  设置每个item的自身高度
 *
 *  @param layOut
 *  @param indexPath 所在的位置
 *
 *  @return 高度
 */
- (CGFloat)itemHeightLayOut:(WaterFlowLayout *)layOut indexPath:(NSIndexPath *)indexPath;

@end

@interface WaterFlowLayout : UICollectionViewFlowLayout

/**
  列数
 */
@property (nonatomic, assign) NSInteger    clomn;
/**
   表格之间间隙
 */
@property (nonatomic, assign) NSInteger    itemSpace;
/**
  上下左右间距
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, weak) id<WaterLayoutDelegate>delegate;

@end
