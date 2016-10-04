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

/** 评论内容 */
@property (nonatomic,copy)NSString *content;
/** User模型 */
@property (nonatomic,strong)WKUser *user;


@end
