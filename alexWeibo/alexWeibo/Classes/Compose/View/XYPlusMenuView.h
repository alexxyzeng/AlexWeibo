//
//  XYPlusView.h
//  alexWeibo
//
//  Created by xiayao on 16/2/26.
//  Copyright © 2016年 xiayao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYPlusMenuBtn;
@class XYPlusMenuView;

@protocol XYPlusMenuViewDelegate <NSObject>

- (void)didClickMenuViewBtnAtIndex:(NSUInteger)index;

@end

@interface XYPlusMenuView : UIView

/**
 *  显示菜单视图
 */
- (void)show;

@property (nonatomic, strong) id <XYPlusMenuViewDelegate> delegate;
@end
