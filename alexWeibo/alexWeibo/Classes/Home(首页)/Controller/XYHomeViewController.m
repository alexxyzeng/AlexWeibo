//
//  XYHomeViewController.m
//  传智微博
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYHomeViewController.h"

#import "UIBarButtonItem+Item.h"
#import "XYTitleButton.h"

#import "XYPopMenu.h"
#import "XYCover.h"
#import "XYOneViewController.h"


#import "XYStatus.h"
#import "XYUser.h"


#import "MJExtension.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh.h"


#import "XYStatusTool.h"

@interface XYHomeViewController ()<XYCoverDelegate>

@property (nonatomic, weak) XYTitleButton *titleButton;

@property (nonatomic, strong) XYOneViewController *one;

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation XYHomeViewController



- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (XYOneViewController *)one
{
    if (_one == nil) {
        _one = [[XYOneViewController alloc] init];
    }
    
    return _one;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setUpNavgationBar];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
}

#pragma mark - 刷新最新的微博
- (void)refresh{
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
}

//  {:json字典 [:json数组

#pragma mark - 请求更多旧的微博
- (void)loadMoreStatus
{
    NSString *maxIdStr = nil;
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    // 请求更多的微博数据
    [XYStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 把数组中的元素添加进去
        [self.statuses addObjectsFromArray:statuses];
        
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}




#pragma mark - 请求最新的微博
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
        
        sinceId = [self.statuses[0] idstr];
    }
    
    [XYStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) { // 请求成功的Block
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的微博数插入到最前面
        [self.statuses insertObjects:statuses atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 设置导航条
- (void)setUpNavgationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    XYTitleButton *titleButton = [XYTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}
// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    // 弹出蒙板
    XYCover *cover = [XYCover show];
    cover.delegate = self;
    
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    XYPopMenu *menu = [XYPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
    
    
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(XYCover *)cover
{
    // 隐藏pop菜单
    [XYPopMenu hide];
    
    _titleButton.selected = NO;
    
}

- (void)friendsearch
{
    
}

- (void)pop
{
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 获取status模型
    XYStatus *status = self.statuses[indexPath.row];
    
    // 用户昵称
    cell.textLabel.text = status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.detailTextLabel.text = status.text;
    
    return cell;
}


@end
