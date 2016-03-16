

#import "orderVC.h"
#import "OrderMode.h"
#import "OrderCell.h"
#import "ScanOrderVC.h"

@interface orderVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
{
    UIView *_view;
    NSMutableArray *_dataArr;
    NSMutableArray *_ingDataArr;
    NSMutableArray *_completeDataArr;
    UITableView *_tabelView;
    UITableView *_twoTableView;
    UITableView *_threeTableView;
    UIScrollView *_scrollView;
    
    UIButton *_dataNilBut;
    
    int _firstLodaKvn;//第一次进来刷新界面等待视图，后面刷新则不加等待视图
    OrderMode *_cancelMode;//记录取消的mode
}
@end

@implementation orderVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    while ([self.view.subviews lastObject]) {
//        [[self.view.subviews lastObject]removeFromSuperview];
//    }
    [self loadData];
}

- (void)creatTableViewAndScrollView {
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, XWIDTH, YHEIGHT-74-59)];
    _scrollView.contentSize=CGSizeMake(XWIDTH*3, CGRectGetHeight(_scrollView.frame));
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    
    _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XWIDTH, YHEIGHT-74-49)];
    _tabelView.tableFooterView=[[UIView alloc]init];
    _tabelView.dataSource=self;
    _tabelView.delegate=self;
    _tabelView.showsVerticalScrollIndicator=NO;
    [_scrollView addSubview:_tabelView];
    
    _twoTableView=[[UITableView alloc]initWithFrame:CGRectMake(XWIDTH, 0, XWIDTH, YHEIGHT-74-59)];
    _twoTableView.tableFooterView=[[UIView alloc]init];
    _twoTableView.dataSource=self;
    _twoTableView.delegate=self;
    _twoTableView.showsVerticalScrollIndicator=NO;
    [_scrollView addSubview:_twoTableView];
    
    _threeTableView=[[UITableView alloc]initWithFrame:CGRectMake(XWIDTH*2, 0, XWIDTH, YHEIGHT-74-49)];
    _threeTableView.tableFooterView=[[UIView alloc]init];
    _threeTableView.dataSource=self;
    _threeTableView.delegate=self;
    _threeTableView.showsVerticalScrollIndicator=NO;
    [_scrollView addSubview:_threeTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
     _firstLodaKvn=0;
    _dataArr=@[].mutableCopy;
    _ingDataArr=@[].mutableCopy;
    _completeDataArr=@[].mutableCopy;
   
    
    [self creatTableViewAndScrollView];
    
    _dataNilBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _dataNilBut.center=CGPointMake(XWIDTH/2, YHEIGHT*(1-0.618));
    UIImage *image=[UIImage imageNamed:@"net_connect_delay"];
    [_dataNilBut setImage:image forState:UIControlStateNormal];
    [_dataNilBut addTarget:self action:@selector(wayDataNilBut) forControlEvents:UIControlEventTouchUpInside];
    [_dataNilBut setTitle:@"点我刷新" forState:UIControlStateNormal];
    _dataNilBut.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    [_dataNilBut setTitleColor:[UIColor colorWithRed:169/255.0 green:233/255.0 blue:248/255.0 alpha:1] forState:UIControlStateNormal];
//    _dataNilBut.contentVerticalAlignment=1;
//    _dataNilBut.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    _dataNilBut.bounds=CGRectMake(0, 0, image.size.width, image.size.height);
    _dataNilBut.hidden=NO;
    
//    UILabel *label=[[UILabel alloc]init];
//    label.center=CGPointMake(image.size.width/2, CGRectGetHeight(_dataNilBut.frame)+20);
//    label.bounds=CGRectMake(0, 0, 100, 40);
//    label.text=@"点我刷新";
//    label.font=[UIFont boldSystemFontOfSize:22];
//    label.textAlignment=NSTextAlignmentCenter;
//    label.textColor=[UIColor colorWithRed:169/255.0 green:233/255.0 blue:248/255.0 alpha:1];
//    [_dataNilBut addSubview:label];
    [self.view addSubview:_dataNilBut];
    [self creatHeadView];
//    [self loadData];
}
-(void)wayDataNilBut
{
    [self loadData];
}
- (void)loadData {
   
    AppDelegate *app=[[AppDelegate alloc]init];
    app.user=[NSUserDefaults standardUserDefaults];
    NSLog(@"%@  %@",[app.user objectForKey:@"myPhoneNumber"],[app.user objectForKey:@"access"]);
    if ([app.user objectForKey:@"myPhoneNumber"]!=nil&&[app.user objectForKey:@"access"]!=nil) {
        AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
        manger.requestSerializer.timeoutInterval = 5;
        NSString *urlStr=[NSString stringWithFormat:API_ORDER,[app.user objectForKey:@"myPhoneNumber"],[app.user objectForKey:@"access"]];
        if (_firstLodaKvn==0) {
            [KVNProgress showWithStatus:@"正在加载您的数据" onView:self.view];
        }
        
        [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * ope, id json) {
            [_dataArr removeAllObjects];
            [_completeDataArr removeAllObjects];
            [_ingDataArr removeAllObjects];
            NSLog(@"%@",json[@"content"]);
           
            if ([json[@"content"] isKindOfClass:[NSArray class]]) {
                NSArray *dataArr=json[@"content"];
                for (int i=0;i<dataArr.count;i++) {
                    OrderMode *mode=[[OrderMode alloc]init];
                    [mode setValuesForKeysWithDictionary:dataArr[i]];
                    //需要删的
//                    if (i==3) {
//                        mode.status=@"3";
//                    }
//
                    if ([mode.status isEqualToString:@"0"]||[mode.status isEqualToString:@"1"]||[mode.status isEqualToString:@"4"]) {
                        [_ingDataArr addObject:mode];
                    }
                    
                    if ([mode.status isEqualToString:@"3"]&&mode.has_comment==false) {
                        [_completeDataArr addObject:mode];
                    }
                    [_dataArr addObject:mode];
                    NSLog(@"a=%@,b=%@,c=%@",_dataArr,_ingDataArr,_completeDataArr);
                }
                [_tabelView reloadData];
                [_threeTableView reloadData];
                [_twoTableView reloadData];
                if (_firstLodaKvn==0) {
                      [KVNProgress showSuccessWithStatus:@"加载完成"];
                    _firstLodaKvn=1;
                }
            }else{
                NSLog(@"aaaa");
                if (_firstLodaKvn==0) {
                    [KVNProgress showSuccessWithStatus:@"无订单"];
                    _firstLodaKvn=1;
                }
                
                [_tabelView reloadData];
            }
             _dataNilBut.hidden=YES;
            if (_dataArr.count>0) {
                _dataNilBut.hidden=YES;
            }
        } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
            _firstLodaKvn=1;
            [KVNProgress showErrorWithStatus:@"网络联接失败"];
            _dataNilBut.hidden=NO;
        }];
    }else{

    }
   
}

- (void)creatHeadView {
    NSArray *arr=@[@"全部",@"进行中",@"待评价"];
    for (int i=0; i<arr.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeSystem];
        but.backgroundColor=[UIColor clearColor];
        but.center=CGPointMake(self.view.frame.size.width/4*(i+1),123/2);
        but.bounds=CGRectMake(0, 0, 90, 25);
        [but setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        but.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        but.tag=1000+i;
        but.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:but];
    }
    _view=[[UIView alloc]init];
    _view.center=CGPointMake(self.view.frame.size.width/4*(0+1),123/2+15+5);
    _view.bounds=CGRectMake(0, 0, 80, 1);
    _view.backgroundColor=[UIColor redColor];
    [self.view addSubview:_view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_scrollView) {
        int i=_scrollView.contentOffset.x/XWIDTH;
        [UIView animateWithDuration:1*0.618*0.618 animations:^{
            _view.center=CGPointMake(self.view.frame.size.width/4*(i+1),123/2+15+5);
        } completion:^(BOOL finished) {
            
        }];
        
        if (i==0) {
            _scrollView.contentOffset=CGPointMake(0, 0);
        }
        if (i==1) {
            _scrollView.contentOffset=CGPointMake(XWIDTH, 0);
        }
        if (i==2) {
            _scrollView.contentOffset=CGPointMake(XWIDTH*2, 0);
        }
        for (int j=0; j<3; j++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:1000+j];
            [button setTitleColor:[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1] forState:UIControlStateNormal];
        }
        UIButton *but=(UIButton *)[self.view viewWithTag:1000+i];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}


-(void)wayBut:(UIButton *)but
{
    [UIView animateWithDuration:1*0.618*0.618 animations:^{
             _view.center=CGPointMake(self.view.frame.size.width/4*(but.tag-1000+1),123/2+15+5);
        } completion:^(BOOL finished) {
            
        }];
    
    if (but.tag==1000) {
        _scrollView.contentOffset=CGPointMake(0, 0);
        _tabelView.frame=CGRectMake(0, YHEIGHT-64, CGRectGetWidth(_tabelView.frame), CGRectGetHeight(_tabelView.frame));
        [UIView animateWithDuration:0.4 animations:^{
            _tabelView.frame=CGRectMake(0, 0, XWIDTH, YHEIGHT-74-49);
        }];

    }
    if (but.tag==1001) {
        _scrollView.contentOffset=CGPointMake(XWIDTH, 0);
        _twoTableView.frame=CGRectMake(XWIDTH, YHEIGHT-64, CGRectGetWidth(_tabelView.frame), CGRectGetHeight(_tabelView.frame));
        [UIView animateWithDuration:0.4 animations:^{
            _twoTableView.frame=CGRectMake(XWIDTH, 0, XWIDTH, YHEIGHT-74-49);
        }];

    }
    if (but.tag==1002) {
        _scrollView.contentOffset=CGPointMake(XWIDTH*2, 0);
        _threeTableView.frame=CGRectMake(XWIDTH*2, YHEIGHT-64, CGRectGetWidth(_tabelView.frame), CGRectGetHeight(_tabelView.frame));
        [UIView animateWithDuration:0.4 animations:^{
            _threeTableView.frame=CGRectMake(XWIDTH*2, 0, XWIDTH, YHEIGHT-74-49);
        }];
    }
    for (int i=0; i<3; i++) {
        UIButton *button=(UIButton *)[self.view viewWithTag:1000+i];
        [button setTitleColor:[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1] forState:UIControlStateNormal];
    }
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tabelView) {
        return _dataArr.count;
    }
    if(tableView==_twoTableView){
        
        return _ingDataArr.count;
    }
    if (tableView==_threeTableView){
        return _completeDataArr.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_tabelView) {
        NSLog(@"1");
        OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"aaa"];
        if (!cell) {
            cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"aaa"];
        }
        OrderMode *model = _dataArr[indexPath.row];
         cell.model = model;
         return cell;
    }
    if(tableView==_twoTableView){
        NSLog(@"2");
        OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"bbb"];
        if (!cell) {
            cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"bbb"];
        }
        OrderMode *model = _ingDataArr[indexPath.row];
        cell.model = model;
                return cell;
    }if (tableView==_threeTableView){
        NSLog(@"3");
        OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ccc"];
        if (!cell) {
            cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ccc"];
        }
        OrderMode *model = _completeDataArr[indexPath.row];
        cell.model = model;
         return cell;
    }
    
    return nil;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [KVNProgress show];
        AppDelegate *app=[[AppDelegate alloc]init];
        app.user=[NSUserDefaults standardUserDefaults];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSString *urlStr=[NSString stringWithFormat:API_Cancel,[app.user objectForKey:@"myPhoneNumber"],[app.user objectForKey:@"access"],_cancelMode.order_number];
        NSLog(@"%@",_cancelMode.order_number);
        NSLog(@"%@",urlStr);
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * op, id json) {
            if ([json[@"status"] intValue]==1) {
                [self loadData];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ScanOrderVC *SOVC=[[ScanOrderVC alloc]init];
    if (tableView==_tabelView) {
        SOVC.mode=_dataArr[indexPath.row];
    }else if(tableView==_twoTableView){
        SOVC.mode=_ingDataArr[indexPath.row];
    }else{
        SOVC.mode=_completeDataArr[indexPath.row];
    }
    
    SOVC.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:SOVC animated:YES completion:^{
        
    }];
}

@end
