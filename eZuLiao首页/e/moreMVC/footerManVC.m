

#import "footerManVC.h"

@interface footerManVC ()

@end

@implementation footerManVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"注册足疗师" showOnView:self.view];
    UIImageView *iconView=[[UIImageView alloc]init];
    iconView.center=CGPointMake(XWIDTH/2, 100-5);
    iconView.bounds=CGRectMake(0, 0, 100*0.618, 100*0.618);
    iconView.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:iconView];
    UIWebView *view=[[UIWebView alloc]initWithFrame:CGRectMake(0, 80+64, XWIDTH, YHEIGHT-80+64)];
    NSURL *url=[NSURL URLWithString:@"http://www.ezuliao.com/Weixin/Index/register"];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [view loadRequest:req];
    view.scrollView.scrollEnabled=NO;
    [self.view addSubview:view];
    
    UIView *coverView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), 50)];
    coverView.backgroundColor=[UIColor whiteColor];
    [view addSubview:coverView];
}
-(void)wayBackBut
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
