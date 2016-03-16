//
//  NSDate+HUDateTimeDifference.h
//  LoveDemo
//
//  Created by 成都千锋 on 15/8/4.
//  Copyright (c) 2015年 CD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HUDateTimeDifference)
+(NSString *)timeDifferenceWithMainDate:(NSString *)mainDateStr minusDate:(NSString *)minusDateStr;
@end
