//
//  XYAccount.m
//  xiayao
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYAccount.h"

#define XYAccountTokenKey @"token"
#define XYUidKey @"uid"
#define XYExpires_inKey @"exoires"
#define XYExpires_dateKey @"date"
#define XYNameKey @"name"

#import "MJExtension.h"

@implementation XYAccount
// 底层便利当前的类的所有属性，一个一个归档和接档
MJCodingImplementation
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    XYAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

/**
 *  KVC底层实现：遍历字典里的所有key(uid)
    一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
    寻找有没有带下划线_key,_uid ,直接拿到属性赋值
    寻找有没有key的属性，如果有，直接赋值
    在模型里面找不到对应的Key,就会报错.
 */

@end
