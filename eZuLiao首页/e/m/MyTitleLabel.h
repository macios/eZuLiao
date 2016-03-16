

#import <UIKit/UIKit.h>

@interface MyTitleLabel : UILabel
+(UILabel *)creatLabel:(CGPoint)ceter withBounds:(CGRect)bounds withText:(NSString *)text  withFontOfSize:(int)size;
+(UILabel *)creatBigLabel:(CGPoint)ceter withBounds:(CGRect)bounds withText:(NSString *)text  withFontOfSize:(int)size;
/**
 *  创建顶部标题，位置大小已在里面
 *
 *  @param text <#text description#>
 *  @param view <#view description#>
 */
+(void)creatLabelByText:(NSString *)text showOnView:(UIView *)view;
@end
