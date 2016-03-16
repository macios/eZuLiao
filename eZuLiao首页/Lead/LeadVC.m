
#import "LeadVC.h"
#import "tabBarVC.h"

@interface LeadVC ()

@end

@implementation LeadVC

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize=CGSizeMake(XWIDTH*4, YHEIGHT);
    scrollView.pagingEnabled=YES;
    scrollView.userInteractionEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    for (int i=0; i<4; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(XWIDTH*i, 0, XWIDTH, YHEIGHT)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        [scrollView addSubview:imageView];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, XWIDTH, 20)];
        view.backgroundColor=[UIColor whiteColor];
        [imageView addSubview:view];
        if (i==3) {
            UIButton *but=[UIButton buttonWithType:UIButtonTypeSystem];
            but.center=CGPointMake(XWIDTH/2, 0.8*YHEIGHT);
            but.bounds=CGRectMake(0, 0, 80, 40);
            but.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            but.layer.cornerRadius=10;
            [but setTitle:@"开启" forState:UIControlStateNormal];
            [but addTarget:self action:@selector(way) forControlEvents:UIControlEventTouchUpInside];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            but.titleLabel.font=[UIFont systemFontOfSize:22];
            imageView.userInteractionEnabled=YES;
            [imageView addSubview:but];
        }
    }
    
}

-(void)way
{
    tabBarVC *tab=[[tabBarVC alloc]init];
    UIView *lastView=[self.view snapshotViewAfterScreenUpdates:NO];
    lastView.frame=[UIScreen mainScreen].bounds;
    
    
    [tab.view addSubview:lastView];
    [tab.view bringSubviewToFront:lastView];
    [UIView animateWithDuration:2 animations:^{
        lastView.alpha=0;
    } completion:^(BOOL finished) {
        [lastView removeFromSuperview];
    }];
    
    
    [UIApplication sharedApplication].keyWindow.rootViewController=tab;
}
@end
