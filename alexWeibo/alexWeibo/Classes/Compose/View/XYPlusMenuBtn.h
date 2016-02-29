
#import <UIKit/UIKit.h>

@interface XYPlusMenuBtn : UIButton
/**
 *  返回带菜单图片和名称的菜单按钮
 *
 *  @param image 菜单按钮图片
 *  @param title 菜单按钮标题
 *
 *  @return 菜单按钮
 */
+ (instancetype)addMenuBtnWithMenuImg:(UIImage *)menuImage title:(NSString *)title;

@end
