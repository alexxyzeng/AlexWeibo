//
//  XYTabBarController.m
//  xiayao
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYTabBarController.h"
#import "UIImage+Image.h"
#import "XYTabBar.h"

#import "XYHomeViewController.h"
#import "XYMessageViewController.h"
#import "XYDiscoverViewController.h"
#import "XYProfileViewController.h"

#import "XYNavigationController.h"

#import "XYUserTool.h"
#import "XYUserResult.h"

#import "XYComposeViewController.h"

@interface XYTabBarController ()<XYTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) XYHomeViewController *home;

@property (nonatomic, weak) XYMessageViewController *message;

@property (nonatomic, weak) XYProfileViewController *profile;

@end

@implementation XYTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self setUpAllChildViewController];

    // 自定义tabBar
    [self setUpTabBar];
    
    // 每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
}

// 请求未读数
- (void)requestUnread
{


    // 请求微博的未读数
    [XYUserTool unreadWithSuccess:^(XYUserResult *result) {

        // 设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        // 设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        // 设置应用程序所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
        
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
    XYTabBar *tabBar = [[XYTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    [self.view addSubview:tabBar];
    
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
}


#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(XYTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) { // 点击首页，刷新
        [_home refresh];
    }
    
    self.selectedIndex = index;
}

// 点击加号按钮的时候调用
- (void)tabBarDidClickPlusButton:(XYTabBar *)tabBar
{
    // 创建发送微博控制器
    XYComposeViewController *composeVc = [[XYComposeViewController alloc] init];
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    
}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{
    // 首页
    XYHomeViewController *home = [[XYHomeViewController alloc] init];
    
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    
    
    // 消息
    XYMessageViewController *message = [[XYMessageViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
    
    // 发现
    XYDiscoverViewController *discover = [[XYDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];

    

    // 我
    XYProfileViewController *profile = [[XYProfileViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;
}
// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
//    // navigationItem模型
//    vc.navigationItem.title = title;
//    
//    // 设置子控件对应tabBarItem的模型属性
//    vc.tabBarItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
}


@end
