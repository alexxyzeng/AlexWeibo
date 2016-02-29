

#import "XYComposeView.h"
@interface XYComposeView ()
/**
 *  占位提示符标签
 */
@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation XYComposeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        UILabel *label = [[UILabel alloc] init];
        _placeHolderLabel = label;
        _placeHolderLabel.x = 6;
        _placeHolderLabel.y = 8;
        _placeHolderLabel.font = [UIFont systemFontOfSize:18];
        [_placeHolderLabel sizeToFit];
        [self addSubview:_placeHolderLabel];
    }
    return _placeHolderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _placeHolderLabel.text = placeholder;
    [_placeHolderLabel sizeToFit];
}

- (void)setPlaceholderHidden:(BOOL)placeholderHidden
{
    _placeholderHidden = placeholderHidden;
    _placeHolderLabel.hidden = placeholderHidden;
}
@end
