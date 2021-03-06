//
//  XMGTopicPictureView.m
//  Whdz
//
//  Created by 张文文 on 2018/8/21.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGSeeBigPictureViewController.h"

@interface XMGTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@end

@implementation XMGTopicPictureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

/**
 *  查看大图
 */
- (void)seeBigPicture
{
    XMGSeeBigPictureViewController *vc = [[XMGSeeBigPictureViewController alloc] init];
    //传入模型
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
    //    [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)setTopic:(XMGTopic *)topic {
    _topic = topic;
    // 设置图片
    [self.imageView xmg_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil];
    
    //gif
    self.gifView.hidden = !topic.is_gif;
    
    // 点击查看大图
    if (topic.isBigPicture) { // 超长图
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
        // 处理超长图片的大小
        if (self.imageView.image) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
        
    }
    
}

@end
