//
//  UIImageView+WKExtension.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/6.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "UIImageView+WKExtension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (WKExtension)

- (void)setHeader: (NSString *)url {

    UIImage *placeHolder = [UIImage circleImage:@"defaultUserIcon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      
        if (image == nil) return ;
        
        self.image = [image circleImage];
        
    }];

}

@end
