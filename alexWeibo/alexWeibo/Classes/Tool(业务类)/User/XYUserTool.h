//
//  XYUserTool.h
//  xiayao
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//  处理用户业务

#import <Foundation/Foundation.h>
@class XYUserResult,XYUser;
@interface XYUserTool : NSObject


/**
 *  请求用户的未读微博数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(XYUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(XYUser *user))success failure:(void(^)(NSError *error))failure;

@end
