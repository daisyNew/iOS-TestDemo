//
//  CustomCollectionViewCell.m
//  UICollectionView瀑布流
//
//  Created by DaisyNiu on 16/1/19.
//  Copyright © 2016年 DaisyNiu. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CustomCollectionViewCell()

@property (nonatomic, strong) UIImageView *bgImg;

@end
@implementation CustomCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:imageView];
    self.bgImg = imageView;
}


- (void)setModel:(ImageModel *)model{

    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.headline_img] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{

    _bgImg.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height);
    
}

@end
