//
//  CallBut.h
//  eZuLiao首页
//
//  Created by 成都千锋 on 15/8/28.
//  Copyright (c) 2015年 achu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallBut : UIButton
+(UIButton *)CreatCallButWithFram:(CGRect)fram addTarget:(id)target action:(SEL)sel onShow:(UIView *)view;
@end
