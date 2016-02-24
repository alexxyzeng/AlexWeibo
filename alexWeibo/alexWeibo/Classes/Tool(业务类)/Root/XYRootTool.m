//
//  XYRootTool.m
//  xiayao
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYRootTool.h"
#define XYVersionKey @"version"
#import "XYTabBarController.h"
#import "XYNewFeatureController.h"
@implementation XYRootTool
// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:XYVersionKey];
    
    // v1.0
    // 判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新的版本号
        
        // 创建tabBarVc
        XYTabBarController *tabBarVc = [[XYTabBarController alloc] init];
        
        // 设置窗口的根控制器
        window.rootViewController = tabBarVc;
        
        
    }else{ // 有最新的版本号
        
        // 进入新特性界面
        // 如果有新特性，进入新特性界面
        XYNewFeatureController *vc = [[XYNewFeatureController alloc] init];
        
        window.rootViewController = vc;
        
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:XYVersionKey];
    }
}
@end
