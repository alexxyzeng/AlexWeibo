//
//  XYComposeViewController.m
//  xiayao
//
//  Created by apple on 15-3-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYComposeViewController.h"
#import "XYComposeView.h"
#import "XYComposeToolBar.h"
#import "XYComposePhotosView.h"

@interface XYComposeViewController () <UITextViewDelegate>
/**
 *  文本编辑视图
 */
@property (nonatomic, weak) XYComposeView *composeView;
@property (nonatomic, weak) XYComposeToolBar *toolBar;
@property (nonatomic, weak) XYComposePhotosView *photosView;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation XYComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setUpNavgationBar];
    [self setUpComposeView];
    [self setUpToolBar];
    [self setUpPhotosView];
}
#pragma mark 设置导航条
- (void)setUpNavgationBar
{
    self.title = @"发微博";
    // 取消按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    // 发送按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

// 发送微博
- (void)compose
{
    
}
// 离开发送微博视图控制器
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 添加textView
- (void)setUpComposeView
{
    XYComposeView *composeView = [[XYComposeView alloc] initWithFrame:self.view.bounds];
    _composeView = composeView;
    _composeView.placeholder = @"分享新鲜事";
    _composeView.alwaysBounceVertical = YES;
    [self.view addSubview:composeView];
    //监听输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    //设置代理管理拖拽
    _composeView.delegate = self;
}
//开始滚动就停止编辑
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)textChange
{
    if (_composeView.text.length) {
        _composeView.placeholderHidden = NO;
    } else {
        _composeView.placeholderHidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_composeView becomeFirstResponder];
}
// 添加相册视图
- (void)setUpPhotosView
{
    XYComposePhotosView *photosView = [[XYComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    _photosView = photosView;
    [_composeView addSubview:photosView];
}

#pragma mark - 键盘的Frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note
{
    
    // 获取键盘弹出的动画时间
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform =  CGAffineTransformIdentity;
        }];
    }else{ // 弹出键盘
        // 工具条往上移动258
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
    
}

- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    XYComposeToolBar *toolBar = [[XYComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}

#pragma mark - 点击工具条按钮的时候调用
- (void)composeToolBar:(XYComposeToolBar *)toolBar didClickBtn:(NSInteger)index
{
    
    if (index == 0) { // 点击相册
        // 弹出系统的相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置相册类型,相册集
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
}
// 注销通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
