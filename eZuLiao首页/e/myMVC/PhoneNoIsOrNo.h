

#import <Foundation/Foundation.h>

@interface PhoneNoIsOrNo : NSObject
/**
 *  判断数字字符串是否为手机格式并返回提示信息，正确返回nil
 *
 *  @param mobile 手机号字符串
 *
 *  @return 提示错误信息
 */
+ (NSString *)valiMobile:(NSString *)mobile;
@end
