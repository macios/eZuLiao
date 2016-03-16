

#import <Foundation/Foundation.h>
//"admin_remarks" : null,
//"artificer_id" : null,
//"barrel" : "0",
//"categary_name" : "按摩",
//"city" : "成都",
//"community" : "考虑考虑啊啊啊",
//"coupon_price" : 0,
//"current_price" : "299",
//"device" : "2",
//"from" : null,
//"has_comment" : false,
//"house_number" : "噜噜噜",
//"id" : "8524",
//"invite_code" : null,
//"is_with_driver" : "0",
//"is_zuliao" : 0,
//"minute" : "90",
//"nickname" : "123",
//"nightfee" : "0",
//"num" : "1",
//"order_day" : "1439481600",
//"order_hour" : "16",
//"order_minute" : "30",
//"order_number" : "691144",
//"pay_type" : "offline",
//"payed" : "0",
//"phone" : "18123239963",
//"product_title" : "草本精油按摩 90分钟",
//"remarks" : "",
//"sex" : "0",
//"status" : "2",
//"submit_time" : "1439391182",
//"time" : "周五 2015-08-14 16:30",
//"total_price" : "299",
//"type_name" : "草本精油按摩",
//"typeid" : "3",
//"uid" : "4753"
@interface OrderMode : NSObject
@property(nonatomic,copy)NSString *type_name;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *total_price;
@property(nonatomic,copy)NSString *minute;
@property(nonatomic,copy)NSString *order_number;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *community;
@property(nonatomic,copy)NSString *house_number;
@property(nonatomic,copy)NSString *product_title;
@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *current_price;
@property(nonatomic,copy)NSString *nightfee;
@property(nonatomic,assign)BOOL has_comment;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *remarks;
@property(nonatomic,copy)NSString *pay_type;
@property(nonatomic,copy)NSString *coupon_price;
@property(nonatomic,copy)NSString *typeid;
@end
