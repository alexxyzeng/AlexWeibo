//
//  XYComposeToolBar.h
//  
//
//  Created by xiayao on 16/2/24.
//
//

#import <UIKit/UIKit.h>

@class XYComposeToolBar;

@protocol XYComposeToolBarDelegate <NSObject>

@optional
/**
 *  点击toolbar按钮
 *
 *  @param toolBar 底部工具条
 *  @param index   工具条按钮序号
 */
- (void)composeToolBar:(XYComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end


@interface XYComposeToolBar : UIView

@property (nonatomic, weak) id <XYComposeToolBarDelegate> delegate;

@end