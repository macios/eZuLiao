//
//  NSDate+HUDateTimeDifference.m
//  LoveDemo
//
//  Created by 成都千锋 on 15/8/4.
//  Copyright (c) 2015年 CD. All rights reserved.
//

#import "NSDate+HUDateTimeDifference.h"

@implementation NSDate (HUDateTimeDifference)
+(NSString *)timeDifferenceWithMainDate:(NSString *)mainDateStr minusDate:(NSString *)minusDateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate*mainDate = [dm dateFromString:mainDateStr];
    NSDate*minusDate=[dm dateFromString:minusDateStr];
    //    long dd = (long)[mainDate timeIntervalSince1970] - [minusDate timeIntervalSince1970];
    long dd=[mainDate timeIntervalSinceDate:minusDate];
    long day=dd/86400;
    float hourF=(dd/86400.0-day)*24;
    int hour=(int)hourF;
    int minute=((dd/86400.0-day)*24-hour)*60;
    NSString *timeString=[NSString stringWithFormat:@"%ld天%d小时%d分",day,hour,minute];
    return timeString;
}
@end
