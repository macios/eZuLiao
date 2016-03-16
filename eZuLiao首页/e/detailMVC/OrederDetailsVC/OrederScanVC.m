

#import "OrederScanVC.h"
#import "CouponMode.h"

@interface OrederScanVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_detailNameArr;
    NSArray *_detailArr;
    
    UIView *_footView;
    UILabel *_footPriceNameLabel;
    UILabel *_footPreceLabel;
    UIButton *_footSubmitBut;
    
    NSMutableArray *_dataArr;
    
    NSMutableArray *_cellArr;
    NSMutableArray *_cellButArr;
    
    NSString *_code;
    int _totalPrice;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation OrederScanVC
- (void)loadData {
    AppDelegate *app=[[AppDelegate alloc]init];
    app.user=[NSUserDefaults standardUserDefaults];
    NSString *urlstr=[NSString stringWithFormat:APT_COUPON,[app.user objectForKey:@"access"],[app.user objectForKey:@"myPhoneNumber"]];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation * op, id json) {
        NSArray *arr=json[@"content"];
        for (NSDictionary *dic in arr) {
            CouponMode *mode=[[CouponMode alloc]init];
            [mode setValuesForKeysWithDictionary:dic];
            if ([mode.status intValue]==0) {
                 [_dataArr addObject:mode];
            }
            NSLog(@"%@",dic);
        }
        [_tableView reloadData];
        NSLog(@"%@",_dataArr);
    } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
    }];
}
#define mark 创建底部视图
- (void)creaBottomView {
    _footView=[[UIView alloc]initWithFrame:CGRectMake(0, YHEIGHT-49, XWIDTH, 49)];
    _footView.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:_footView];
    _footPriceNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 40, 39)];
    _footPriceNameLabel.backgroundColor=[UIColor clearColor];
    _footPriceNameLabel.text=@"总计:";
    [_footView addSubview:_footPriceNameLabel];
    
    _footPreceLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_footPriceNameLabel.frame)+5, 5, 80, 39)];
    _footPreceLabel.backgroundColor=[UIColor clearColor];
    _footPreceLabel.text=_price;
    
    _footPreceLabel.textColor=[[UIColor alloc]initWithRed:252/255.0 green:36/255.0 blue:0/255.0 alpha:1];
    _footPreceLabel.font=[UIFont systemFontOfSize:20];
    [_footView addSubview:_footPreceLabel];
    
    _footSubmitBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _footSubmitBut.frame=CGRectMake(XWIDTH-20-80, 5, 80, 39);
    _footSubmitBut.backgroundColor=[[UIColor alloc]initWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    _footSubmitBut.layer.cornerRadius=CGRectGetHeight(_footSubmitBut.frame)/2;
    [_footSubmitBut setTitle:@"提交" forState:UIControlStateNormal];
    [_footSubmitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_footSubmitBut addTarget:self action:@selector(wayFootSubmitBut) forControlEvents:UIControlEventTouchUpInside];
    _footSubmitBut.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [_footView addSubview:_footSubmitBut];
    
    _totalPrice=[[[_footPreceLabel.text componentsSeparatedByString:@"¥"] lastObject] intValue];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=@[].mutableCopy;
    _cellArr=@[].mutableCopy;
    _cellButArr=@[].mutableCopy;
    [_dataArr addObject:@"不使用"];
    [self loadData];
    self.view.backgroundColor=[UIColor whiteColor];
 
//    NSArray *arr=[_time componentsSeparatedByString:@" "];
//    NSArray *at=[[arr lastObject] componentsSeparatedByString:@":"];
   
    _detailNameArr=@[@"用户姓名  ",@"手机号码  ",@"预约项目  ",@"预约时间  ",@"所在城市  ",@"详细地址  ",@"购买价格  ",@"技师类型  ",@"购买数量  ",@"备注    "];
    _detailArr=@[_name,_no,_project,_time,@"成都",_location,_price,_sex,_count,_comment];
    
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"提交订单" showOnView:self.view];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 74, XWIDTH, YHEIGHT-64-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self creaBottomView];
    for (NSDictionary *dic in _dataArr) {
        NSLog(@"%@",dic);
    }
}
-(void)wayFootSubmitBut
{
//    @property(nonatomic,copy)NSString *name;//预约客户名
//    @property(nonatomic,copy)NSString *no;//预约客户电话
//    @property(nonatomic,copy)NSString *project;//预约项目
//    @property(nonatomic,copy)NSString *time;//预约时间
//    @property(nonatomic,copy)NSString *location;//预约地址
//    @property(nonatomic,copy)NSString *price;//预约总价
//    @property(nonatomic,copy)NSString *sex;//预约优先技师
//    @property(nonatomic,copy)NSString *count;//预约数量
//    @property(nonatomic,copy)NSString *comment;//用户备注
//    @property(nonatomic,strong)NSString *barrel;//桶1 e足疗；0 自家的
    
    NSDictionary *sDic=@{@"不限":@"0",
                         @"女技师":@"1",
                         @"男技师":@"2",};
    
    //按摩类型id
    NSDictionary *durationDic=@{@"玫瑰足疗 60分钟":@"1",
                                @"玫瑰足疗 90分钟":@"2",
                                @"生姜足疗 60分钟":@"3",
                                @"生姜足疗 60分钟":@"4",
                                @"草本精油按摩 90分钟":@"5",
                                @"泰式按摩 90分钟":@"6",
                                @"艾草足疗 60分钟":@"10",
                                @"艾草足疗 90分钟":@"11",
                                @"肩颈按摩 两人套餐 40分钟":@"12",
                                @"肩颈按摩 三人套餐 60分钟":@"13"};
  
    NSDictionary *duration_idDic=@{@"duration_id":durationDic[_project]};
    AppDelegate *app=[[AppDelegate alloc]init];
    app.user=[NSUserDefaults standardUserDefaults];
    NSDictionary *accessDic=@{@"access_token":[app.user objectForKey:@"access"]};
    
//     NSString *name=[_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *nickNameDic=@{@"nickname":_name};
    
    NSString *no=[[app.user objectForKey:@"myPhoneNumber"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *phoneDic=@{@"phone":[NSString stringWithFormat:@"%@",no]};
//    NSLog(@"%@",phoneDic[@"phone"]);
    
    NSString *phone=[_no stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *order_phoneDic=@{@"order_phone":phone};
    
//    NSString *city=[@"成都" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *cityDic=@{@"city":@"成都"};
    
    NSArray *communityArr=[_location componentsSeparatedByString:@" "];
    
//    NSString *community=[communityArr[communityArr.count-2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *communityDic=@{@"community":communityArr[communityArr.count-2]};
    
//    NSString *house_number=[communityArr[communityArr.count-1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *house_numberDic=@{@"house_number":communityArr[communityArr.count-1]};
    NSArray *hourArr=[_time componentsSeparatedByString:@" "];
//    NSLog(@"%@ %@ %@",hourArr[hourArr.count-1],hourArr[hourArr.count-2],hourArr[hourArr.count-3]);
    NSDictionary *order_hourDic=[[NSDictionary alloc]init];
    NSDictionary *order_minuteDic=[[NSDictionary alloc]init];
    if ([hourArr[hourArr.count-1] isEqualToString:@"尽快"]) {
        order_hourDic=@{@"order_hour":@"100"};
        order_minuteDic=@{@"order_minute":@"0"};
    }
    
    else{
        NSArray *arr=[hourArr[hourArr.count-1] componentsSeparatedByString:@":"];
        order_hourDic=@{@"order_hour":[NSString stringWithFormat:@"%d",[arr[0] intValue]-8]};
        order_minuteDic=@{@"order_minute":arr[1]};
    }
    NSDictionary *pay_typeDic=@{@"pay_type":@"offline"};
    NSDictionary *sexDic=@{@"sex":sDic[_sex]};
    NSDictionary *numDic=@{@"num":_count};
    //时间撮
    NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@"月日"];
    NSArray *dayArr=[hourArr[hourArr.count-3] componentsSeparatedByCharactersInSet:set];
//    NSLog(@"%@,%@",dayArr[0],dayArr[1]);
    NSDate * date1 = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss z";
    NSString * currentDate = [format stringFromDate:date1];
    NSString *str=[[currentDate componentsSeparatedByString:@" "]firstObject];
    NSString *yearStr=[[str componentsSeparatedByString:@"-"] firstObject];
    NSDate *nowDate=[format dateFromString:[NSString stringWithFormat:@"%@-%@-%@ 00:00:00 z",yearStr,dayArr[0],dayArr[1]]];
    NSDate *agoDate=[format dateFromString:@"1970-1-1 00:00:00 z"];
    NSDictionary *order_dayDic=@{@"order_day":[NSString stringWithFormat:@"%d",(int)[nowDate timeIntervalSinceDate:agoDate]]};
    
    
     NSMutableArray *submitArr=[NSMutableArray arrayWithArray:@[accessDic,nickNameDic,phoneDic,order_phoneDic,duration_idDic,cityDic,communityDic,house_numberDic,order_dayDic,order_hourDic,order_minuteDic,pay_typeDic,sexDic,numDic]];
//    NSLog(@"%d",(int)submitArr.count);
    
    //非必须
    NSString *barrelStr=[[_project componentsSeparatedByString:@" "] firstObject];
    NSRange rang=[barrelStr rangeOfString:@"足疗"];
  
    if (rang.length==2) {
        NSDictionary *barrelDic=@{@"barrel":_barrel};
        [submitArr addObject:barrelDic];
    }
    if (![_comment isEqualToString:@"无"]) {
//        NSString *comment=[_comment stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *remarksDic=@{@"remarks":_comment};
        [submitArr addObject:remarksDic];
    }
   
    if (_code!=nil) {
        NSDictionary *coupon_codeDic=@{@"coupon_code":_code};
        [submitArr addObject:coupon_codeDic];
    }
    NSMutableDictionary *submitDic=[[NSMutableDictionary alloc]init];
    for (NSDictionary *dic in submitArr) {
        [submitDic addEntriesFromDictionary:dic];
//        NSLog(@"%@",dic);
    }
//    NSLog(@"%@  %@",submitDic[@"order_hour"],submitDic[@"order_minute"]);
//    NSLog(@"%@",submitDic);
//http://www.ezuliao.com/Api/Order/submit?access_token=f312bb597fd9bec7e1c2e95d0434ecf734721a77&nickname=测试&phone=18123239963&order_phone=18123239963&duration_id=3&city=成都&community=测试勿打电话&house_number=1栋2单元303&order_day=1440720000&order_hour=21&order_minute=00&num=1&sex=0&pay_type=offline&coupon_code=U9PU3KZJ
    
    [KVNProgress showWithStatus:@"正在提交"];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager POST:API_Submit parameters:submitDic success:^(AFHTTPRequestOperation * op, id json) {
        if ([json[@"status"] intValue]==1) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
            [KVNProgress showSuccess];
        }
        if ([json[@"status"] intValue]!=1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交订单失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            [KVNProgress showError];
        }
        
    } failure:^(AFHTTPRequestOperation * op, NSError * error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络失败，请稍后再试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        [KVNProgress showError];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 80;
    }else if(indexPath.section==1){
        return 40;
    }else{
        return 40;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1){
        return _dataArr.count;
    }else{
        return _detailNameArr.count;
    }
    
}
-(void)wayCellBut
{
   [KVNProgress showSuccessWithStatus:@"目前只支持线下支付"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"iden"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iden"];
    }else{
        while ([cell.contentView.subviews lastObject]) {
            [[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    if (indexPath.section==0) {
        cell.userInteractionEnabled=YES;
       
        for (int i=0; i<3; i++) {
             UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
            but.center=CGPointMake(43+XWIDTH/4.5*i, 40);
            but.bounds=CGRectMake(0, 0, 60, 60);
            [but addTarget:self action:@selector(wayCellBut) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                [but setImage:[UIImage imageNamed:@"submit_pay_offline_n"] forState:UIControlStateNormal];
            }else if(i==1){
                [but setBackgroundImage:[UIImage imageNamed:@"submit_pay_zhifubao_n"] forState:UIControlStateNormal];
                [but setBackgroundImage:[UIImage imageNamed:@"submit_pay_zhifubao_c"] forState:UIControlStateHighlighted];
            }else{
//                submit_pay_weixin_c
                 [but setBackgroundImage:[UIImage imageNamed:@"submit-_pay_weixin_n"] forState:UIControlStateNormal];
                [but setBackgroundImage:[UIImage imageNamed:@"submit_pay_weixin_c"] forState:UIControlStateHighlighted];
            }
            [cell.contentView addSubview:but];
        }
       
    }
    if(indexPath.section==1){
        cell.userInteractionEnabled=YES;
        UILabel *discountLabel=[[UILabel alloc]init];
        discountLabel.center=CGPointMake(65+40+100*0.618, 20);
        discountLabel.bounds=CGRectMake(0, 0, 200, 30);
        UIButton *selBut=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        selBut.enabled=NO;
        [selBut setBackgroundImage:[UIImage imageNamed:@"submit_radio_no"] forState:UIControlStateNormal];
        [cell.contentView addSubview:selBut];
        [_cellButArr addObject:selBut];
        [_cellArr addObject:cell];
        cell.tag=1000+indexPath.row;
        selBut.tag=1500+indexPath.row;
        if (indexPath.row==0) {
            [selBut setBackgroundImage:[UIImage imageNamed:@"submit_radio_yes"] forState:UIControlStateNormal];
            discountLabel.text=_dataArr[indexPath.row];
        }else{
            CouponMode *mode=_dataArr[indexPath.row];
            discountLabel.text=[NSString stringWithFormat:@"%@ %@元",mode.title,mode.value];
        }
        discountLabel.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:discountLabel];
        
    }
    if (indexPath.section==2)
    {
        UILabel *label=[[UILabel alloc]init];
        label.center=CGPointMake(55, 20);
        label.bounds=CGRectMake(0, 0, 80, 30);
        label.textColor=[UIColor darkGrayColor];
        label.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:label];
        
        /*详情传参*/
        UILabel *detailLabel=[[UILabel alloc]init];
        detailLabel.center=CGPointMake(55+40+100, label.center.y);
        detailLabel.bounds=CGRectMake(0, 0, 200, 30);
        detailLabel.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:detailLabel];
        cell.userInteractionEnabled=NO;
            label.text=_detailNameArr[indexPath.row];
            detailLabel.text=_detailArr[indexPath.row];
    }
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"支付方式";
    }else if(section ==1){
        return @"优惠劵";
    }else{
        return @"订单详情";
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [KVNProgress showSuccessWithStatus:@"目前只支持线下支付"];
    }
    if (indexPath.section==1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        for (int i=0; i<_cellButArr.count; i++) {
            UIButton *but=(UIButton *)[self.view viewWithTag:1500+i];
            [but setBackgroundImage:[UIImage imageNamed:@"submit_radio_no"] forState:UIControlStateNormal];
        }
        for (int i=0; i<_cellButArr.count; i++) {
           UITableViewCell *cell=(UITableViewCell *)[self.view viewWithTag:1000+i];
            cell.userInteractionEnabled=YES;
        }
        UIButton *but=(UIButton *)[self.view viewWithTag:1500+indexPath.row];
        [but setBackgroundImage:[UIImage imageNamed:@"submit_radio_yes"] forState:UIControlStateNormal];
        UITableViewCell *cell=(UITableViewCell *)[self.view viewWithTag:1000+indexPath.row];
        cell.userInteractionEnabled=NO;
        CouponMode *mode=[[CouponMode alloc]init];
        if (indexPath.row==0) {
            mode.value=@"0";
        }else{
            mode=_dataArr[indexPath.row];
            _code=mode.code;
        }
        _footPreceLabel.text=[NSString stringWithFormat:@"¥%d",_totalPrice-[mode.value intValue]];
    }
}
-(void)wayBackBut
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
