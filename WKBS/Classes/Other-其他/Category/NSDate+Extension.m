//
//  NSDate+Extension.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/3.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isThisYear {

    //获取到日历对象
    NSCalendar *calendar = [NSCalendar calendar];
    
    //判断是否为同一年
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return selfYear == nowYear;
    

}

@end
