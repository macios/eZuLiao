//
//  CallBut.m
//  eZuLiao首页
//
//  Created by 成都千锋 on 15/8/28.
//  Copyright (c) 2015年 achu. All rights reserved.
//

#import "CallBut.h"

@implementation CallBut

+(UIButton *)CreatCallButWithFram:(CGRect)fram
                        addTarget:(id)target
                           action:(SEL)sel
                           onShow:(UIView *)view
{
    UIButton *callBut=[UIButton buttonWithType:UIButtonTypeCustom];
    callBut.frame=fram;
    [callBut setImage:[UIImage imageNamed:@"calling"] forState:UIControlStateNormal];
    [callBut addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:callBut];
//    callBut.userInteractionEnabled=YES;
    return callBut;
    
    
}
@end
