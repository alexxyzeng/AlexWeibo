//
//  XYComposeView.h
//  
//
//  Created by xiayao on 16/2/24.
//
//

#import <UIKit/UIKit.h>

@interface XYComposeView : UITextView
/**
 *  占位提示符
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  是否隐藏占位提示符
 */
@property (nonatomic, assign) BOOL placeholderHidden;
@end
