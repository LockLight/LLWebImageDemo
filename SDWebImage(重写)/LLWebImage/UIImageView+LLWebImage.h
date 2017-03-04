//
//  UIImageView+LLWebImage.h
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLDownLoadMannager.h"

@interface UIImageView (LLWebImage)

@property (nonatomic, copy) NSString *lastUrl;

- (void)ll_setImageWithUrl:(NSString *)urlString andPlaceHoldImage:(UIImage*)holdImage;

- (void)ll_setImageWithUrl:(NSString *)urlString;

@end
