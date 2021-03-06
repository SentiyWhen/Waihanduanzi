//
//  UIImage+Image.h
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/6.
//  Copyright © 2018年 zww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (UIImage *)imageOriginalWithName: (NSString *)imageName;

- (instancetype)xmg_circleImage;

+ (instancetype)xmg_circleImageNamed:(NSString *)name;
@end
