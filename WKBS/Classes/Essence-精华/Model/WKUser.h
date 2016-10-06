//
//  WKUser.h
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/3.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKUser : NSObject

/** 用户名 */
@property (nonatomic,copy)NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;

@end
