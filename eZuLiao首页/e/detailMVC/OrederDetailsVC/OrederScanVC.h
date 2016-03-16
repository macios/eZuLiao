
#import <UIKit/UIKit.h>

@interface OrederScanVC : UIViewController
@property(nonatomic,copy)NSString *name;//预约客户名
@property(nonatomic,copy)NSString *no;//预约客户电话
@property(nonatomic,copy)NSString *project;//预约项目
@property(nonatomic,copy)NSString *time;//预约时间
@property(nonatomic,copy)NSString *location;//预约地址
@property(nonatomic,copy)NSString *price;//预约总价
@property(nonatomic,copy)NSString *sex;//预约优先技师
@property(nonatomic,copy)NSString *count;//预约数量
@property(nonatomic,copy)NSString *comment;//用户备注
@property(nonatomic,strong)NSString *barrel;//桶1 e足疗；0 自家的
@end
