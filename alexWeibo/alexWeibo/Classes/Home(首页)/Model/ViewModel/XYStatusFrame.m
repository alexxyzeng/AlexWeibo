//
//  XYStatusFrame.m
//  xiayao
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYUser.h"


//TODO: 视图模型
@implementation XYStatusFrame

- (void)setStatus:(XYStatus *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {//判断是否有转发微博
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        //  根据转发微博frame计算工具条y
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = XYScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = XYStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + XYStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:XYNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) { //  是VIP用户
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + XYStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    

    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + XYStatusCellMargin;
    
    CGFloat textW = XYScreenW - 2 * XYStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:XYTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + XYStatusCellMargin;
    
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = XYStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + XYStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + XYStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = XYScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}
#pragma mark - 根据图片数计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    //!!!:
//    // 获取总列数
//    int cols = count == 4? 2 : 3;
//    // 获取总行数 = (总个数 - 1) / 总列数 + 1
//    int rols = (count - 1) / cols + 1;
//    CGFloat photoWH = 70;
//    CGFloat w = cols * photoWH + (cols - 1) * XYStatusCellMargin;
//    CGFloat h = rols * photoWH + (rols - 1) * XYStatusCellMargin;
//    
//    
//    return CGSizeMake(w, h);
    // 获取列数（如果图片为4张，为2列；不然为3列）
    int cols = count == 4 ? 2 : 3;
    //  获取行数
    int rows = (count - 1) / cols + 1;
    //  设置统一的图片尺寸为70
    CGFloat photoWH = 70;
    //  根据单一图片尺寸和间距计算整体图片尺寸
    CGFloat w = cols * photoWH + (cols - 1) * XYStatusCellMargin;
    CGFloat h = rows * photoWH + (rows - 1) * XYStatusCellMargin;
    //  返回尺寸值
    return CGSizeMake(w, h);
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = XYStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    //TODO: 根据字体尺寸获得大小的方法！！！已经被sizeWithAttributes取代
    CGSize nameSize = [_status.retweetName sizeWithFont:XYNameFont];
    //  根据坐标和大小计算frame
    _retweetNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + XYStatusCellMargin;
    
    CGFloat textW = XYScreenW - 2 * XYStatusCellMargin;
    // 注意：一定要是转发微博的正文
    //FIXME: 已经被boundingRectWithSize:options:attributes:context替代，用的是NSRect和NSSize
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:XYTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
//    CGSize textSize = _status.retweeted_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + XYStatusCellMargin;
    // 配图
    int count = (int)_status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = XYStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + XYStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + XYStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = XYScreenW;
   
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);

}
@end
