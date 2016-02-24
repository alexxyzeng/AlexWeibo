//
//  XYBaseParam.m
//  xiayao
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYBaseParam.h"
#import "XYAccountTool.h"
#import "XYAccount.h"

@implementation XYBaseParam

+ (instancetype)param
{
    XYBaseParam *param = [[self alloc] init];
    
    param.access_token = [XYAccountTool account].access_token;
    
    return param;
}

@end
