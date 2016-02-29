
#import "XYPlusMenuBtn.h"

@implementation XYPlusMenuBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)addMenuBtnWithMenuImg:(UIImage *)menuImage title:(NSString *)title
{
    XYPlusMenuBtn *menuBtn = [[XYPlusMenuBtn alloc] init];
    menuBtn = [XYPlusMenuBtn buttonWithType:UIButtonTypeCustom];
    [menuBtn setImage:menuImage forState:UIControlStateNormal];
    [menuBtn setImage:menuImage forState:UIControlStateHighlighted];
    [menuBtn setTitle:title forState:UIControlStateNormal];
    [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    menuBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    menuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    return menuBtn;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, 75, 75);
    self.titleLabel.frame = CGRectMake(0, 80, 75, 20);
}


@end
