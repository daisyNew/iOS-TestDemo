//
//  ImageModel.h
//  UICollectionView瀑布流
//
//  Created by DaisyNiu on 16/1/19.
//  Copyright © 2016年 DaisyNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property (nonatomic, strong) NSString *headline_img; // 图片URL
@property (nonatomic, strong) NSString *title; // 标题
@property (nonatomic, assign) float    height;

- (NSInteger)returnHeightForImageWithUrl:(NSURL *)url;
@end
