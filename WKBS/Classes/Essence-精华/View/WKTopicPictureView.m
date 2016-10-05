//
//  WKTopicPictureView.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/4.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTopicPictureView.h"
#import <DALabeledCircularProgressView.h>
#import "WKTopic.h"
#import <UIImageView+WebCache.h>
#import "WKSeeBigViewController.h"

@interface WKTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation WKTopicPictureView

+ (instancetype)pictureView {

    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;

}

- (void)awakeFromNib {

    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    //点击图片查看大图
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBig)];
    [self.imageView addGestureRecognizer:tap];
}


- (void)seeBig {

    WKSeeBigViewController *seeBig = [[WKSeeBigViewController alloc]init];
    seeBig.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil];

}

- (void)setTopic:(WKTopic *)topic {

    _topic = topic;

    //图片赋值
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    //判断是否为gif
    self.gifView.hidden = !topic.is_gif;
    
    //判断是否为大图
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
    }else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = NO;
    }
    
}

@end
