
#import "MyBackBut.h"

@implementation MyBackBut

+(void)creatBackByTarget:(id)target action:(SEL)action showOnView:(UIView *)view;
{
    UIButton *backBut=[UIButton buttonWithType:UIButtonTypeCustom];
    backBut.center=CGPointMake(35, 44);
    backBut.bounds=CGRectMake(0, 0, 60, 40);
    [backBut setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBut addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBut];

}

@end
