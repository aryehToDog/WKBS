//
//  WKCommentCell.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/6.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCommentCell.h"
#import "WKComment.h"
#import "WKUser.h"
@interface WKCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end

@implementation WKCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}


- (void)setComment:(WKComment *)comment {

    _comment = comment;
    
    //设置头像
    [self.profileImageView setHeader:comment.user.profile_image];
    //设置名字
    self.usernameLabel.text = comment.user.username;
    //设置性别
    NSString *sexImageName = [comment.user.sex isEqualToString:@"m"] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image = [UIImage imageNamed:sexImageName];
    //设置内容文字
    self.contentLabel.text = comment.content;
    //设置点赞数
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    //设置音频的显示跟隐藏
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else {
        self.voiceButton.hidden = YES;
    }
    
}


@end
