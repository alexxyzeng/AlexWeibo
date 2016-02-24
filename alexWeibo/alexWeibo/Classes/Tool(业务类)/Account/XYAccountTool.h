//
//  XYAccountTool.h
//  xiayao
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//  专门处理账号的业务（账号存储和读取）

#import <Foundation/Foundation.h>

@class XYAccount;
@interface XYAccountTool : NSObject
/**
 *  保存账户信息
 *
 *  @param account 账户信息
 */
+ (void)saveAccount:(XYAccount *)account;

/**
 *  获取账户信息
 *
 *  @return 账户信息
 */
+ (XYAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
