//
//  XYBaseParam.h
//  xiayao
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//  基本的参数模型

#import <Foundation/Foundation.h>

@interface XYBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
