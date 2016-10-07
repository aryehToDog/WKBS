//
//  UIView+Frame.m
//  传智微博
//
//  Created by MK on 15/3/1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setWk_x:(CGFloat)wk_x
{
    CGRect frame = self.frame;
    frame.origin.x = wk_x;
    self.frame = frame;
}

- (void)setWk_y:(CGFloat)wk_y
{
    CGRect frame = self.frame;
    frame.origin.y = wk_y;
    self.frame = frame;
}

- (CGFloat)wk_x
{
    return self.frame.origin.x;
}

- (CGFloat)wk_y
{
    return self.frame.origin.y;
}

- (void)setWk_centerX:(CGFloat)wk_centerX
{
    CGPoint center = self.center;
    center.x = wk_centerX;
    self.center = center;
}

- (CGFloat)wk_centerX
{
    return self.center.x;
}

- (void)setWk_centerY:(CGFloat)wk_centerY
{
    CGPoint center = self.center;
    center.y = wk_centerY;
    self.center = center;
}

- (CGFloat)wk_centerY
{
    return self.center.y;
}

- (void)setWk_width:(CGFloat)wk_width
{
    CGRect frame = self.frame;
    frame.size.width = wk_width;
    self.frame = frame;
}

- (void)setWk_height:(CGFloat)wk_height
{
    CGRect frame = self.frame;
    frame.size.height = wk_height;
    self.frame = frame;
}

- (CGFloat)wk_height
{
    return self.frame.size.height;
}

- (CGFloat)wk_width
{
    return self.frame.size.width;
}

- (void)setWk_size:(CGSize)wk_size
{
    CGRect frame = self.frame;
    frame.size = wk_size;
    self.frame = frame;
}

- (CGSize)wk_size
{
    return self.frame.size;
}

- (void)setWk_origin:(CGPoint)wk_origin
{
    CGRect frame = self.frame;
    frame.origin = wk_origin;
    self.frame = frame;
}

- (CGPoint)wk_origin
{
    return self.frame.origin;
}

- (BOOL)intersectWithView:(UIView *)view {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    
    return CGRectIntersectsRect(selfRect, viewRect);
}

@end
