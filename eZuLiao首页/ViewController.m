//
//  ViewController.m
//  eZuLiao首页
//
//  Created by 成都千锋 on 15/7/6.
//  Copyright (c) 2015年 achu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    int x=self.view.frame.size.width;
    int y=self.view.frame.size.height;
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, y-68, x, 98)];
    downView.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:downView];
    UIView *downViewline=[[UIView alloc]initWithFrame:CGRectMake(0, 0, x, 1)];
    downViewline.backgroundColor=[UIColor darkGrayColor];
    [downView addSubview:downViewline];
    
    NSArray *cArr=@[@"tabbar_book_c",@"tabbar_order_c",@"tabbar_profile_c",@"tabbar_more_c"];
    NSArray *nArr=@[@"预定",@"订单",@"我的",@"我的"];
    for (int i=0; i<4; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake((i)*x/4+x/4/2-22, 5, 44, 44)];
        [but setImage:[UIImage imageNamed:cArr[i]] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
        but.tag=1000+i;
        [downView addSubview:but];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(i*x/4, 0, x/4, 1)];
        view.backgroundColor=[UIColor darkGrayColor];
        view.alpha=0.5;
        view.tag=1500+i;
        [downView addSubview:view];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((i)*x/4+x/4/2-22, 30+5, 44, 44)];
        lab.textColor=[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];;
        lab.text=nArr[i];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont boldSystemFontOfSize:16];
        [downView addSubview:lab];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
