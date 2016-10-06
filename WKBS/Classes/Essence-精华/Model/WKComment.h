//
//  WKComment.h
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/3.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WKUser;

@interface WKComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 评论内容 */
@property (nonatomic,copy)NSString *content;
/** User模型 */
@property (nonatomic,strong)WKUser *user;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

@end
