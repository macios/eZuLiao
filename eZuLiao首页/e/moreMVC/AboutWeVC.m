

#import "AboutWeVC.h"

@interface AboutWeVC ()

@end

@implementation AboutWeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"关于我们" showOnView:self.view];
    UIImageView *iconView=[[UIImageView alloc]init];
    iconView.center=CGPointMake(XWIDTH/2, 100-5);
    iconView.bounds=CGRectMake(0, 0, 100*0.618, 100*0.618);
    iconView.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:iconView];
}
-(void)wayBackBut
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
