

#import "MyTitleLabel.h"

@implementation MyTitleLabel

//+(UILabel *)creatLabel:(CGPoint)ceter withBounds:(CGRect)bounds withText:(NSString *)text  withFontOfSize:(int)size
//{
//    UILabel *label=[[UILabel alloc]init];
//    label.center=ceter;
//    label.bounds=bounds;
//    label.text=text;
//    label.textAlignment=NSTextAlignmentCenter;
//    label.font=[UIFont systemFontOfSize:size];
//    return label;
//}
+(void)creatLabelByText:(NSString *)text showOnView:(UIView *)view
{
    UILabel *label=[[UILabel alloc]init];
    label.center=CGPointMake(XWIDTH/2, 44);
    label.bounds=CGRectMake(0, 0, 150, 20);
    label.text=text;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:20];
    [view addSubview:label];
}
+(UILabel *)creatLabel:(CGPoint)ceter withBounds:(CGRect)bounds withText:(NSString *)text  withFontOfSize:(int)size
{
    UILabel *label=[[UILabel alloc]init];
    label.center=ceter;
    label.bounds=bounds;
    label.text=text;
    label.textColor=[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:size];
    return label;
}
+(UILabel *)creatBigLabel:(CGPoint)ceter withBounds:(CGRect)bounds withText:(NSString *)text  withFontOfSize:(int)size
{
    UILabel *label=[self creatLabel:ceter withBounds:bounds withText:text withFontOfSize:size];
    label.font=[UIFont boldSystemFontOfSize:size];
    label.textColor=[UIColor blackColor];
    return label;
}
@end
