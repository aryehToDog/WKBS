//
//  WKCommentSectionHeader.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/6.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCommentSectionHeader.h"

@implementation WKCommentSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = WKCommonBgColor;
        self.textLabel.textColor = [UIColor darkGrayColor];
        
    }
    return self;

}

- (void)layoutSubviews {

    [super layoutSubviews];

    self.textLabel.font = [UIFont systemFontOfSize:14];
}

@end
