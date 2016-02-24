//
//  XYStatusCell.h
//  xiayao
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYStatusFrame;
@interface XYStatusCell : UITableViewCell

@property (nonatomic, strong) XYStatusFrame *statusF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
