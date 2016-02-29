//
//  XYCover.h
//  xiayao
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYCover;

@protocol XYCoverDelegate <NSObject>

@optional
// 点击蒙板的时候调用
- (void)coverDidClickCover:(XYCover *)cover;

@end

@interface XYCover : UIView
/**
 *  显示蒙板
 */
+ (instancetype)show;

// 设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<XYCoverDelegate> delegate;

@end
