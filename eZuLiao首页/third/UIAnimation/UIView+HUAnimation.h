
#import <UIKit/UIKit.h>
/*UIView+HUAnimation以后所有的UIView都可以这个类*/
@interface UIView (HUAnimation)
-(void)hu_setAnimationWithType:(NSString *)type subType:(NSString *)subtype andDuration:(CGFloat)duration;
@end
