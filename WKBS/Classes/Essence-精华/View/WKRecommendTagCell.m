//
//  WKRecommendTagCell.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/5.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKRecommendTagCell.h"
#import "WKRecommendTag.h"
#import <UIImageView+WebCache.h>
@interface WKRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation WKRecommendTagCell

- (void)setRecommendTag:(WKRecommendTag *)recommendTag {

    _recommendTag = recommendTag;
    
    [self.imageListView setHeader:recommendTag.image_list];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    if (recommendTag.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }

}

- (void)setFrame:(CGRect)frame {

    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
