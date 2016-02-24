//
//  XYAccountTool.m
//  xiayao
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYAccountTool.h"
#import "XYAccount.h"
#import "AFNetworking.h"

#import "XYHttpTool.h"
#import "XYAccountParam.h"

#import "MJExtension.h"


#define XYAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define XYClient_id     @"4157579391"
#define XYRedirect_uri  @"http://www.baidu.com"
#define XYClient_secret @"37244e19cc8a0bd6ecdf1e1af783df9b"

#define XYAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation XYAccountTool

// 类方法一般用静态变量代替成员属性

static XYAccount *_account;
+ (void)saveAccount:(XYAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:XYAccountFileName];
}

+ (XYAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:XYAccountFileName];

        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
        
    }
    
   
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    XYAccountParam *param = [[XYAccountParam alloc] init];
    param.client_id = XYClient_id;
    param.client_secret = XYClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = XYRedirect_uri;
    
    [XYHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        XYAccount *account = [XYAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        [XYAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
