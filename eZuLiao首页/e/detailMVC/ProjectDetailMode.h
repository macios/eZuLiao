//
//  ProjectDetailMode.h
//  eZuLiao首页
//
//  Created by 成都千锋 on 15/8/20.
//  Copyright (c) 2015年 achu. All rights reserved.
//

#import <Foundation/Foundation.h>
//"content" : "态度很好，技术不错",
//"id" : "216",
//"next_same_art" : "0",
//"order_number" : "291034",
//"phone" : "181****8769",
//"reply" : null,
//"star" : "5",
//"time" : "1435634852",
//"typeid" : "1",
//"uid" : "3572"
@interface ProjectDetailMode : NSObject
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *next_same_art;
@property(nonatomic,copy)NSString *order_number;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *reply;
@property(nonatomic,copy)NSString *star;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *typeid;
@property(nonatomic,copy)NSString *uid;
@end
