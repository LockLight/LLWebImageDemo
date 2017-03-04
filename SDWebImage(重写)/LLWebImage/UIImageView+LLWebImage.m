//
//  UIImageView+LLWebImage.m
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "UIImageView+LLWebImage.h"
#import <objc/runtime.h>

@implementation UIImageView (LLWebImage)


#pragma mark  关联对象
- (void)setLastUrl:(NSString *)lastUrl{
    /*
     参数1 : 要关联的对象
     参数2 : 关联的key
     参数3 : 关联的值
     参数4 : 关联的值的存储策略
     */
    objc_setAssociatedObject(self, @"lastUrl", lastUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)lastUrl{
    return objc_getAssociatedObject(self, @"lastUrl");
}



- (void)ll_setImageWithUrl:(NSString *)urlString andPlaceHoldImage:(UIImage*)holdImage{
    //判断有占位图
    if(holdImage){
        self.image = holdImage;
    }
    //判断操作是否重复
    if(![urlString isEqualToString:self.lastUrl] && self.lastUrl){
        //单例取消
        [[LLDownLoadMannager sharedManager] cancelWithLastUrl:self.lastUrl];
    }
    //保存当前图片地址,做下次的图片地址
    self.lastUrl = urlString;
    
    [[LLDownLoadMannager sharedManager] downLoaderWithUrl:urlString andCompleteBlock:^(UIImage *img) {
        self.image = img;
    }];
}

- (void)ll_setImageWithUrl:(NSString *)urlString{
    return [self ll_setImageWithUrl:urlString andPlaceHoldImage:nil];
}


@end
