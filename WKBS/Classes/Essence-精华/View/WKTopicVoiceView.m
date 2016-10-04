//
//  WKTopicVoiceView.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/4.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTopicVoiceView.h"
#import "WKTopic.h"
#import <UIImageView+WebCache.h>
@interface WKTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation WKTopicVoiceView

+ (instancetype)voiceView {
    
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
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd : %02zd",min,sec];
    
}

@end
