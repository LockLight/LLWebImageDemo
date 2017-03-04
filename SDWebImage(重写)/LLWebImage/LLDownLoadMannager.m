//
//  LLDownLoadMannager.m
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "LLDownLoadMannager.h"
#import "LLDownLoaderOp.h"
#import "NSString+NSString_LLAddition.h"

@interface LLDownLoadMannager ()


@end

@implementation LLDownLoadMannager{
    NSOperationQueue *_queue;
    NSMutableDictionary *_cachesOp;
    NSMutableDictionary *_cachesImg;
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
        _cachesImg = [NSMutableDictionary dictionary];
    }
    return self;
}

- (BOOL)checkCacheWithUrl:(NSString *)urlString{
    //判断是否有内存缓存
    if([_cachesImg objectForKey:urlString]){
        NSLog(@"内存加载");
        return YES;
    }
    //判断是否有沙盒缓存
    UIImage *sandBoxImage = [UIImage imageWithContentsOfFile:[urlString ll_GetImgPath]];
    if(sandBoxImage){
        NSLog(@"沙盒加载");
        return YES;
    }
    return NO;
}


- (void)downLoaderWithUrl:(NSString *)urlString andCompleteBlock:(void (^)(UIImage *img))CompleteBk{
    //判断是否有缓存
    if([self checkCacheWithUrl:urlString]){
        if(CompleteBk){
            //取出缓存图片,回调控制器
            CompleteBk([_cachesImg objectForKey:urlString]);
        }
        return;
    }
    
    //判断是否重复操作
    if([_cachesOp objectForKey:urlString]){
        return;
    }
    
    //创建下载操作
    LLDownLoaderOp *op = [LLDownLoaderOp downLoaderWithUrl:urlString andCompleteBlock:^(UIImage *img) {
        
        if(CompleteBk){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                CompleteBk(img);
                //存入内存缓存
                [_cachesImg setObject:img forKey:urlString];
                //图片下载完成后,回调移除操作
                [_cachesOp removeObjectForKey:urlString];
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
