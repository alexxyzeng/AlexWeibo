//
//  XYStatusResult.h
//  xiayao
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface XYStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（XYStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int total_number;

@end
