//
//  WKTopic.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/2.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTopic.h"
#import <MJExtension.h>
#import "WKComment.h"
#import "WKUser.h"
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

@implementation WKTopic

//转换成WKComment模型
//+ (NSDictionary *)mj_objectClassInArray {
//    
//    return @{
//             @"top_cmt" : [WKComment class]
//             };
//
//}
//
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//
//    return @{
//             @"small_image" : @"image0",
//             @"middle_image" : @"image1",
//             @"large_image" : @"image2",
//             @"ID" : @"id"
//             };
//
//}

+ (void)initialize {

    fmt_ = [[NSDateFormatter alloc]init];
    calendar_ = [NSCalendar calendar];
}

/** 
 *    根据返回的时间进行判断
 */

- (NSString *)created_at {

//    _created_at = @"2016-10-03 14:01:00";
    
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //字符串转日期
    NSDate *createdDate = [fmt_ dateFromString:_created_at];
    
    if (createdDate.isThisYear) {
        
        if ([calendar_ isDateInToday:createdDate]) {    //是否为今天
            
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *coms = [calendar_ components:unit fromDate:createdDate toDate:nowDate options:0];
            
            if (coms.hour >= 1) {     //大于一个小时
                return [NSString stringWithFormat:@"%zd分钟前",coms.hour];
            } else if (coms.minute >= 1) {   //大于一分钟
                return [NSString stringWithFormat:@"%zd分钟前",coms.minute];
            }else {                         //刚刚
                return @"刚刚";
            }
            
        }else if ([calendar_ isDateInYesterday:createdDate]){  //昨天
            fmt_.dateFormat = @"昨天 MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createdDate];
        } else {                                        //其他
        
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createdDate];
        }
        
    }else {             //不是今年
        
        return _created_at;
    
    }

}

/** 
 *   自定义返回的行高
 */
- (CGFloat)cellHight {

    if (_cellHight) return _cellHight;
    
    //图片的高度
    _cellHight = 18 + 35 + 15;
    
    //返回文字的大小
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * WKMargin;
    CGFloat height = MAXFLOAT;
    CGSize textMaxSize = CGSizeMake(width, height);
    //获取文字的最大高度
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15] } context:nil].size;
    _cellHight += textSize.height + WKMargin;
    
    //中间的内容
    if (self.type != WKTopicTypeWord) {
        
        //获取图片的真实高度
        CGFloat contentH = width * self.height / self.width;
        //判断如果是超长图片
        if (contentH >= [UIScreen mainScreen].bounds.size.height) {
            
            contentH = 200;
            self.bigPicture = YES;
        }
        
        //计算所在帖子View的frame
        self.contentF = CGRectMake(WKMargin, _cellHight, width, contentH);
        //计算cellHeight
        _cellHight += contentH + WKMargin;
        
    }
    
    //计算最热评论的高度
    if (self.top_cmt) {
        
        _cellHight += 19.5;
//        WKComment *cmt = [self.top_cmt lastObject];
        NSString *username = self.top_cmt.user.username;
        NSString *content = self.top_cmt.content;
        
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@",username,content];
        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13] } context:nil].size;
        _cellHight += topCmtContentSize.height + WKMargin;
    }
    
    //加底部的工具条
    _cellHight += 35 + WKMargin;
    
    return _cellHight;
}


@end
