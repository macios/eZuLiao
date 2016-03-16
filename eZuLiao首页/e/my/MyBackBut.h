

#import <UIKit/UIKit.h>


@interface MyBackBut : UIButton
/**
 *  创建标题头，位置大小已在里面
 *
 *  @param target <#target description#>
 *  @param action <#action description#>
 *  @param view   <#view description#>
 */
+(void)creatBackByTarget:(id)target action:(SEL)action showOnView:(UIView *)view;
@end
