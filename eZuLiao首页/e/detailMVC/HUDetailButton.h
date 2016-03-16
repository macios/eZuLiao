

#import <UIKit/UIKit.h>

@interface HUDetailButton : UIButton
+(UIButton *)creatButtonCeter:(CGPoint)ceter andTarget:(id)target andAction:(SEL)action andUpLabelStr:(NSString *)upStr andDownLabelStr:(NSString *)downStr showLabelView:(UIView *)view;
@end
