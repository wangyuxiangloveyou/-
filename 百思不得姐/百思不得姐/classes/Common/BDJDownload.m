//
//  BDJDownload.m
//  百思不得姐
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "BDJDownload.h"

@implementation BDJDownload


+(void)downloadWithURLString:(NSString *)urlString succes:(SUCCESSBLOCK)finishBlock fail:(FAILBLOCK)failBlock{
    
    //1,创建NSURL
    NSURL *url=[NSURL URLWithString:urlString];
    
    //2创建request
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    //3创建AFURLSessionManager对象
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:config];
    
    // .设置返回数据是原始的二进制数据
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    
    //4下载
    NSURLSessionDataTask *task=[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error){
            //请求失败
            failBlock(error);
        }else{
            //请求成功
            NSHTTPURLResponse *r=(NSHTTPURLResponse *)response;
            if (r.statusCode == 200) {
                //返回正确数据
                finishBlock(responseObject);
            }else{
                //请求数据失败
                NSError *e=[NSError errorWithDomain:urlString code:r.statusCode userInfo:@{@"msg":@"下载失败"}];
                 failBlock(e);
            }
        }
    }];
    
    //    5,下载
    [task resume];
    
    
}

@end
