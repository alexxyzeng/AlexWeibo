//
//  XYUserParam.h
//  xiayao
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//  用户未读书请求的参数模型


#import <Foundation/Foundation.h>
#import "XYBaseParam.h"
@interface XYUserParam : XYBaseParam

/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

@end
