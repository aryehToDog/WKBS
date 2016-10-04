//
//  WKTopicVideoView.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/4.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTopicVideoView.h"
#import "WKTopic.h"
#import <UIImageView+WebCache.h>

@interface WKTopicVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WKTopicVideoView

+ (instancetype)videoView {
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(WKTopic *)topic {

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger min = topic.videotime / 60;
    NSInteger sec = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd : %02zd",min,sec];

}


@end
