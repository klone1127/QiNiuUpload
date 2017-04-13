//
//  NSDate+Common.m
//  QiNiuUpload
//
//  Created by jgrm on 2017/4/13.
//  Copyright © 2017年 klone1127. All rights reserved.
//

#import "NSDate+Common.h"

@implementation NSDate (Common)

/**
 当前时间(东八区时间)
 
 @return
 */
+ (NSDate *)getCurrentTime {
    NSDate *time = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger inteval = [zone secondsFromGMTForDate:time];
    NSDate *localTime = [time dateByAddingTimeInterval:inteval];
    return localTime;
}

@end
