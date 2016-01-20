//
//  ImageViewModel.m
//  UICollectionView瀑布流
//
//  Created by DaisyNiu on 16/1/19.
//  Copyright © 2016年 DaisyNiu. All rights reserved.
//

#import "ImageViewModel.h"
#import "ImageModel.h"
#import "AFNetworking.h"

#define HTTPURL @"http://apis.guokr.com/handpick/article.json?limit=%ld&ad=1&category=all&retrieve_type=by_since"


@implementation ImageViewModel


- (void)requestData{
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSString * str = [NSString stringWithFormat:HTTPURL,(long)_page];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:str parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *result = responseObject[@"result"];
        for (NSDictionary *dic in result) {
            
            ImageModel *model = [[ImageModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
             model.height = [model returnHeightForImageWithUrl:[NSURL URLWithString:model.headline_img]];
            [dataArray addObject:model];
        }
             self.returnBlock(dataArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //待处理
    }];
}

- (void)setBlockWithReturnBlock:(ReturnValueBlock)returnBlock{
    self.returnBlock = returnBlock;
}

@end
