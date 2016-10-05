//
//  UIImage+WKExtension.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/6.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "UIImage+WKExtension.h"

@implementation UIImage (WKExtension)
- (instancetype)circleImage {
    
    //获取图片上下文
    UIGraphicsBeginImageContext(self.size);
    //开启上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    //渲染
    [self drawInRect:rect];
    
    //获取新的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (instancetype)circleImage:(NSString *)name {

    return [[self imageNamed:name] circleImage];

}

@end
