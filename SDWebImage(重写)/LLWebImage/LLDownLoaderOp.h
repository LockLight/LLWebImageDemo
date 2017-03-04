//
//  LLDownLoaderOp.h
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/3.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LLDownLoaderOp : NSOperation

+ (instancetype)downLoaderWithUrl:(NSURL *)url andSuccessBlock:(void (^)(UIImage *img))bk;

@end
