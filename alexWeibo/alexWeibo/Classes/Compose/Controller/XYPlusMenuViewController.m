//
//  XYPlusMenuViewController.m
//  
//
//  Created by xiayao on 16/2/27.
//
//

#import "XYPlusMenuViewController.h"
#import "XYPlusMenuView.h"
#import "XYComposeViewController.h"
#import "XYNavigationController.h"

@interface XYPlusMenuViewController () <XYPlusMenuViewDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) XYPlusMenuView *menuView;
@end

@implementation XYPlusMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    closeBtn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height -20);
    [closeBtn setImage:[UIImage imageNamed:@"compose_close"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"compose_close_highlighted"] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
//    XYPlusMenuView *menuView = [[XYPlusMenuView alloc] initWithFrame:self.view.bounds];
//    [menuView addSubview:closeBtn];
    [self.view addSubview:closeBtn];
    [self addSubViews];
}
- (void)addSubViews
{
    //添加菜单按钮
    _menuView = [[XYPlusMenuView alloc] initWithFrame:self.view.bounds];
    [_menuView addMenuBtnWithTitle:@"文字" icon:[UIImage imageNamed:@"tabbar_compose_idea"] target:self action:@selector(showComposeView) controlEvent:UIControlEventTouchUpInside];
    [_menuView addMenuBtnWithTitle:@"照片/视频" icon:[UIImage imageNamed:@"tabbar_compose_photo"] target:self action:@selector(didClickBtnAtIndex:) controlEvent:UIControlEventTouchUpInside];
    [_menuView addMenuBtnWithTitle:@"头条文章" icon:[UIImage imageNamed:@"tabbar_compose_headlines"] target:self action:@selector(didClickBtnAtIndex:) controlEvent:UIControlEventTouchUpInside];
    [_menuView addMenuBtnWithTitle:@"签到" icon:[UIImage imageNamed:@"tabbar_compose_lbs"] target:self action:nil controlEvent:UIControlEventTouchUpInside];
    [_menuView addMenuBtnWithTitle:@"点评" icon:[UIImage imageNamed:@"tabbar_compose_review" ] target:self action:nil controlEvent:UIControlEventTouchUpInside];
    [_menuView addMenuBtnWithTitle:@"更多" icon:[UIImage imageNamed:@"tabbar_compose_more" ] target:self action:nil controlEvent:UIControlEventTouchUpInside];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    closeBtn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height -20);
    [closeBtn setImage:[UIImage imageNamed:@"compose_close"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"compose_close_highlighted"] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //    XYPlusMenuView *menuView = [[XYPlusMenuView alloc] initWithFrame:self.view.bounds];
    //    [menuView addSubview:closeBtn];
    [_menuView addSubview:closeBtn];

    [self.view addSubview:_menuView];
    [_menuView show];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showComposeView
{
    
    
    XYComposeViewController *composeVc = [[XYComposeViewController alloc] init];
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark XYPlusMenuView代理方法
- (void)XYPlusMenuView:(XYPlusMenuView *)menuView didClickBtnAtIndex:(NSUInteger)index
{
    NSLog(@"%s", __func__);
    XYComposeViewController *composeVc = [[XYComposeViewController alloc] init];
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:nav animated:YES completion:nil];
    if (index == 0) {
        XYComposeViewController *composeVc = [[XYComposeViewController alloc] init];
        XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:composeVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    if (index == 1) {
        // 弹出系统的相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置相册类型,相册集
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
//        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
