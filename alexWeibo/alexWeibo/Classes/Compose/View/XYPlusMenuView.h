
#import <UIKit/UIKit.h>
@class XYPlusMenuBtn;
@class XYPlusMenuView;

@protocol XYPlusMenuViewDelegate <NSObject>
/**
 *  点击按钮时间的代理方法
 *
 *  @param index 按钮的序号
 */
- (void)didClickMenuViewBtnAtIndex:(NSUInteger)index;

@end

@interface XYPlusMenuView : UIView

/**
 *  显示菜单视图
 */
- (void)show;

@property (nonatomic, strong) id <XYPlusMenuViewDelegate> delegate;
@end
