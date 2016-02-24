//
//  XYTabBar.h
//  xiayao
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTabBar;

@protocol XYTabBarDelegate <NSObject>

@optional
- (void)tabBar:(XYTabBar *)tabBar didClickButton:(NSInteger)index;

/**
 *  点击加号按钮的时候调用
 *

 */
- (void)tabBarDidClickPlusButton:(XYTabBar *)tabBar;

@end


@interface XYTabBar : UIView

//@property (nonatomic, assign) NSUInteger tabBarButtonCount;

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<XYTabBarDelegate> delegate;

@end
