

#import "tabBarVC.h"
#import "reserveVC.h"
#import "orderVC.h"
#import "myVC.h"
#import "moreVC.h"


@interface tabBarVC ()
@property(nonatomic,strong)MyVisual *visual;
@end

@implementation tabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    reserveVC *reserve=[[reserveVC alloc]init];
    orderVC *order=[[orderVC alloc]init];
    myVC *my=[[myVC alloc]init];
    moreVC *more=[[moreVC alloc]init];
    _visual=[MyVisual creatVisualOnView:self.tabBar];
    
    reserve.title=@"预定";
    order.title=@"订单";
    my.title=@"我的";
    more.title=@"更多";
    
    
    reserve.tabBarItem.image=[[UIImage imageNamed:@"tabbar_book_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    reserve.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_book_c"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    order.tabBarItem.image=[[UIImage imageNamed:@"tabbar_order_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    order.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_order_c"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    my.tabBarItem.image=[[UIImage imageNamed:@"tabbar_profile_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    my.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_profile_c.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    more.tabBarItem.image=[[UIImage imageNamed:@"tabbar_more_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    more.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_more_c"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *nDic=@{NSForegroundColorAttributeName:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.9]};
    NSDictionary *cDic=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    
    [reserve.tabBarItem setTitleTextAttributes:nDic forState:UIControlStateNormal];
    [reserve.tabBarItem setTitleTextAttributes:cDic forState:UIControlStateSelected];
    [order.tabBarItem setTitleTextAttributes:nDic forState:UIControlStateNormal];
    [order.tabBarItem setTitleTextAttributes:cDic forState:UIControlStateSelected];
    [my.tabBarItem setTitleTextAttributes:nDic forState:UIControlStateNormal];
    [my.tabBarItem setTitleTextAttributes:cDic forState:UIControlStateSelected];
    [more.tabBarItem setTitleTextAttributes:nDic forState:UIControlStateNormal];
    [more.tabBarItem setTitleTextAttributes:cDic forState:UIControlStateSelected];
    
    UINavigationController *moreNav=[[UINavigationController alloc]initWithRootViewController:more];
    
    NSArray *arr=@[reserve,order,my,moreNav];
    self.viewControllers=arr;
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
