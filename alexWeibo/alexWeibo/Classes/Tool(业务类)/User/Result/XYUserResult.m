//
//  XYUserResult.m
//  xiayao
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYUserResult.h"

@implementation XYUserResult

- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totoalCount
{
    return self.messageCount + _status + _follower;
}

@end
