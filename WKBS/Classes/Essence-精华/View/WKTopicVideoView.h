//
//  WKTopicVideoView.h
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/4.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKTopic;
@interface WKTopicVideoView : UIView
/** topic模型 */
@property (nonatomic,strong)WKTopic *topic;

+ (instancetype)videoView;

@end
