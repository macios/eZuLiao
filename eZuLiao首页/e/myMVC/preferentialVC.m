

#import "preferentialVC.h"
#import "CouponMode.h"
@interface preferentialVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *_preferentialFile;
    UIButton *_convertBut;
    
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    
    UIView *_httpView;
}
@end

@implementation preferentialVC
#define mark 创建输入框界面
- (void)CreatFixedView {
    _preferentialFile=[[UITextField alloc]init];
    _preferentialFile.center=CGPointMake(XWIDTH/2, 64+40);
    _preferentialFile.bounds=CGRectMake(0, 0, XWIDTH-40, 35);
    _preferentialFile.layer.cornerRadius=CGRectGetHeight(_preferentialFile.frame)/2;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    _preferentialFile.leftView=view;
    _preferentialFile.leftViewMode=UITextFieldViewModeAlways;
    _preferentialFile.placeholder=@"请输入兑换码";
    _preferentialFile.font=[UIFont systemFontOfSize:16];
    _preferentialFile.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _preferentialFile.returnKeyType=UIReturnKeyDone;
    _preferentialFile.autocorrectionType=UITextAutocorrectionTypeNo;
    _preferentialFile.delegate=self;
    _preferentialFile.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self.view addSubview:_preferentialFile];
    
    _convertBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _convertBut.center=CGPointMake(CGRectGetMaxX(_preferentialFile.frame)-40, _preferentialFile.center.y);
    _convertBut.bounds=CGRectMake(0, 0, 80, CGRectGetHeight(_preferentialFile.frame));
    _convertBut.backgroundColor=[UIColor blackColor];
    _convertBut.layer.cornerRadius=CGRectGetHeight(_convertBut.frame)/2;
    [_convertBut setTitle:@"兑换优惠劵" forState:UIControlStateNormal];
    [_convertBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_convertBut addTarget:self action:@selector(wayConvertBut) forControlEvents:UIControlEventTouchUpInside];
    _convertBut.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_convertBut];
}

- (void)loadData {
    AppDelegate *app=[[AppDelegate alloc]init];
    app.user=[NSUserDefaults standardUserDefaults];
    if ([app.user objectForKey:@"access"]!=nil&&[app.user objectForKey:@"myPhoneNumber"]!=nil) {
        NSString *urlstr=[NSString stringWithFormat:APT_COUPON,[app.user objectForKey:@"access"],[app.user objectForKey:@"myPhoneNumber"]];
        NSLog(@"%@",urlstr);
        [KVNProgress showWithStatus:@"正在加载" onView:_httpView];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation * op, id json) {
            NSArray *arr=json[@"content"];
            for (NSDictionary *dic in arr) {
                CouponMode *mode=[[CouponMode alloc]init];
                [mode setValuesForKeysWithDictionary:dic];
                [_dataArr addObject:mode];
                NSLog(@"%@",dic);
            }
            [_tableView reloadData];
            [KVNProgress showSuccess];
            _httpView.hidden=YES;
        } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
            [KVNProgress showErrorWithStatus:@"网络连接失败,请返回进入刷新" onView:_httpView];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArr=@[].mutableCopy;
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"优惠劵" showOnView:self.view];
    [self CreatFixedView];
    
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_preferentialFile.frame)+10, XWIDTH, YHEIGHT-CGRectGetMaxY(_preferentialFile.frame)-10) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_tableView];
    _httpView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_preferentialFile.frame)+10, XWIDTH, YHEIGHT-CGRectGetMaxY(_preferentialFile.frame)-10)];
    _httpView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_httpView];
    [self loadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
    cell.userInteractionEnabled=NO;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, XWIDTH-40, 90)];
    [cell.contentView addSubview:imageView];
    CouponMode *mode=_dataArr[indexPath.row];
    if ([mode.status intValue]==0) {
        if ([mode.value intValue]>0&&[mode.value intValue]<=50) {
            imageView.image=[UIImage imageNamed:@"bg_black"];
        }else if([mode.value intValue]>50&&[mode.value intValue]<=100){
            imageView.image=[UIImage imageNamed:@"bg_blue"];
        }else {
            imageView.image=[UIImage imageNamed:@"bg_red"];
        }
    }else if([mode.status intValue]==1||[mode.status intValue]==2){
        imageView.image=[UIImage imageNamed:@"bg_gray"];
        UIImageView *useImageView=[[UIImageView alloc]init];
        useImageView.center=CGPointMake(XWIDTH/2+XWIDTH/4, 35);
        useImageView.bounds=CGRectMake(0, 0, 50, 50);
        [cell.contentView addSubview:useImageView];
        if([mode.status intValue]==1){
            useImageView.image=[UIImage imageNamed:@"coupon_unefficted"];
        }else if([mode.status intValue]==2){
            useImageView.image=[UIImage imageNamed:@"coupon_used"];
        }
    }

    UIView *circleView=[[UIView alloc]initWithFrame:CGRectMake(20, 9, 10, 10)];
    circleView.layer.cornerRadius=CGRectGetHeight(circleView.frame)/2;
    circleView.backgroundColor=[UIColor whiteColor];
    [imageView addSubview:circleView];
    
    UILabel *idLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(circleView.frame)+5, 6, CGRectGetWidth(imageView.frame)-CGRectGetMaxX(circleView.frame), 16)];
    idLabel.text=[NSString stringWithFormat:@" %@",mode.code];
    idLabel.textColor=[UIColor whiteColor];
    idLabel.font=[UIFont systemFontOfSize:14];
    [imageView addSubview:idLabel];
    
    UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(circleView.frame),CGRectGetMaxY(circleView.frame)+12, 48, 48)];
    priceLabel.backgroundColor=[UIColor whiteColor];
    priceLabel.layer.cornerRadius=CGRectGetHeight(priceLabel.frame)/2;
    priceLabel.clipsToBounds=YES;
    priceLabel.text=[NSString stringWithFormat:@"%@元",mode.value];
    priceLabel.textAlignment=NSTextAlignmentCenter;
    priceLabel.textColor=[UIColor orangeColor];
    priceLabel.adjustsFontSizeToFitWidth=YES;
    [imageView addSubview:priceLabel];
    
    UILabel *couponLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+10,CGRectGetMinY(priceLabel.frame), CGRectGetWidth(imageView.frame)-CGRectGetMaxX(priceLabel.frame), 20)];
    couponLabel.backgroundColor=[UIColor clearColor];
    couponLabel.text=mode.title;
    couponLabel.textColor=[UIColor whiteColor];
    couponLabel.font=[UIFont boldSystemFontOfSize:20];
    [imageView addSubview:couponLabel];
    
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss z";
    NSDate *agoDate=[format dateFromString:@"1970-1-1 00:00:00 z"];
    NSDate *fuDate=[NSDate dateWithTimeInterval:mode.end_time sinceDate:agoDate];
    NSString *fuDateStr=[NSString stringWithFormat:@"%@",fuDate];
    NSString *fuStr=[[fuDateStr componentsSeparatedByString:@" "] firstObject];
    
    NSDate *begDate=[NSDate dateWithTimeInterval:[mode.generate_time intValue]sinceDate:agoDate];
    NSString *begDateStr=[NSString stringWithFormat:@"%@",begDate];
    NSString *begStr=[[begDateStr componentsSeparatedByString:@" "] firstObject];
    
    NSLog(@"%d %@",[mode.generate_time intValue],begStr);
    UILabel *periodLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+10,CGRectGetMaxY(couponLabel.frame)+9, CGRectGetWidth(couponLabel.frame), 20)];
    periodLabel.backgroundColor=[UIColor clearColor];
    periodLabel.text=[NSString stringWithFormat:@"有效期:%@至%@",begStr,fuStr];
    periodLabel.textColor=[UIColor whiteColor];
    periodLabel.font=[UIFont systemFontOfSize:12];
    [imageView addSubview:periodLabel];

    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [_preferentialFile resignFirstResponder];
    return YES;
}
-(void)wayConvertBut
{
    [_preferentialFile resignFirstResponder];
    if (_preferentialFile.text.length<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入兑换码" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        AppDelegate *app=[[AppDelegate alloc]init];
        app.user=[NSUserDefaults standardUserDefaults];
        NSDictionary *dic=@{@"phone":[app.user objectForKey:@"myPhoneNumber"],
                            @"access_token":[app.user objectForKey:@"access"],
                            @"coupon_code":_preferentialFile.text};
        [manager POST:APT_BindCoupon parameters:dic success:^(AFHTTPRequestOperation * op, id json) {
            if ([json[@"status"] intValue]==1) {
                [self loadData];
            }
            if ([json[@"status"] intValue]==0) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"优惠劵兑换失败，请检查是否输入错误" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
                [alert show];
            }
        } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败，请稍后再试" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)wayBackBut
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
