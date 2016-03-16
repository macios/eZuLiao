
#import "UIView+HUAnimation.h"
//#import <QuartzCore/QuartzCore.h>

@implementation UIView (HUAnimation)
-(void)hu_setAnimationWithType:(NSString *)type subType:(NSString *)subtype andDuration:(CGFloat)duration
{
    //动画,定义对象
    CATransition *tra=[CATransition animation];
    //设置动画时间
    tra.duration=duration;
    //设置动画类型，默认父页缓慢消失@"cube"正方形@"cameraIris"圆形。优选法*0.618
    tra.type=type;
    //设置动画方向，默认从上到下
    tra.subtype=subtype;
    [self.layer addAnimation:tra forKey:nil];
}
@end
