//
//  LLDownLoadMannager.h
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LLDownLoadMannager : NSObject

+ (instancetype)sharedManager;

- (void)downLoaderWithUrl:(NSString *)urlString andCompleteBlock:(void (^)(UIImage *img))CompleteBk;

- (void)cancelWithLastUrl:(NSString *)lastUrl;

@end
