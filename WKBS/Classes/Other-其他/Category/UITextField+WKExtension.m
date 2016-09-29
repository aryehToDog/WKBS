//
//  UITextField+WKExtension.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/29.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "UITextField+WKExtension.h"

static NSString * const WKPlaceholderColorkey = @"placeholderLabel.textColor";

@implementation UITextField (WKExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor {

    //设置占位文字
    NSString *oldPlacehold = self.placeholder;
    NSString *placeHolde = @" ";
    placeHolde = oldPlacehold;
    
    if (placeholderColor == nil) {
        
        placeholderColor = WKColorA(0, 0, 0.0980392, 0.22);
    }
    
    [self setValue:placeholderColor forKeyPath:WKPlaceholderColorkey];

}

- (NSString *)placeholderColor {


   return [self valueForKeyPath:WKPlaceholderColorkey];

}

@end
