//
//  LLAppModel.m
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "LLAppModel.h"

@implementation LLAppModel

+ (instancetype)appModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
