#define XYMenuViewTag                                          1999
#define XYMenuViewImageHeight                                  75
#define XYMenuViewTitleHeight                                  20
#define XYMenuViewVerticalPadding                              20
#define XYMenuViewHorizontalMargin                             30
#define XYMenuViewRiseAnimationID                              @"XYMenuViewRiseAnimationID"
#define XYMenuViewdropAnimationID                              @"XYMenuViewdropAnimationID"
#define XYMenuViewAnimationTime                                0.25
#define XYMenuViewAnimationInterval (XYMenuViewAnimationTime / 5)

#import "XYPlusMenuView.h"
#import "XYPlusMenuBtn.h"
#import "XYComposeViewController.h"

@interface XYPlusMenuView () <UIGestureRecognizerDelegate>
/**
 *  背景视图
 */
@property (nonatomic, strong  ) UIImageView        *bgView;
/**
 *  菜单按钮数组
 */
@property (nonatomic, strong  ) NSMutableArray     *btnArr;
/**
 *  slogan视图
 */
@property (nonatomic, readonly) UIImageView        *sloganView;
/**
 *  关闭按钮
 */
@property (nonnull, weak      ) UIButton           *closeBtn;
@end

@implementation XYPlusMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加触摸手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.delegate                = self;
        [self addGestureRecognizer:tap];
        //添加长按手势
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
//        [self addGestureRecognizer:longPress];

        //设置背景视图
        _bgView                     = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor     = [UIColor whiteColor];
        _bgView.alpha               = 0.95;
        [self addSubview:_bgView];

        //slogan视图
        _sloganView                 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan@3x"]];
        _sloganView.center          = CGPointMake(self.center.x, 130);
        [self addSubview:_sloganView];
        //按钮数组
        _btnArr                     = [NSMutableArray arrayWithCapacity:6];

        //关闭按钮
        UIButton *closeBtn          = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn addTarget:self action:@selector(dismiss)
           forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImage:[UIImage imageNamed:@"compose_close"]
                  forState:UIControlStateNormal];
        [closeBtn setImage:[UIImage imageNamed:@"compose_close_highlighted"]
                  forState:UIControlStateHighlighted];
        closeBtn.frame              = CGRectMake(0, 0, 40, 40);
        closeBtn.center             = CGPointMake(self.center.x, self.bounds.size.height - 20);
        _closeBtn                   = closeBtn;
        [self addSubview:_closeBtn];

        [self addAllMenuBtn];
        [self show];
    }
    return self;
}
//添加全部视图按钮
- (void)addAllMenuBtn
{
    //添加菜单按钮
    [self addMenuBtnWithTitle:@"文字"
                         icon:[UIImage imageNamed:@"tabbar_compose_idea"]
                       target:self
                       action:@selector(showComposeView)
                 controlEvent:UIControlEventTouchUpInside];
    
    [self addMenuBtnWithTitle:@"照片/视频"
                         icon:[UIImage imageNamed:@"tabbar_compose_photo"]
                       target:self action:@selector(showPhotoView)
                 controlEvent:UIControlEventTouchUpInside];
    
    [self addMenuBtnWithTitle:@"头条文章"
                         icon:[UIImage imageNamed:@"tabbar_compose_headlines"]
                       target:self action:@selector(buttonTapped:)
                 controlEvent:UIControlEventTouchUpInside];
    
    [self addMenuBtnWithTitle:@"签到"
                         icon:[UIImage imageNamed:@"tabbar_compose_lbs"]
                       target:self
                       action:nil
                 controlEvent:UIControlEventTouchUpInside];
    
    [self addMenuBtnWithTitle:@"点评"
                         icon:[UIImage imageNamed:@"tabbar_compose_review" ]
                       target:self
                       action:nil
                 controlEvent:UIControlEventTouchUpInside];
    
    [self addMenuBtnWithTitle:@"更多"
                         icon:[UIImage imageNamed:@"tabbar_compose_more" ]
                       target:self
                       action:nil
                 controlEvent:UIControlEventTouchUpInside];
}

- (void)showComposeView
{
    [self buttonTapped:_btnArr[0]];
    int tapTime = 0.45;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(tapTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.delegate didClickMenuViewBtnAtIndex:0];
    });
}

- (void)showPhotoView
{
    [self buttonTapped:_btnArr[1]];
}

//添加单个菜单按钮
- (void)addMenuBtnWithTitle:(NSString *)title icon:(UIImage *)icon target:(id)target action:(SEL)action controlEvent:(UIControlEvents)controlEvent
{
    XYPlusMenuBtn *menuBtn = [XYPlusMenuBtn addMenuBtnWithMenuImg:icon title:title];
    [menuBtn addTarget:self action:action forControlEvents:controlEvent];
    [self addSubview:menuBtn];
    [_btnArr addObject:menuBtn];
}
#pragma mark 手势识别
- (void)longPress:(XYPlusMenuBtn *)btn withGest:(UILongPressGestureRecognizer *)gest
{
    if (gest.state == UIGestureRecognizerStateBegan) {
        //scale动画
        CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        CGRect originalFrame       = btn.imageView.frame;
        originalFrame.size         = CGSizeMake(originalFrame.size.width * 1.2, originalFrame.size.height * 1.2);
        scaleAni.duration          = 0.1;
        scaleAni.fromValue         = @1.0;
        scaleAni.toValue           = @1.5;
        [btn.imageView.layer addAnimation:scaleAni forKey:nil];
    }
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer.view isKindOfClass:[XYPlusMenuBtn class]]) {
        return NO;
    }
    CGPoint location = [gestureRecognizer locationInView:self];
    for (UIView* subview in _btnArr) {
        if (CGRectContainsPoint(subview.frame, location)) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark 计算相应序号的菜单按钮的frame
- (CGRect)btnFrameAtIndex:(NSUInteger)index
{
    //计算列序号
    NSUInteger colCount       = 3;
    NSUInteger colIndex       = index % colCount;
    //计算行序号
    NSUInteger rowCount       = _btnArr.count / colCount + (_btnArr.count % colCount > 0 ? 1 : 0);
    NSUInteger rowIndex       = index / colCount;
    //计算按钮总高度
    CGFloat itemHeight        = (XYMenuViewImageHeight + XYMenuViewTitleHeight) * rowCount + (rowCount > 1?(rowCount - 1) * XYMenuViewHorizontalMargin:0);
    //按钮的y坐标值
    CGFloat offsetY           = (self.bounds.size.height - itemHeight) / 2.0 + 50;
    //第一列按钮距左侧边缘距离
    CGFloat horizontalPadding = (self.bounds.size.width - XYMenuViewHorizontalMargin * 2 - XYMenuViewImageHeight * 3) / 2.0;
    //按钮的x坐标值
    CGFloat offsetX           = XYMenuViewHorizontalMargin;
    offsetX                   += (XYMenuViewImageHeight + horizontalPadding) * colIndex;
    offsetY                   += (XYMenuViewImageHeight + XYMenuViewTitleHeight +
                                  XYMenuViewVerticalPadding) * rowIndex;

    return CGRectMake(offsetX, offsetY, XYMenuViewImageHeight,
                      XYMenuViewImageHeight + XYMenuViewTitleHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (NSUInteger i = 0; i < _btnArr.count; i ++) {
        XYPlusMenuBtn *menuBtn = _btnArr[i];
        menuBtn.frame = [self btnFrameAtIndex:i];
    }
}


- (void)dismiss
{
    //关闭按钮旋转动画
    CABasicAnimation *rotateClose = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateClose.fromValue = @0;
    rotateClose.toValue = @(M_PI_4);
    rotateClose.duration = 0.2;
    [_closeBtn.layer addAnimation:rotateClose forKey:nil];
    [self dropAnimation];
    //菜单视图透明动画
    CABasicAnimation *opaque = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opaque.fromValue = @1.0;
    opaque.toValue = @0.0;
    opaque.duration = 0.5;
    [self.layer addAnimation:opaque forKey:nil];

    double delay = 0.4;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
#pragma mark 视图动画
/**
 *  菜单按钮上升动画
 */
- (void)riseAnimation
{
    NSUInteger columnCount = 3;
    NSUInteger rowCount = _btnArr.count / columnCount + (_btnArr.count%columnCount>0?1:0);

    for (NSUInteger index = 0; index < _btnArr.count; index++) {
        XYPlusMenuBtn *menuBtn = _btnArr[index];
        menuBtn.layer.opacity = 0;
        CGRect frame = [self btnFrameAtIndex:index];
//        NSUInteger rowIndex = index / columnCount;
//        NSUInteger columnIndex = index % columnCount;
        
        CGPoint fromPosition = CGPointMake(frame.origin.x + XYMenuViewImageHeight / 2.0,
                                           frame.origin.y +  2 * 200 + (XYMenuViewImageHeight + XYMenuViewTitleHeight) / 2.0);
        
        CGPoint toPosition = CGPointMake(frame.origin.x + XYMenuViewImageHeight / 2.0,
                                         frame.origin.y + (XYMenuViewImageHeight + XYMenuViewTitleHeight) / 2.0);
        
        double delayInSeconds = rowCount * XYMenuViewAnimationInterval;
        //CALayer动画
        CABasicAnimation *positionAnimation;
        positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.45f :1.2f :0.75f :1.0f];
        positionAnimation.duration = XYMenuViewAnimationTime;
        positionAnimation.beginTime = [menuBtn.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayInSeconds * index / 2;
        [positionAnimation setValue:[NSNumber numberWithUnsignedInteger:index] forKey:XYMenuViewRiseAnimationID];
        positionAnimation.delegate = self;
        
        [menuBtn.layer addAnimation:positionAnimation forKey:@"riseAnimation"];
    }
}
//菜单按钮下降动画
- (void)dropAnimation
{
    NSUInteger columnCount           = 3;
    NSUInteger rowCount              = _btnArr.count / columnCount + (_btnArr.count%columnCount>0?1:0);
    for (NSUInteger index            = _btnArr.count; index > 0; index --) {
    XYPlusMenuBtn *menuBtn           = _btnArr[index - 1];
    menuBtn.layer.opacity            = 0;
    CGRect frame                     = [self btnFrameAtIndex:index - 1];
    //        NSUInteger rowIndex = index / columnCount;
    //        NSUInteger columnIndex = index % columnCount;
    //终点：x不变，y等于初始位置y+400+按钮高度/2
    CGPoint toPosition               = CGPointMake(frame.origin.x + XYMenuViewImageHeight / 2.0,
                                         frame.origin.y +  2 * 200 + (XYMenuViewImageHeight + XYMenuViewTitleHeight) / 2.0);
        //起点：x不变，
    CGPoint fromPosition             = CGPointMake(frame.origin.x + XYMenuViewImageHeight / 2.0,
                                           frame.origin.y + (XYMenuViewImageHeight + XYMenuViewTitleHeight) / 2.0);

    double delayInSeconds            = rowCount * XYMenuViewAnimationInterval;
        //CALayer动画
        CABasicAnimation *positionAnimation;
    positionAnimation                = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue      = [NSValue valueWithCGPoint:fromPosition];
    positionAnimation.toValue        = [NSValue valueWithCGPoint:toPosition];
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1.5f :1.55f :1.2f :1.0f];
    positionAnimation.duration       = XYMenuViewAnimationTime;
    positionAnimation.beginTime      = [menuBtn.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayInSeconds * (6 - index) / 5;
        [positionAnimation setValue:[NSNumber numberWithUnsignedInteger:(index - 1)] forKey:XYMenuViewdropAnimationID];
    positionAnimation.delegate       = self;
        
        [menuBtn.layer addAnimation:positionAnimation forKey:@"dropAnimation"];
    }
}

//按钮点击动画
- (void)buttonTapped:(XYPlusMenuBtn *)btn
{
    CAAnimationGroup *group     = [CAAnimationGroup animation];
    //scale动画
    CABasicAnimation *scaleAni  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CGRect originalFrame        = btn.imageView.frame;
    originalFrame.size          = CGSizeMake(originalFrame.size.width * 1.2,
                                            originalFrame.size.height * 1.2);

    scaleAni.fromValue          = @1.0;
    scaleAni.toValue            = @3.0;

    //透明度动画
    CABasicAnimation *opaqueAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opaqueAni.fromValue         = [NSNumber numberWithFloat:1.0];
    opaqueAni.toValue           = [NSNumber numberWithFloat:0.1];

    group.duration              = 0.7;
    group.animations            = @[scaleAni, opaqueAni];
    [btn.imageView.layer addAnimation:group forKey:nil];
}
//动画开始
- (void)animationDidStart:(CAAnimation *)anim
{
    NSUInteger columnCount = 3;
    if([anim valueForKey:XYMenuViewRiseAnimationID]) {
        NSUInteger index    = [[anim valueForKey:XYMenuViewRiseAnimationID] unsignedIntegerValue];
        UIView *view        = _btnArr[index];
        CGRect frame        = [self btnFrameAtIndex:index];
//        layer的位置
        CGPoint toPosition  = CGPointMake(frame.origin.x + XYMenuViewImageHeight / 2.0, frame.origin.y + (XYMenuViewImageHeight + XYMenuViewTitleHeight) / 2.0);
        CGFloat toAlpha     = 1.0;

        view.layer.position = toPosition;
        view.layer.opacity  = toAlpha;
        
    }
    else if([anim valueForKey:XYMenuViewdropAnimationID]) {
        NSUInteger index    = [[anim valueForKey:XYMenuViewdropAnimationID] unsignedIntegerValue];

        UIView *view        = _btnArr[index];
        CGRect frame        = [self btnFrameAtIndex:index];
        CGPoint toPosition  = CGPointMake(frame.origin.x + XYMenuViewImageHeight / 2.0,
                                         frame.origin.y + 2 * 200 + (XYMenuViewImageHeight + XYMenuViewTitleHeight) / 2.0);
        CGFloat toAlpha     = 1.0;

        view.layer.position = toPosition;
        view.layer.opacity  = toAlpha;
    }
}

- (void)show
{
    //关闭按钮旋转动画
    CABasicAnimation *rotateClose = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateClose.toValue = @0;
    rotateClose.fromValue = @(-M_PI_4);
    rotateClose.duration = XYMenuViewAnimationTime;
    [_closeBtn.layer addAnimation:rotateClose forKey:nil];
    //菜单视图透明动画
    CABasicAnimation *opaque = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opaque.fromValue = @0.0;
    opaque.toValue = @1.0;
    opaque.duration = XYMenuViewAnimationTime;
    [self.layer addAnimation:opaque forKey:nil];
    
    [self riseAnimation];
}


@end
