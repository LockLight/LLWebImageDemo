//
//  LLDownLoadMannager.m
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "LLDownLoadMannager.h"
#import "LLDownLoaderOp.h"

@interface LLDownLoadMannager ()


@end

@implementation LLDownLoadMannager{
    NSOperationQueue *_queue;
    NSMutableDictionary *_cachesOp;
}

+ (instancetype)sharedManager{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init{
    if(self = [super init]){
        _queue = [NSOperationQueue new];
        _cachesOp = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)downLoaderWithUrl:(NSString *)urlString andCompleteBlock:(void (^)(UIImage *img))CompleteBk{
    
    if([_cachesOp objectForKey:urlString]){
        return;
    }
    
    
    LLDownLoaderOp *op = [LLDownLoaderOp downLoaderWithUrl:urlString andCompleteBlock:^(UIImage *img) {
        
        if(CompleteBk){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                CompleteBk(img);
            }];
        }
    }];
    
    [_cachesOp setObject:op forKey:urlString];
    [_queue addOperation:op];
}

- (void)cancelWithLastUrl:(NSString *)lastUrl{
    //获取上一次操作
    NSOperation *lastOp = [_cachesOp objectForKey:lastUrl];
    
    if(lastOp){
        [lastOp cancel];
        [_cachesOp removeObjectForKey:lastUrl];
    }
}




@end
