//
//  UIBarButtonItem+WKExtension.h
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WKExtension)
+ (instancetype)itemWithImage: (NSString *)image highlighted: (NSString *)highlighted target: (id)target action: (SEL)action;
@end
