//
//  WKMeCell.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKMeCell.h"

@implementation WKMeCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        //箭头指示器
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    
    return self;

}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    if (self.imageView == nil) {
        return;
    }
    self.imageView.wk_y = WKSmallMargin;
    self.imageView.wk_height = self.wk_height - 2 * WKSmallMargin;
    
    self.textLabel.wk_x = CGRectGetMaxX(self.imageView.frame) + WKMargin;
    
}


@end
