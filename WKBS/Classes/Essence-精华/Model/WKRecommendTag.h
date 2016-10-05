//
//  WKRecommendTag.h
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/5.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKRecommendTag : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
