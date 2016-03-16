
#import "MyVisual.h"

@implementation MyVisual

+(MyVisual *)creatVisualOnView:(UIView *)view
{
    MyVisual* _visualEffect = [[MyVisual alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    _visualEffect.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    _visualEffect.alpha = 1;
    [view addSubview:_visualEffect];
    return _visualEffect;
}

@end
