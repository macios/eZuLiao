

#import "scopeVC.h"

@interface scopeVC ()

@end

@implementation scopeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"服务范围" showOnView:self.view];
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
