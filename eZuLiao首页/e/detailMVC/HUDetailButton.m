

#import "HUDetailButton.h"

@implementation HUDetailButton
+(UIButton *)creatButtonCeter:(CGPoint)ceter andTarget:(id)target andAction:(SEL)action andUpLabelStr:(NSString *)upStr andDownLabelStr:(NSString *)downStr showLabelView:(UIView *)view
{
    
    UIButton *but=[UIButton buttonWithType:UIButtonTypeSystem];
    but.center=ceter;
    but.bounds=CGRectMake(0, 0, 50, 50);
    
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:but];
    
    UILabel *upLabel=[[UILabel alloc]init];
    upLabel.font=[UIFont systemFontOfSize:12];
    upLabel.text=upStr;
    upLabel.textAlignment=NSTextAlignmentCenter;
    upLabel.center=CGPointMake(but.center.x,CGRectGetMinY(but.frame)+18);
    upLabel.bounds=CGRectMake(0, 0, 50, 50);
    [view addSubview:upLabel];
    
    
    UILabel *downLabel=[[UILabel alloc]init];
    downLabel.font=[UIFont systemFontOfSize:11];
    downLabel.text=downStr;
    downLabel.textAlignment=NSTextAlignmentCenter;
    downLabel.textColor=[UIColor darkGrayColor];
    downLabel.center=CGPointMake(CGRectGetWidth(but.frame)/2,CGRectGetMinY(but.frame)+32);
    downLabel.bounds=CGRectMake(0, 0, 50, 50);
    [view addSubview:downLabel];
    
    if (downStr==nil) {
        upLabel.center=but.center;
    }
    
    return but;
}

@end
