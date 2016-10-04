//
//  WKTopicCell.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/2.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTopicCell.h"
#import <UIImageView+WebCache.h>
#import "WKTopic.h"
#import "WKUser.h"
#import "WKComment.h"
@interface WKTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 评论view */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/** 最新评论label */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;


@end

@implementation WKTopicCell
- (IBAction)more:(UIButton *)sender {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //添加按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:nil];
    [alertVc addAction:action2];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:action3];
    
    [self.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置cell的背景颜色
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}

- (void)setTopic:(WKTopic *)topic {

    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    [self setupButton:self.dingButton numble:topic.ding title:@"顶"];
    [self setupButton:self.caiButton numble:topic.ding title:@"踩"];
    [self setupButton:self.repostButton numble:topic.ding title:@"转发"];
    [self setupButton:self.commentButton numble:topic.ding title:@"评论"];
    
    //设置热门评论的隐藏与显示
    WKComment *cmt = [topic.top_cmt lastObject];
    if (topic.top_cmt.count) {
    
        self.topCmtView.hidden = NO;
        
        NSString *username = cmt.user.username;
        NSString *content = cmt.content;
        
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    }else {
        self.topCmtView.hidden = YES;
    }
    
    
}


- (void)setupButton: (UIButton *)button numble: (NSUInteger)numble title: (NSString *)title {

    if (numble > 10000) {
        
        [button setTitle:[NSString stringWithFormat:@"%.1f万",numble / 10000.0] forState:UIControlStateNormal];
        
    }else if (numble > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd",numble] forState:UIControlStateNormal];
        
    }else {
        [button setTitle:title forState:UIControlStateNormal];
        
    }

}


/** 
 *   对cell的内部frame进行从新赋值
 */

- (void)setFrame:(CGRect)frame {

    frame.size.height -= WKMargin;
    frame.origin.y += WKMargin;
    
    [super setFrame:frame];
    

}

@end
