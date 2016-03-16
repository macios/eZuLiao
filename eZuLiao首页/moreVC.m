

#import "moreVC.h"
#import "UrserNeedKnowVC.h"
#import "footerManVC.h"
#import "scopeVC.h"
#import "AboutWeVC.h"

@interface moreVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *moreTableView;
@end

@implementation moreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    _moreTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 200) style:UITableViewStylePlain];
    _moreTableView.tableFooterView=[[UIView alloc]init];//关键语句
    _moreTableView.delegate=self;
    _moreTableView.dataSource=self;
    [self.view addSubview:_moreTableView];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden=@"iden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    else
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    NSArray *arr=@[@"注册足疗师",@"服务范围",@"用户协议",@"关于我们"];
    cell.textLabel.text=arr[indexPath.row];
    NSArray *arr1=@[@"more_sign",@"more_range",@"more_contract",@"more_about"];
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",arr1[indexPath.row]]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        footerManVC *foot=[[footerManVC alloc]init];
        foot.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:foot animated:YES completion:^{
        }];
    }
    if (indexPath.row==1) {
        scopeVC *scope=[[scopeVC alloc]init];
        scope.modalTransitionStyle=UIModalTransitionStylePartialCurl;
        [self presentViewController:scope animated:YES completion:^{
        }];
    }
    if (indexPath.row==2) {
        UrserNeedKnowVC *userVC=[[UrserNeedKnowVC alloc]init];
        userVC.modalTransitionStyle=UIModalTransitionStylePartialCurl;
        [self presentViewController:userVC animated:YES completion:^{
        }];
    }
    if (indexPath.row==3) {
        AboutWeVC *aboutVC=[[AboutWeVC alloc]init];
        aboutVC.modalTransitionStyle=UIModalTransitionStylePartialCurl;
        [self presentViewController:aboutVC animated:YES completion:^{
        }];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        cell.frame=CGRectMake(XWIDTH, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        [UIView animateWithDuration:0.5*0.618*0.618 animations:^{
            cell.frame=CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        }];
    }
    if (indexPath.row==1) {
        cell.frame=CGRectMake(XWIDTH, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        [UIView animateWithDuration:1*0.618*0.618 animations:^{
            cell.frame=CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        }];
    }

    if (indexPath.row==2) {
        cell.frame=CGRectMake(XWIDTH, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        [UIView animateWithDuration:1.5*0.618*0.618 animations:^{
            cell.frame=CGRectMake(0 ,cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        }];
    }

    if (indexPath.row==3) {
        cell.frame=CGRectMake(XWIDTH, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        [UIView animateWithDuration:2*0.618*0.618 animations:^{
            cell.frame=CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        }];
    }
    

}
- (void)CellAnimate:(UITableViewCell *)cell
{
    }
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   [_moreTableView reloadData];
}
@end
