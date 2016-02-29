//
//  XYStatusCell.m
//  xiayao
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYStatusCell.h"

#import "XYOriginalView.h"
#import "XYRetweetView.h"
#import "XYStatusToolBar.h"

#import "XYStatusFrame.h"
#import "XYStatus.h"

@interface XYStatusCell ()
/**
 *  原创微博视图
 */
@property (nonatomic, weak) XYOriginalView  *originalView;
/**
 *  转发微博视图
 */
@property (nonatomic, weak) XYRetweetView   *retweetView                 ;
/**
 *  微博工具条
 */
@property (nonatomic, weak) XYStatusToolBar *toolBar;

@end

@implementation XYStatusCell


#pragma mark cell初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
    
}
// 添加所有子控件
- (void)setUpAllChildView
{
    // 原创微博
    XYOriginalView *originalView = [[XYOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 转发微博
    XYRetweetView *retweetView = [[XYRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具条
    XYStatusToolBar *toolBar = [[XYStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        
    }
    
    return cell;
}

- (void)setStatusF:(XYStatusFrame *)statusF
{
    _statusF = statusF;
    
    // 设置原创微博frame
    _originalView.frame = statusF.originalViewFrame;
    _originalView.statusF = statusF;
    
    if (statusF.status.retweeted_status) {
        
        // 设置转发微博frame
        _retweetView.frame = statusF.retweetViewFrame;
        _retweetView.statusF = statusF;
        _retweetView.hidden = NO;
    }else{
        _retweetView.hidden = YES;
    }
    
    // 设置工具条frame
    _toolBar.frame = statusF.toolBarFrame;
    _toolBar.status = statusF.status;
}


@end
