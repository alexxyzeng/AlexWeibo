//
//  XYStatusResult.m
//  xiayao
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYStatusResult.h"

#import "XYStatus.h"
@implementation XYStatusResult
// 告诉MJ框架，数组里的字典转换成哪个模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[XYStatus class]};
}
@end
