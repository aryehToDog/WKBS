//
//  WKTopic.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/2.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTopic.h"

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

@implementation WKTopic

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

@end
