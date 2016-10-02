//
//  WKTopic.h
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/2.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKTopic : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

@end
