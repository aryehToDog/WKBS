//
//  WKTopic.h
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/2.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    /** 全部 */
    WKTopicTypeAll = 1,
    /** 图片 */
    WKTopicTypePicture = 10,
    /** 视频 */
    WKTopicTypeVideo = 41,
    /** 音频 */
    WKTopicTypeVoice = 31,
    /** 段子 */
    WKTopicTypeWord = 29,
    
    
}WKTopicType;


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
/** cmt模型 */
@property (nonatomic, strong) NSArray *top_cmt;
/** 图片的真实宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的真实高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;
/** 是否为gif动画图片 */
@property (nonatomic, assign) BOOL is_gif;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;


/** 额外添加的属性 */
/**  返回的行高*/
@property (nonatomic, assign) CGFloat cellHight;
/** 帖子类型 */
@property (nonatomic,assign)WKTopicType type;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentF;

@end
