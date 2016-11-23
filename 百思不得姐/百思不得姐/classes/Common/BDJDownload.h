//
//  BDJDownload.h
//  百思不得姐
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//   

#import <Foundation/Foundation.h>

//将闭包定义成一个类型
typedef void(^SUCCESSBLOCK)(NSData *data);
typedef void(^FAILBLOCK)(NSError *error);

@interface BDJDownload : NSObject

//参数名可以省略,下面这样写也是对的
//+(void)downloadWithURLString:(NSString *)urlString succes:(void(^)(NSData *data))finishBlock fail:(void(^)(NSError *error)) failBlock;

//也可以像下面这样写(前提是将block定义成类型)
+(void)downloadWithURLString:(NSString *)urlString succes:(SUCCESSBLOCK)finishBlock fail:(FAILBLOCK) failBlock;

@end
