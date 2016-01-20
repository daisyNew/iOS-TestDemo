//
//  ImageModel.m
//  UICollectionView瀑布流
//
//  Created by DaisyNiu on 16/1/19.
//  Copyright © 2016年 DaisyNiu. All rights reserved.
//

#import "ImageModel.h"
#import "BLImageSize.h"

@implementation ImageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

- (NSInteger)returnHeightForImageWithUrl:(NSURL *)url{

    CGSize  size = [BLImageSize dowmLoadImageSizeWithURL:url];
    
    // 获取图片的高度并按比例压缩
    NSInteger itemHeight = size.height * ((([UIScreen mainScreen].bounds.size.width - 20) / 2 / size.width));
    return itemHeight;
    
}
@end
