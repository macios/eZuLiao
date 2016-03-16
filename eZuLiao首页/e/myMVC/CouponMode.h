//
//  CouponMode.h
//  eZuLiao首页
//
//  Created by 成都千锋 on 15/8/19.
//  Copyright (c) 2015年 achu. All rights reserved.
//

#import <Foundation/Foundation.h>
//"code" : "U9PU3KZJ",
//"end_time" : 1454428798,
//"generate_time" : "1438615493",
//"id" : "9115",
//"limit" : "0",
//"num_limit" : "0",
//"" : "0",
//"start_time" : "1438531200",
//"status" : "0",
//"title" : "新手礼",
//"uid" : "4753",
//"value" : "30"
@interface CouponMode : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,assign)int end_time;
@property(nonatomic,copy)NSString *generate_time;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *limit;
@property(nonatomic,copy)NSString *num_limit;
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *start_time;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *value;
@end
