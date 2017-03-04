//
//  LLDownLoaderOp.m
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/3.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "LLDownLoaderOp.h"

@interface LLDownLoaderOp ()

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, copy)void(^completeBk)(UIImage *img);

@end

@implementation LLDownLoaderOp

+ (instancetype)downLoaderWithUrl:(NSString *)urlString andCompleteBlock:(void (^)(UIImage *img))completeBk{
    LLDownLoaderOp *op = [[self alloc]init];
    op.urlString = urlString;
    op.completeBk = completeBk;
    
    return op;
}


- (void)main{
    //获取图片
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]]];
    
    //模拟延迟
    [NSThread sleepForTimeInterval:1];
    
    if(self.isCancelled){
        NSLog(@"被取消了 %@",self.urlString);
    }
    
    //回调更新UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.completeBk(img);
    }];
    
}
@end
