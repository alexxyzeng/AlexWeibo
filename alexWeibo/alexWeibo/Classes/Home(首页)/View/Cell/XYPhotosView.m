//
//  XYPhotosView.m
//  xiayao
//
//  Created by apple on 15-3-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "XYPhotosView.h"
#import "XYPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "XYPhotoView.h"

@implementation XYPhotosView
//!!!: 图片浏览器的使用，图片的单击事件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        
        // 添加9个子控件
    
        [self setUpAllChildView];

    }
    return self;
}


// 添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {

//        XYPhotoView *imageV = [[XYPhotoView alloc] init];
//       
//        imageV.tag = i;
//        // 添加点按手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//        [imageV addGestureRecognizer:tap];
//        
//        [self addSubview:imageV];
        XYPhotoView *imgView = [[XYPhotoView alloc] init];
        imgView.tag = i;
        //添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imgView addGestureRecognizer:tap];
        [self addSubview:imgView];
    }
}

#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    //tap.view 添加点按手势的那个view，在这里也就是点按的imageView
    UIImageView *tapView = (UIImageView *)tap.view;
    // XYPhoto -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (XYPhoto *photo in _pic_urls) {
        MJPhoto *p = [[MJPhoto alloc] init];
        //  获取URL的绝对字符串
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        //  替换字符串中的部分字符
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    
    //创建图片浏览器
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    //获取图片浏览器的图片对象
    brower.photos = arrM;
    //根据tag获取当前图片的index
    brower.currentPhotoIndex = tapView.tag;
    //显示图片浏览器
    [brower show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    // 4
    _pic_urls = pic_urls;
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        XYPhotoView *imageV = self.subviews[i];
        
        if (i < _pic_urls.count) { // 显示
            imageV.hidden = NO;

            // 获取XYPhoto模型
            XYPhoto *photo = _pic_urls[i];
            
            imageV.photo = photo;
            
        }else{
            imageV.hidden = YES;
        }
        
    }
    
}

// 计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
    
    
}
@end
