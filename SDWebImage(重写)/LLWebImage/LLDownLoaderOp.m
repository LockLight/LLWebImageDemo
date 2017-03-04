//
//  LLDownLoaderOp.m
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/3.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "LLDownLoaderOp.h"

@interface LLDownLoaderOp ()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy)void(^bk)(UIImage *img);

@end

@implementation LLDownLoaderOp

+ (instancetype)downLoaderWithUrl:(NSURL *)url andSuccessBlock:(void (^)(UIImage *img))bk{
    LLDownLoaderOp *op = [[self alloc]init];
    op.url = url;
    op.bk = bk;
    
    return op;
}


- (void)main{
    //获取图片
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.url]];
    
    //回调更新UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.bk(img);
    }];
    
}
@end
