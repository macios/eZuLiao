
//"content" : [
//             {
//                 "categary_id" : "1",
//                 "desc" : "有效调节内分泌，改善黑色素堆积",
//                 "id" : "1",
//                 "is_zuliao" : 1,
//                 "min_price" : "99",
//                 "name" : "玫瑰足疗"
//             },

#import <Foundation/Foundation.h>

@interface ReserceMode : NSObject
@property(nonatomic,copy)NSString *categary_id;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *is_zuliao;
@property(nonatomic,copy)NSString *min_price;
@property(nonatomic,copy)NSString *name;
@end
