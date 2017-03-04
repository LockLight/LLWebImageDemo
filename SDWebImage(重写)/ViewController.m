//
//  ViewController.m
//  SDWebImage(重写)
//
//  Created by locklight on 17/3/3.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "ViewController.h"
#import "LLDownLoaderOp.h"
#import "LLAppModel.h"
#import "AFNetworking.h"
#import "LLDownLoadMannager.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSMutableDictionary *cacheOp;

@end

@implementation ViewController{
    NSArray<LLAppModel *> *_modelList;
    NSString *_LastUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //取出随机模型
    int randomIndex = arc4random_uniform((uint32_t)_modelList.count);
    LLAppModel *model = _modelList[randomIndex];
    
    
    //判断操作是否重复
    if(![model.icon isEqualToString:_LastUrl] && _LastUrl){
        //单例取消
        [[LLDownLoadMannager sharedManager] cancelWithLastUrl:_LastUrl];
    }
    //保存当前图片地址,做下次的图片地址
    _LastUrl = model.icon;
    
    [[LLDownLoadMannager sharedManager] downLoaderWithUrl:model.icon andCompleteBlock:^(UIImage *img) {
        self.imageView.image = img;
    }];
}

- (void)loadData{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:@"https://raw.githubusercontent.com/zhangxiaochuZXC/ServerFile01/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *responseObject) {
        
        //responseObJect 根据Url解析后为 字典数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:responseObject.count];
        //遍历字典数组
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //构造方法取出字典内的模型 
            LLAppModel *model = [LLAppModel appModelWithDict:obj];
            [arrM addObject:model];
        }];
        
        _modelList = arrM.copy;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
