//
//  XYUserTool.m
//  xiayao
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYUserTool.h"

#import "XYUserParam.h"
#import "XYUserResult.h"

#import "XYHttpTool.h"

#import "XYAccountTool.h"
#import "XYAccount.h"
#import "MJExtension.h"
#import "XYUser.h"

@implementation XYUserTool

+ (void)unreadWithSuccess:(void (^)(XYUserResult *))success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    XYUserParam *param = [XYUserParam param];
    param.uid = [XYAccountTool account].uid;
    
    [XYHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
       
        // 字典转换模型
        XYUserResult *result = [XYUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userInfoWithSuccess:(void (^)(XYUser *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    XYUserParam *param = [XYUserParam param];
    param.uid = [XYAccountTool account].uid;
    
    [XYHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
       
        // 用户字典转换用户模型
     XYUser *user = [XYUser objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
