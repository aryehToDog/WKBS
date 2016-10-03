//
//  NSCalendar+Extension.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/3.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "NSCalendar+Extension.h"

@implementation NSCalendar (Extension)

+ (instancetype)calendar {
    
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else {
    
        return [NSCalendar currentCalendar];
    }
}

@end
