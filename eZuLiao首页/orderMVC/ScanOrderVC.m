

#import "ScanOrderVC.h"
#import "DetailVC.h"
#import "CommentVC.h"

@interface ScanOrderVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSArray *_countArr;
    UIView *_footView;
    UIButton *_footSubmitBut;
    UIButton *_cancelBut;
    NSDictionary *_statusDic;
    
}

@end

@implementation ScanOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"订单详情" showOnView:self.view];
    _countArr=@[@2,@3,@2,@2,@1,@1];
    self.view.backgroundColor=[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 74, XWIDTH-20, YHEIGHT-84-49) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    _statusDic=@{@"0":@"预定",
                 @"1":@"已受理",
                 @"2":@"已取消",
                 @"3":@"已完成",};
    
    _footView=[[UIView alloc]initWithFrame:CGRectMake(0, YHEIGHT-49, XWIDTH, 49)];
    _footView.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self.view addSubview:_footView];
    
    _cancelBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _cancelBut.frame=CGRectMake(15, 5, 50, 39);
    _cancelBut.backgroundColor=[UIColor clearColor];
    [_cancelBut setTitle:@"返回" forState:UIControlStateNormal];
    if ([_mode.status intValue]==0||[_mode.status intValue]==1) {
        [_cancelBut setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBut.backgroundColor=[UIColor orangeColor];
        _cancelBut.layer.cornerRadius=CGRectGetHeight(_cancelBut.frame)/2;
    }
    [_cancelBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelBut addTarget:self action:@selector(wayFootBut) forControlEvents:UIControlEventTouchUpInside];
    _cancelBut.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [_footView addSubview:_cancelBut];
    
    _footSubmitBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _footSubmitBut.frame=CGRectMake(XWIDTH-20-80, 5, 80, 39);
    _footSubmitBut.backgroundColor=[[UIColor alloc]initWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    _footSubmitBut.layer.cornerRadius=CGRectGetHeight(_footSubmitBut.frame)/2;
    if ([_mode.status intValue]==3&&_mode.has_comment==false){
        [_footSubmitBut setTitle:@"点击评价" forState:UIControlStateNormal];
    }else{
        [_footSubmitBut setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    
    [_footSubmitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_footSubmitBut addTarget:self action:@selector(wayFootSubmitBut) forControlEvents:UIControlEventTouchUpInside];
    _footSubmitBut.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [_footView addSubview:_footSubmitBut];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [KVNProgress show];
        AppDelegate *app=[[AppDelegate alloc]init];
        app.user=[NSUserDefaults standardUserDefaults];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSString *urlStr=[NSString stringWithFormat:API_Cancel,[app.user objectForKey:@"myPhoneNumber"],[app.user objectForKey:@"access"],_mode.order_number];
        NSLog(@"%@",_mode.order_number);
        NSLog(@"%@",urlStr);
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * op, id json) {
            if ([json[@"status"] intValue]==1) {
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }
            if ([json[@"status"] intValue]!=1) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"取消失败" message:@"超过规定时间取消，请在首页电话联系客服" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
                [alert show];
            }
            [KVNProgress showSuccess];
        } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
            [KVNProgress showError];
        }];
        
    }
}
-(void)wayFootBut
{
    if ([_cancelBut.titleLabel.text isEqualToString:@"取消"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确认取消订单？" message:@"订单开始前1.5小时内仅能通过客服电话取消，取消属于爽约，需要支付一定费用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}
-(void)wayFootSubmitBut
{
    if ([_footSubmitBut.titleLabel.text isEqualToString:@"再次购买"]) {
        DetailVC *detail=[[DetailVC alloc]init];
        detail.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        detail.name=_mode.type_name;
        detail.price=[_mode.current_price intValue];
        if ([_mode.type_name isEqualToString:@"草本精油按摩"]) {
            detail.imageName=@"product_massage_oil";
        }else if([_mode.type_name isEqualToString:@"泰式按摩"]){
            detail.imageName=@"product_massage_taishi-";
        }else if([_mode.type_name isEqualToString:@"肩颈按摩"]){
            detail.imageName=@"product_massage_neck-";
        }else if([_mode.type_name isEqualToString:@"玫瑰足疗"]){
            detail.imageName=@"product_pedicure_rose";
        }else if([_mode.type_name isEqualToString:@"生姜足疗"]){
            detail.imageName=@"product_pedicure_ginger";
        }else{
            detail.imageName=@"product_pedicure_mugwort-";
        }
        [self presentViewController:detail animated:YES completion:^{
            
        }];
    }else if([_footSubmitBut.titleLabel.text isEqualToString:@"点击评价"]){
        CommentVC *comVC=[[CommentVC alloc]init];
        comVC.mode=_mode;
        [self presentViewController:comVC animated:YES completion:^{
        }];
    }else{
        
    }
}

-(void)wayBackBut
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if(section==1){
        return 3;
    }else if(section==2){
        return 2;
    }else if(section==3){
        return 2;
    }else if(section==4){
        return 1;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"iden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    else{
        while ([cell.contentView.subviews lastObject]) {
            [[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    cell.layer.cornerRadius=5;
    cell.userInteractionEnabled=NO;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10,0,100, 30)];
    label.textColor=[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    label.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:label];
    
    UILabel *detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame),0,CGRectGetWidth(_tableView.frame)-CGRectGetMaxX(label.frame)-10, 30)];
    detailLabel.textAlignment=NSTextAlignmentRight;
    [cell.contentView addSubview:detailLabel];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            label.text=@"订单状态";
            detailLabel.text=_statusDic[_mode.status];
            if ([_mode.status intValue]==3&&_mode.has_comment ==false) {
                 detailLabel.text=@"待评价";
            }
            detailLabel.frame=CGRectMake(XWIDTH-92,2,60,25);
            detailLabel.layer.cornerRadius=CGRectGetHeight(detailLabel.frame)/2;
            detailLabel.backgroundColor=[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
            detailLabel.clipsToBounds=YES;
            detailLabel.textAlignment=NSTextAlignmentCenter;
            if ([detailLabel.text isEqualToString:@"预定"]||[detailLabel.text isEqualToString:@"已受理"]||[detailLabel.text isEqualToString:@"待评价"]) {
                detailLabel.backgroundColor=[UIColor orangeColor];
                detailLabel.textColor=[UIColor whiteColor];
            }
        }else{
            label.text=@"订单号";
            detailLabel.text=_mode.order_number;
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            label.text=@"姓       名";
            detailLabel.text=_mode.nickname;
        }else if(indexPath.row==1){
            label.text=@"手机号码";
            detailLabel.text=_mode.phone;
        }else{
            label.text=@"地       址";
            detailLabel.text=[NSString stringWithFormat:@"%@ %@ %@",_mode.city,_mode.community,_mode.house_number];
        }
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            label.text=@"总       计";
            detailLabel.text=[NSString stringWithFormat:@"%@份    %@元",_mode.num,_mode.total_price];
        }else {
            label.text=@"夜交通费";
            if ([_mode.nightfee intValue]==0) {
                detailLabel.text=@"无";
            }else{
                detailLabel.text=@"30元";
            }
        }
    }
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            label.text=@"预约项目";
            detailLabel.text=_mode.product_title;
        }else {
            label.text=@"预约时间";
            detailLabel.text=_mode.time;
        }
    }
    if (indexPath.section==4) {
        label.text=@"备       注";
        if (_mode.remarks.length<1) {
            detailLabel.text=@"无";
        }else{
            detailLabel.text=_mode.remarks;
        }
    }
    if (indexPath.section==5) {
        label.text=@"支付方式";
        if ([_mode.pay_type isEqualToString:@"offline"]) {
            detailLabel.text=@"线下支付";
        }else{
            detailLabel.text=@"其他";
        }
        
    }
    if (indexPath.section!=4&&indexPath.section!=5) {
        if (indexPath.row==0||(indexPath.section==1&&indexPath.row==1)) {
            UIView *view=[[UIView alloc]init];
            view.frame=CGRectMake(0,30/2, 8, 30);
            view.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:view];
            
            UIView *view2=[[UIView alloc]init];
            view2.frame=CGRectMake(XWIDTH-28,15, 8, 30);
            view2.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:view2];
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
@end
