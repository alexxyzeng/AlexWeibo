//
//  XYRootTool.h
//  xiayao
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYRootTool : NSObject
/**
 *  根据版本号是否最新选择根控制器
 *
 *  @param window 启动的主窗口
 */
+ (void)chooseRootViewController:(UIWindow *)window;
@end
