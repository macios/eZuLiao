

#import "OrederDetailsVC.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MapKit/MapKit.h>
#import "OrederScanVC.h"

@interface OrederDetailsVC ()<UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate,CLLocationManagerDelegate,UITextViewDelegate>
{
    UIView *_backgroundView;
    UIButton *_ownBut;
    UIButton *_friendBut;
    UIView *_butView;
    AppDelegate *_app;
    
    UITextField *_nameFiled;
    UIButton *_nameImageBut;
    UITextField *_locationFiled;
//    UIButton *_locationBut;
    UITextField *_noFiled;
    UIButton *_timeBut;
    UIImageView *_timeImageView;
    
    UIView *_alplaView;
    UIView *_timeView;
    UIButton *_cancelBut;
    UIButton *_finishBut;
    
    UITextView *_commentTextView;
    UILabel *_commentTextLabel;
    UIButton *_downBut;
    NSString *_indexStr;//记录日期号数
    NSString *_timeStr;//记录选择的日期
    int _foreTag;//时间选中前一个tag值
    int _i;//时间保存按钮标记
}
@property (nonatomic,strong)ABPeoplePickerNavigationController *picker;
@property(nonatomic,strong)CLLocationManager *locManager;
@property(nonatomic,copy)NSString *nowDateStr;
@property(nonatomic,copy)NSString *dateFutureStr;
@property(nonatomic,strong)NSMutableDictionary *dateDic;
@end

@implementation OrederDetailsVC




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _foreTag=0;
  
    _app=[[AppDelegate alloc]init];
    _app.user=[NSUserDefaults standardUserDefaults];
    _locManager=[[CLLocationManager alloc]init];
    _locManager.distanceFilter=10.0;
    [_locManager requestAlwaysAuthorization];
    [_locManager startUpdatingLocation];
    _dateDic=[NSMutableDictionary dictionary];
   
    
    _picker=[[ABPeoplePickerNavigationController alloc]init];
    self.picker.peoplePickerDelegate = self;
    
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"用户预定" showOnView:self.view];
    _downBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _downBut.center=CGPointMake(XWIDTH/2, YHEIGHT-40);
    _downBut.bounds=CGRectMake(0, 0, 80, 35);
    _downBut.layer.cornerRadius=35/2;
    _downBut.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [_downBut setTitle:@"下一步" forState:UIControlStateNormal];
    [_downBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_downBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_downBut];
    [self creatOwnAndFriendbut];
    [self creatTextFiled];
    
    _nameImageBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _nameImageBut.center=CGPointMake(CGRectGetMaxX(_nameFiled.frame)-25, _nameFiled.center.y);
    _nameImageBut.bounds=CGRectMake(0, 0, 40, 40);
    [_nameImageBut setImage:[UIImage imageNamed:@"adduser_name"] forState:UIControlStateNormal];
    [_nameImageBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nameImageBut];
    
//    _locationBut=[UIButton buttonWithType:UIButtonTypeCustom];
//    _locationBut.center=CGPointMake(CGRectGetMaxX(_locationFiled.frame)-25, _locationFiled.center.y);
//    _locationBut.bounds=CGRectMake(0, 0, 40, 40);
//    [_locationBut setImage:[UIImage imageNamed:@"adduser_position"] forState:UIControlStateNormal];
//    [_locationBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
//    _locationBut.hidden=YES;
//    [self.view addSubview:_locationBut];

}
#pragma mark 创建为自己为朋友按钮视图
- (void)creatOwnAndFriendbut {
    _butView=[[UIView alloc]init];
    _butView.center=CGPointMake(XWIDTH/2, 64+10+20);
    _butView.bounds=CGRectMake(0, 0, 140, 30);
    _butView.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _butView.layer.cornerRadius=CGRectGetHeight(_butView.frame)/2;
    [self.view addSubview:_butView];
    
    _ownBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _ownBut.center=CGPointMake(XWIDTH/2-30, 64+10+20);
    _ownBut.bounds=CGRectMake(0, 0, 80, 30);
    _ownBut.layer.cornerRadius=CGRectGetHeight(_ownBut.frame)/2;
    _ownBut.backgroundColor=[UIColor blackColor];
    [_ownBut setTitle:@"为自己" forState:UIControlStateNormal];
    _ownBut.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [_ownBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ownBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ownBut];
    
    _friendBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _friendBut.center=CGPointMake(XWIDTH/2+30, 64+10+20);
    _friendBut.bounds=CGRectMake(0, 0, 80, 30);
    _friendBut.layer.cornerRadius=CGRectGetHeight(_friendBut.frame)/2;
    _friendBut.backgroundColor=[UIColor clearColor];
    [_friendBut setTitle:@"    为他人" forState:UIControlStateNormal];
    _friendBut.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [_friendBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_friendBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_friendBut];
}
#pragma mark 创建信息框视图
- (void)creatTextFiled {
     UIView *spaceView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
     UIView *spaceView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
     UIView *spaceView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _nameFiled=[[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_butView.frame)+20, XWIDTH-40, 40)];
    _nameFiled.placeholder=@"请输入用户名";
    _nameFiled.returnKeyType=UIReturnKeyDone;
    _nameFiled.leftView = spaceView1;
    _nameFiled.leftViewMode = UITextFieldViewModeAlways;
    _nameFiled.autocapitalizationType=UITextAutocorrectionTypeNo;
    _nameFiled.clearsOnBeginEditing=YES;
    _nameFiled.delegate=self;
    _nameFiled.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _nameFiled.layer.cornerRadius=CGRectGetHeight(_nameFiled.frame)/2;
    if ([_app.user objectForKey:@"myName"]!=nil) {
        _nameFiled.text=[_app.user objectForKey:@"myName"];
    }
    [self.view addSubview:_nameFiled];
    
    
    _noFiled=[[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_nameFiled.frame)+20, XWIDTH-40, 40)];
    _noFiled.placeholder=@"请输入手机号码";
    _noFiled.autocapitalizationType=UITextAutocorrectionTypeNo;
    _noFiled.clearsOnBeginEditing=YES;
    _noFiled.delegate=self;
    _noFiled.leftView = spaceView2;
    _noFiled.leftViewMode = UITextFieldViewModeAlways;
    _noFiled.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _noFiled.layer.cornerRadius=CGRectGetHeight(_noFiled.frame)/2;
    _noFiled.text=[_app.user objectForKey:@"myPhoneNumber"];
    _noFiled.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:_noFiled];
    
    _locationFiled=[[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_noFiled.frame)+20, XWIDTH-40, 40)];
    _locationFiled.leftView = spaceView3;
    _locationFiled.leftViewMode = UITextFieldViewModeAlways;
    _locationFiled.placeholder=@"请输入小区名与门牌号";
    _locationFiled.autocapitalizationType=UITextAutocorrectionTypeNo;
    _locationFiled.clearsOnBeginEditing=YES;
    _locationFiled.delegate=self;
    _locationFiled.returnKeyType=UIReturnKeyDone;
    _locationFiled.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _locationFiled.layer.cornerRadius=CGRectGetHeight(_nameFiled.frame)/2;
    if ([_app.user objectForKey:@"location"]!=nil&&[_app.user objectForKey:@"doorNo"]!=nil) {
        _locationFiled.text=[NSString stringWithFormat:@"%@ %@",[_app.user objectForKey:@"location"],[_app.user objectForKey:@"doorNo"]];
    }
    [self.view addSubview:_locationFiled];
    
    _timeBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _timeBut.frame=CGRectMake(20, CGRectGetMaxY(_locationFiled.frame)+20, XWIDTH-40, 40);
    _timeBut.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [_timeBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_timeBut setTitle:@"请选择服务时间" forState:UIControlStateNormal];
    _timeBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _timeBut.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    _timeBut.layer.cornerRadius=CGRectGetHeight(_timeBut.frame)/2;
    [_timeBut setTitleColor:[[UIColor alloc]initWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1] forState:UIControlStateNormal];
    [_timeBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    _timeBut.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_timeBut];
    
    UIImageView *iconTimeImageView=[[UIImageView alloc]init];
    iconTimeImageView.center=CGPointMake(XWIDTH-45,_timeBut.center.y);
    iconTimeImageView.bounds=CGRectMake(0, 0, 32, 32);
    iconTimeImageView.image=[UIImage imageNamed:@"adduser_time"];
    [self.view addSubview:iconTimeImageView];
    
    _commentTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_timeBut.frame)+10, XWIDTH-40,CGRectGetMinY(_downBut.frame)-CGRectGetMaxY(_timeBut.frame)-20)];
    _commentTextView.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _commentTextView.layer.cornerRadius=10;
    _commentTextView.delegate=self;
    _commentTextView.font=[UIFont systemFontOfSize:16];
    _commentTextView.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:_commentTextView];
    
    _commentTextLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 20)];
    _commentTextLabel.text=@"备注（可不写）";
    _commentTextLabel.textColor=[[UIColor alloc]initWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1];
    _commentTextLabel.font=[UIFont systemFontOfSize:16];
    [_commentTextView addSubview:_commentTextLabel];
}
#pragma mark 创建选择日期时间根视图
- (void)creatTimeView
{
    _alplaView=[[UIView alloc]initWithFrame:self.view.bounds];
    _alplaView.backgroundColor=[UIColor blackColor];
    _alplaView.alpha=0.5;
    [self.view addSubview:_alplaView];
    _timeView=[[UIView alloc]initWithFrame:CGRectMake(20, 0.2*YHEIGHT, XWIDTH-40, 0.618*YHEIGHT+60)];
    _timeView.layer.cornerRadius=10;
    _timeView.clipsToBounds=YES;
    _timeView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_timeView];
   
    
    _cancelBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBut.center=CGPointMake(XWIDTH/2, CGRectGetMinY(_timeView.frame));
    _cancelBut.bounds=CGRectMake(0, 0, 41, 41);
    [_cancelBut setImage:[UIImage imageNamed:@"icon_cancel"] forState:UIControlStateNormal];
    [_cancelBut addTarget:self action:@selector(wayCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBut];
    
    _finishBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _finishBut.center=CGPointMake((XWIDTH-40)/2, CGRectGetHeight(_timeView.frame)-40);
    _finishBut.bounds=CGRectMake(0, 0, 60, 30);
    _finishBut.backgroundColor=[UIColor blackColor];
    _finishBut.layer.cornerRadius=CGRectGetHeight(_finishBut.frame)/2;
    _finishBut.clipsToBounds=YES;
    [_finishBut setTitle:@"保存" forState:UIControlStateNormal];
    _finishBut.backgroundColor=[UIColor darkGrayColor];
    [_finishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_finishBut addTarget:self action:@selector(wayfinishBut) forControlEvents:UIControlEventTouchUpInside];
    [_timeView addSubview:_finishBut];
    
    UILabel *label=[[UILabel alloc]init];
    
    label.bounds=CGRectMake(0, 0,XWIDTH, 20);
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"*若开始时间超过21点,需加收30元交通费";
    [_timeView addSubview:label];
    if (YHEIGHT==480.0) {
        label.center=CGPointMake(CGRectGetWidth(_timeView.frame)/2, CGRectGetHeight(_timeView.frame)-22);
        label.font=[UIFont systemFontOfSize:12];
        _timeView.frame=CGRectMake(20, 0.2*YHEIGHT, XWIDTH-40, YHEIGHT-0.2*YHEIGHT-10);
        _finishBut.center=CGPointMake((XWIDTH-40)/2, CGRectGetHeight(_timeView.frame)-18);
         _finishBut.bounds=CGRectMake(0, 0, 50, 25);
         _finishBut.layer.cornerRadius=CGRectGetHeight(_finishBut.frame)/2;

    }else if(YHEIGHT==568){
     label.center=CGPointMake(CGRectGetWidth(_timeView.frame)/2, CGRectGetHeight(_timeView.frame)-67);
    }else{
    label.center=CGPointMake(CGRectGetWidth(_timeView.frame)/2, CGRectGetHeight(_timeView.frame)-85);
    }
   
}
#pragma mark 创建选择时间按钮视图
- (void)creatSelTimeButView
{
    //    _nowDateStr=@"2015-08-13 20:08:28";
    
    NSDate * date1 = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss z";
    NSString * currentDate = [format stringFromDate:date1];
    NSArray *arr=[currentDate componentsSeparatedByString:@" "];
    _nowDateStr=[NSString stringWithFormat:@"%@ %@",arr[0],arr[1]];
   
    NSArray *nowDateStrArr=[_nowDateStr componentsSeparatedByString:@" "];
    NSString *dateStr=[NSString stringWithFormat:@"%@ 10:00:00 z",nowDateStrArr[0]];
    
    NSDate *date = [format dateFromString:dateStr];
    
    int d=0;
    for (int j=0; j<6;j++) {
        for (int i=0; i<5; i++) {
            if (j==5&&i>=3) {
            }else{
                NSDate *da=[date dateByAddingTimeInterval:30*60*d++];
                int a=0;
                if ([[_dateFutureStr componentsSeparatedByString:@" "][0] isEqualToString:[_nowDateStr componentsSeparatedByString:@" "][0] ]) {
                    NSDate *nowDate=[format dateFromString:[NSString stringWithFormat:@"%@ z",_nowDateStr]];
                    a=[da timeIntervalSinceDate:nowDate];
                }else{
                    NSDate *nowDate=[format dateFromString:_dateFutureStr];
                    a=[nowDate timeIntervalSinceDate:da];
                }
                if (_dateFutureStr==nil) {
                    NSDate *nowDate=[format dateFromString:[NSString stringWithFormat:@"%@ z",_nowDateStr]];
                    a=[da timeIntervalSinceDate:nowDate];
                }
                NSString *str=[NSString stringWithFormat:@"%@",da];
                NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@" :"];
                NSArray *arr=[str componentsSeparatedByCharactersInSet:set];
                NSString *sss=[NSString stringWithFormat:@"%@:%@",arr[1],arr[2]];
                UIButton *time=[UIButton buttonWithType:UIButtonTypeSystem];
                time.frame=CGRectMake(i*((CGRectGetWidth(_timeView.frame)-60-5*40)/4+40)+30,45*(j+1)+40*0.618, 45, 45);
                time.layer.cornerRadius=CGRectGetHeight(time.frame)/2;
                [time addTarget:self action:@selector(waySelTimeBut:) forControlEvents:UIControlEventTouchUpInside];
                time.tag=1999+d;
                [time setTitle:sss forState:UIControlStateNormal];
                if (i==2&&j==5) {
                    [time setTitle:@"尽快" forState:UIControlStateNormal];
                }
                if ((a-60*60)>0) {
                    time.titleLabel.font=[UIFont boldSystemFontOfSize:15];
                    [time setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }else{
                    [time setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    [time setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
                    time.titleLabel.font=[UIFont systemFontOfSize:15];
                    time.enabled=NO;
                }
                
                [_timeView addSubview:time];
            }
        }
    }
}
#pragma mark 创建日期按钮视图
- (void)creatTimeBut
{
    //    2015年8月14日 星期五
    _indexStr=@"0";
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss z";
    //第四天
    NSDate *arrLastDate=[nowDate dateByAddingTimeInterval:3*24*60*60];
    format.dateStyle=NSDateFormatterFullStyle;
    NSString * str = [format stringFromDate:arrLastDate];
    NSString *arrLastDateStr=[str componentsSeparatedByString:@","][0];
    NSString *sss=[[arrLastDateStr componentsSeparatedByString:@" "] lastObject];
    NSString *fourStr=[[arrLastDateStr componentsSeparatedByString:@"年"] lastObject];
    [_dateDic setObject:fourStr forKey:@"3"];
    //第三天
    NSDate *threeDate=[nowDate dateByAddingTimeInterval:2*24*60*60];
    format.dateStyle=NSDateFormatterFullStyle;
    NSString * threestr = [format stringFromDate:threeDate];
    NSString *threeDateStr=[threestr componentsSeparatedByString:@","][0];
    NSString *threeStr=[[threeDateStr componentsSeparatedByString:@"年"] lastObject];
    [_dateDic setObject:threeStr forKey:@"2"];
    //第二天
    NSDate *twoDate=[nowDate dateByAddingTimeInterval:1*24*60*60];
    format.dateStyle=NSDateFormatterFullStyle;
    NSString * twoaStr = [format stringFromDate:twoDate];
    NSString *twoDateStr=[twoaStr componentsSeparatedByString:@","][0];
    NSString *twoStr=[[twoDateStr componentsSeparatedByString:@"年"] lastObject];
    [_dateDic setObject:twoStr forKey:@"1"];
    //第一天
    NSDate *oneDate=[nowDate dateByAddingTimeInterval:0*24*60*60];
    format.dateStyle=NSDateFormatterFullStyle;
    NSString * oneastr = [format stringFromDate:oneDate];
    NSString *oneDateStr=[oneastr componentsSeparatedByString:@","][0];
    NSString *oneStr=[[oneDateStr componentsSeparatedByString:@"年"] lastObject];
    [_dateDic setObject:oneStr forKey:@"0"];
    
    NSArray *arr=@[@"今天",@"明天",@"后天",sss];
    for (int i=0; i<4; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeSystem];
        but.frame=CGRectMake(i*((CGRectGetWidth(_timeView.frame)-60-4*50)/3+50)+30, 50*0.618*0.618, 50, 50);
        //        but.backgroundColor=[UIColor darkGrayColor];
        but.layer.cornerRadius=25;
        but.tag=1000+i;
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setTitle:arr[i] forState:UIControlStateNormal];
        if (i==0) {
            but.backgroundColor=[UIColor blackColor];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [but addTarget:self action:@selector(waySelDateBut:) forControlEvents:UIControlEventTouchUpInside];
        [_timeView addSubview:but];
    }
    
    [self creatSelTimeButView];
}
#pragma mark 日期选择按钮事件
-(void)waySelDateBut:(UIButton *)but
{
    _i=0;
    _foreTag=-1;
    for (int i=0; i<4; i++) {
        UIButton *button=(UIButton *)[self.view viewWithTag:1000+i];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor clearColor];
    }
    but.backgroundColor=[UIColor blackColor];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    int j=(int)but.tag-1000;
    _indexStr=[NSString stringWithFormat:@"%d",j];
    
    NSString *str=[NSString stringWithFormat:@"%@ z",_nowDateStr];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    fomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss z";
    NSDate *date = [fomatter dateFromString:str];
    NSDate *dateFuture=[date dateByAddingTimeInterval:j*24*60*60];
    _dateFutureStr=[NSString stringWithFormat:@"%@",dateFuture];
    for (int i=0; i<28; i++) {
        UIButton *but=(UIButton *)[self.view viewWithTag:2000+i];
        [but removeFromSuperview];
    }
    [self creatSelTimeButView];
}
#pragma mark 时间选择按钮事件
-(void)waySelTimeBut:(UIButton *)But
{
    _i=1;//更改保存键的提示信息。1不提示则保存成功，0提示请选择时间
    _finishBut.backgroundColor=[UIColor blackColor];
    if (_foreTag>0) {
        UIButton *button=(UIButton *)[self.view viewWithTag:_foreTag];
        button.backgroundColor=[UIColor clearColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    But.backgroundColor=[UIColor orangeColor];
    [But setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _timeStr=But.titleLabel.text;
    _foreTag=(int)But.tag;
}
#pragma mark 为自己为他人按钮与信息框事件
-(void)wayBut:(UIButton *)but
{
     self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2);
    [_nameFiled resignFirstResponder];
    [_noFiled resignFirstResponder];
    [_locationFiled resignFirstResponder];
    [_commentTextView resignFirstResponder];
    if (but==_ownBut) {
        [_ownBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _ownBut.backgroundColor=[UIColor blackColor];
        [_ownBut setTitle:@"为自己" forState:UIControlStateNormal];
        [_friendBut setTitle:@"    为他人" forState:UIControlStateNormal];
        _friendBut.backgroundColor=[UIColor clearColor];
        [_friendBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if ([_app.user objectForKey:@"myName"]!=nil) {
            _nameFiled.text=[_app.user objectForKey:@"myName"];
        }
        _noFiled.text=[_app.user objectForKey:@"myPhoneNumber"];
        if ([_app.user objectForKey:@"location"]!=nil&&[_app.user objectForKey:@"doorNo"]!=nil) {
            _locationFiled.text=[NSString stringWithFormat:@"%@ %@",[_app.user objectForKey:@"location"],[_app.user objectForKey:@"doorNo"]];
        }
    }
    if (but==_friendBut) {
        [_ownBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ownBut.backgroundColor=[UIColor clearColor];
        [_ownBut setTitle:@"为自己    " forState:UIControlStateNormal];
        [_friendBut setTitle:@"为他人" forState:UIControlStateNormal];
        _friendBut.backgroundColor=[UIColor blackColor];
        [_friendBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeBut setTitle:@"请选择服务时间" forState:UIControlStateNormal];
        [_timeBut setTitleColor:[[UIColor alloc]initWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1]  forState:UIControlStateNormal];
        _nameFiled.text=nil;
        _noFiled.text=nil;
        _locationFiled.text=nil;
    }
    if (but==_nameImageBut) {
        [KVNProgress showWithStatus:@"正在进入系统通讯录"];
        [self presentViewController:self.picker animated:YES completion:^{
            [KVNProgress showSuccess];
        }];
    }
//    if (but==_locationBut) {
//        [KVNProgress showWithStatus:@"正在读取位置信息"];
//        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//        CLLocation *loc = [[CLLocation alloc] initWithLatitude:_locManager.location.coordinate.latitude longitude:_locManager.location.coordinate.longitude];
//        [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
//            if(placemarks.count > 0) {
//                CLPlacemark *pMark = [placemarks firstObject];
//                NSLog(@"%@",pMark.name);
//                _locationFiled.text=pMark.name;
//                [KVNProgress showSuccess];
//            }else{
//                [KVNProgress showErrorWithStatus:@"网络请求失败"];
//            }
//        }];
//    }
    if (but==_timeBut) {
          _i=0;
        [self creatTimeView];
        [self creatTimeBut];
    }
    if (but==_downBut) {
        NSString *str=[PhoneNoIsOrNo valiMobile:_noFiled.text];
        if (str!=nil) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }else if (_locationFiled.text.length<1){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请输入小区名与门牌号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        } else if([_timeBut.titleLabel.text isEqualToString:@"请选择服务时间"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请选择服务时间" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }else if(str==nil){
            OrederScanVC *scan=[[OrederScanVC alloc]init];
            if (_nameFiled.text.length<1) {
                scan.name=@"尊敬的客户";
            }else{
            scan.name=_nameFiled.text;
            }
            scan.time=_timeBut.titleLabel.text;
            scan.no=_noFiled.text;
            scan.location=_locationFiled.text;
            scan.sex=_sex;
            scan.price=_price;
            scan.count=_count;
            scan.project=_project;
            scan.barrel=_barrel;
            if (_commentTextView.text.length>0) {
                scan.comment=_commentTextView.text;
            }else{
            scan.comment=@"无";
            }
//            [self.navigationController pushViewController:scan animated:YES];
            [self presentViewController:scan animated:YES completion:^{
            }];
        }
    }
}
-(void)wayfinishBut
{
    if(_i==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [_alplaView removeFromSuperview];
        [_timeView removeFromSuperview];
        [_cancelBut removeFromSuperview];
        NSString *timeStr=[NSString stringWithFormat:@"%@ %@",_dateDic[_indexStr],_timeStr];
        [_timeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_timeBut setTitle:timeStr forState:UIControlStateNormal];
        _dateFutureStr=nil;
    }
}
-(void)wayCancel
{
    [_alplaView removeFromSuperview];
    [_timeView removeFromSuperview];
    [_cancelBut removeFromSuperview];
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    CFStringRef anFullName = ABRecordCopyCompositeName(person);
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,index);
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (anFullName!=nil) {
            _nameFiled.text=(__bridge NSString *)anFullName;
        }
        if (telValue!=nil) {
            NSString *str=(__bridge NSString *)telValue;
            NSArray *arr=[str componentsSeparatedByString:@"-"];
            NSLog(@"%@",str);
            NSString *stt=[arr componentsJoinedByString:@""];
            _noFiled.text=stt;
        }
    }];
}

#pragma mark textFiled的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField==_locationFiled) {
        self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2);
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_locationFiled&&YHEIGHT==480.0) {
         self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2-80);
    }else{
     self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2);
    }
}

-(void)wayBackBut
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"%f",YHEIGHT);
    if (YHEIGHT==568.0) {
        self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2-150);
       
    }else if(YHEIGHT==480.0){
     self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2-190);
    }else{
     self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2-100);
    }
    _commentTextLabel.hidden=YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        _commentTextLabel.hidden=NO;
    }
    self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2);
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
    
    if ([@"\n" isEqualToString:text] == YES) {
        [_commentTextView resignFirstResponder];
        self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2);
        return YES;
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [_nameFiled resignFirstResponder];
    [_noFiled resignFirstResponder];
    [_locationFiled resignFirstResponder];
    [_commentTextView resignFirstResponder];
    self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2);
}
@end
