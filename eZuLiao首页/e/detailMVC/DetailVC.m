
#import "DetailVC.h"
#import "PhoneNoVC.h"
#import "OrederDetailsVC.h"
#import "ProjectDetailVC.h"

#import "HUDetailButton.h"
@interface DetailVC ()
{
    UIButton *_detailBut;
    UILabel *_ceterLabel;
    UIImageView *_imageView;
    UILabel *_detilLabel;
    UILabel *_priceLabel;
    
    UILabel *_timeLabel;
    UIButton *_timeBut;
    UIButton *_timeLeftBut;
    
    UILabel *_sexLabel;
    UIButton *_sexManBut;
    UIButton *_sexGirlBut;
    UIButton *_sexAnyBut;
    
    UILabel *_amountLabel;
    UIButton *_amountAddBut;
    UIButton *_amountMinusBut;
    UILabel *_amountNumLabel;
    int _amountNum;
    
    UILabel *_tankLabel;
    UIButton *_tankBut;
    UIButton *_tankLeftBut;
    
    UIButton *_downBut;
    
    NSString *_sexStr;
    NSString *_projectStr;
    
    NSString *_barrel;
}
@end

@implementation DetailVC

#pragma mark 创建服务时间按钮视图
- (void)creatTime {
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, YHEIGHT/2, 100, 20)];
    _timeLabel.text=@"服务时间";
    _timeLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:_timeLabel];
    
    _timeBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _timeBut.center=CGPointMake(XWIDTH-45, _timeLabel.center.y);
    _timeBut.bounds=CGRectMake(0, 0, 50, 50);
    [_timeBut setBackgroundImage:[UIImage imageNamed:@"product_selected"] forState:UIControlStateNormal];
    [_timeBut setTitle:@"90分钟" forState:UIControlStateNormal];
    [_timeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBut.titleLabel.font=[UIFont systemFontOfSize:13];
    [_timeBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBut];
    
    _projectStr=@"90分钟";
    _timeLeftBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _timeLeftBut.center=CGPointMake(XWIDTH-45-70, _timeLabel.center.y);
    _timeLeftBut.bounds=CGRectMake(0, 0, 50, 50);
    _timeLeftBut.titleLabel.font=[UIFont systemFontOfSize:13];
    [_timeLeftBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
    [_timeLeftBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [_timeLeftBut setTitle:@"60分钟" forState:UIControlStateNormal];
    [_timeLeftBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeLeftBut.hidden=YES;
    [self.view addSubview:_timeLeftBut];
    if ([_name isEqualToString:@"肩颈按摩"]) {
        [_timeBut setTitle:@"两人套餐\n 40分钟" forState:UIControlStateNormal];
        _timeBut.titleLabel.font=[UIFont systemFontOfSize:11];
        _timeBut.titleLabel.numberOfLines=2;
        [_timeLeftBut setTitle:@"三人套餐\n 60分钟" forState:UIControlStateNormal];
        _timeLeftBut.titleLabel.font=[UIFont systemFontOfSize:11];
        _timeLeftBut.titleLabel.numberOfLines=2;
        _timeLeftBut.hidden=NO;
        _projectStr=@"两人套餐 40分钟";
    }
}

- (void)creatSelectSex {
    _sexLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_timeLabel.frame), CGRectGetMaxY(_timeLabel.frame)+50, 100, 20)];
    _sexLabel.text=@"技师优先";
    _sexLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:_sexLabel];
    
    _sexAnyBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _sexAnyBut.center=CGPointMake(XWIDTH-45, _sexLabel.center.y);
    _sexAnyBut.bounds=CGRectMake(0, 0, 50, 50);
    [_sexAnyBut setBackgroundImage:[UIImage imageNamed:@"product_selected"] forState:UIControlStateNormal];
     _sexAnyBut.titleLabel.font=[UIFont systemFontOfSize:13];
    [_sexAnyBut setTitle:@"不限" forState:UIControlStateNormal];
    [_sexAnyBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sexAnyBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sexAnyBut];
    
    _sexManBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _sexManBut.center=CGPointMake(XWIDTH-45-70, _sexLabel.center.y);
    _sexManBut.bounds=CGRectMake(0, 0, 50, 50);
    [_sexManBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
    [_sexManBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [_sexManBut setTitle:@"男技师" forState:UIControlStateNormal];
     _sexManBut.titleLabel.font=[UIFont systemFontOfSize:13];
    [_sexManBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_sexManBut];
    
    _sexGirlBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _sexGirlBut.center=CGPointMake(XWIDTH-45-70-70, _sexLabel.center.y);
    _sexGirlBut.bounds=CGRectMake(0, 0, 50, 50);
    [_sexGirlBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
    _sexGirlBut.titleLabel.font=[UIFont systemFontOfSize:13];
    [_sexGirlBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [_sexGirlBut setTitle:@"女技师" forState:UIControlStateNormal];
    [_sexGirlBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_sexGirlBut];
}

- (void)creatAmount {
    _amountLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_sexLabel.frame), CGRectGetMaxY(_sexLabel.frame)+50, 100, 20)];
    _amountLabel.text=@"购买数量";
    _amountLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:_amountLabel];
    
    _amountAddBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _amountAddBut.center=CGPointMake(XWIDTH-20-20, _amountLabel.center.y);
    _amountAddBut.bounds=CGRectMake(0, 0, 40, 40);
    [_amountAddBut setBackgroundImage:[UIImage imageNamed:@"icon_plus"] forState:UIControlStateNormal];
    [_amountAddBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_amountAddBut];
    
    _amountNum=1;
    _amountNumLabel=[[UILabel alloc]init];
    _amountNumLabel.center=CGPointMake(CGRectGetMinX(_amountAddBut.frame)-20, _amountAddBut.center.y);
    _amountNumLabel.bounds=CGRectMake(0, 0, 10, 10);
    _amountNumLabel.text=[NSString stringWithFormat:@"%d",_amountNum];
    _amountNumLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_amountNumLabel];
    
    _amountMinusBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _amountMinusBut.center=CGPointMake(_amountNumLabel.center.x-20-20, _amountLabel.center.y);
    _amountMinusBut.bounds=CGRectMake(0, 0, 40, 40);
    [_amountMinusBut setBackgroundImage:[UIImage imageNamed:@"icon_minus"] forState:UIControlStateNormal];
    [_amountMinusBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_amountMinusBut];
    
    _downBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _downBut.center=CGPointMake(XWIDTH/2, YHEIGHT-40);
    _downBut.bounds=CGRectMake(0, 0, 80, 35);
    _downBut.layer.cornerRadius=35/2;
    _downBut.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [_downBut setTitle:@"下一步" forState:UIControlStateNormal];
    [_downBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_downBut addTarget:self action:@selector(wayDownBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downBut];
}
-(void)wayDownBut
{
    AppDelegate *app=[[AppDelegate alloc]init];
    app.user=[NSUserDefaults standardUserDefaults];
    if ([app.user objectForKey:@"myPhoneNumber"]==nil||[app.user objectForKey:@"access"]==nil) {
        PhoneNoVC *phoneNoVC=[[PhoneNoVC alloc]init];
        [self presentViewController:phoneNoVC animated:YES completion:^{
        }];
    }else{
        OrederDetailsVC *orederDetails=[[OrederDetailsVC alloc]init];
        orederDetails.price=[NSString stringWithFormat:@"¥%d",_amountNum*_price];
        orederDetails.count=[NSString stringWithFormat:@"%d",_amountNum];
        NSArray *arr=[_projectStr componentsSeparatedByString:@"\n"];
        NSString *str=[arr
                       componentsJoinedByString:@""];
        orederDetails.project=[NSString stringWithFormat:@"%@ %@",_name,str];
        orederDetails.sex=_sexStr;
        orederDetails.barrel=_barrel;
        NSLog(@"%@",str);
        [self presentViewController:orederDetails animated:YES completion:^{
        }];
    }
    
    NSLog(@"产品:%@  数量:%d  单价:%d  总价:%d",_name,_amountNum,_price,_amountNum*_price);
}
- (void)creatTankView {
    _tankLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, YHEIGHT/2+8, 100, 20)];
    _tankLabel.text=@"足疗浴桶";
    _tankLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:_tankLabel];
    
    _tankBut=[HUDetailButton creatButtonCeter:CGPointMake(XWIDTH-45, _tankLabel.center.y) andTarget:self andAction:@selector(wayBut:) andUpLabelStr:@"自家" andDownLabelStr:nil showLabelView:self.view];
    [_tankBut setBackgroundImage:[UIImage imageNamed:@"product_selected"] forState:UIControlStateNormal];
    _tankLeftBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _tankLeftBut.center=CGPointMake(XWIDTH-45-70, _tankLabel.center.y);
    _tankLeftBut.bounds=CGRectMake(0, 0, 50, 50);
    [_tankLeftBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
    _tankLeftBut.titleLabel.font=[UIFont systemFontOfSize:13];
    [_tankLeftBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    [_tankLeftBut setTitle:@"e足疗" forState:UIControlStateNormal];
    [_tankLeftBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_tankLeftBut];
    
    _timeLabel.center=CGPointMake(_tankLabel.center.x,CGRectGetMinY(_tankLabel.frame)-50);
    _timeBut.center=CGPointMake(XWIDTH-45, _timeLabel.center.y);
    _timeLeftBut.center=CGPointMake(XWIDTH-45-70, _timeLabel.center.y);
    _timeLeftBut.hidden=NO;
    [_timeBut setTitle:@"60分钟" forState:UIControlStateNormal];
    [_timeLeftBut setTitle:@"90分钟" forState:UIControlStateNormal];
    _projectStr=@"60分钟";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _barrel=@"0";
    [self creatHeadView];
    [self creatTime];
    [self creatSelectSex];
    [self creatAmount];
    if([_name isEqualToString:@"玫瑰足疗"]||[_name isEqualToString:@"生姜足疗"]||[_name isEqualToString:@"艾草足疗"])
    {
        [self creatTankView];
    }
    
    
}
-(void)wayBut:(UIButton *)but
{
    int allPrice=_amountNum*_price;
    if (but!=_amountMinusBut&&but!=_amountAddBut) {
        [but setBackgroundImage:[UIImage imageNamed:@"product_selected"] forState:UIControlStateNormal];
    }
    if (but==_timeLeftBut&&[_name isEqualToString:@"肩颈按摩"]) {
        _price=117;
        [_timeBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        _projectStr=_timeLeftBut.titleLabel.text;
        
    }
    if (but==_timeBut&&[_name isEqualToString:@"肩颈按摩"]) {
        _price=78;
        [_timeLeftBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        _projectStr=_timeBut.titleLabel.text;
        
    }
    if (but==_timeLeftBut&&![_name isEqualToString:@"肩颈按摩"]) {
        if (_price==109) {
            _price=159;
        }else{
            _price=149;
        }
        [_timeBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        _projectStr=_timeLeftBut.titleLabel.text;
        
    }
    
    if (but==_timeBut&&![_name isEqualToString:@"肩颈按摩"]) {
        if (_price==159) {
            _price=109;
        }else{
            _price=99;
        }
        if([_name isEqualToString:@"泰式按摩"]){
            _price=239;
        }
        if([_name isEqualToString:@"草本精油按摩"]){
            _price=299;
        }

        [_timeLeftBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        _projectStr=_timeBut.titleLabel.text;
    }
    if (but==_tankBut) {
        if (_price==109) {
            _price=99;
        }if (_price==159) {
            _price=149;
        }
        _barrel=@"0";
        [_tankLeftBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
    }
    if (but==_tankLeftBut) {
        if (_price==99) {
            _price=109;
        }
        if (_price==149) {
            _price=159;
        }
        _barrel=@"1";
        [_tankBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];    }
    if (but==_sexGirlBut) {
        [_sexAnyBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        [_sexManBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        _sexStr=@"女技师";
    }
    if (but==_sexAnyBut) {
        [_sexManBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        [_sexGirlBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        _sexStr=@"不限";
    }
    if (but==_sexManBut) {
        [_sexGirlBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        [_sexAnyBut setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        _sexStr=@"男技师";
    }
    if (but==_amountMinusBut&&_amountNum>=2) {
        _amountNum--;
        _amountNumLabel.text=[NSString stringWithFormat:@"%d",_amountNum];
    }
    if (but==_amountAddBut&&_amountNum<=3) {
        _amountNum++;
        _amountNumLabel.text=[NSString stringWithFormat:@"%d",_amountNum];
    }
    if (allPrice!=_amountNum*_price) {
        [UIView animateWithDuration:0.3*0.618*0.618*0.618 animations:^{
            _priceLabel.text=[NSString stringWithFormat:@"%d元",_amountNum*_price];
            _priceLabel.bounds=CGRectMake(0, 0, 50*1.5, 20*1.5);
            _priceLabel.center=CGPointMake(CGRectGetMaxX(_detilLabel.frame)+20, CGRectGetMaxY(_imageView.frame)-5);
            _priceLabel.font=[UIFont systemFontOfSize:20];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3*0.618*0.618*0.618 animations:^{
                _priceLabel.center=CGPointMake(CGRectGetMaxX(_detilLabel.frame)+20, _detilLabel.center.y);;
                //            _priceLabel.bounds=CGRectMake(0, 0, 50, 20);
                _priceLabel.font=[UIFont systemFontOfSize:14];
            }];
            
        }];
    }
    
}
#pragma mark 创建顶部视图
- (void)creatHeadView {
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    _sexStr=@"不限";
    _detailBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _detailBut.center=CGPointMake(XWIDTH-20-40, 44);
    _detailBut.bounds=CGRectMake(0, 0, 80, 25);
    _detailBut.backgroundColor=[UIColor orangeColor];
    _detailBut.layer.cornerRadius=12.5;
    [_detailBut setTitle:@"产品详情" forState:UIControlStateNormal];
    _detailBut.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    _detailBut.titleLabel.textColor=[UIColor whiteColor];
    _detailBut.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_detailBut addTarget:self action:@selector(wayDetailBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_detailBut];
    
    [MyTitleLabel creatLabelByText:@"选择服务" showOnView:self.view];
    
    _imageView=[[UIImageView alloc]init];
    _imageView.center=CGPointMake(XWIDTH/2, 195-100-30+64);
    _imageView.bounds=CGRectMake(0, 0, 200, 130);
    _imageView.image=[UIImage imageNamed:self.imageName];
     _imageView.bounds=CGRectMake(0, 0, _imageView.image.size.width+10, _imageView.image.size.height);
    if (YHEIGHT==480) {
        _imageView.center=CGPointMake(XWIDTH/2, 195-100-30+40);
//        _imageView.bounds=CGRectMake(0, 0, 200*0.7, 130*0.7);
         _imageView.bounds=CGRectMake(0, 0, (_imageView.image.size.width+10)*0.7, _imageView.image.size.height*0.7);
    }
    [self.view addSubview:_imageView];
   
    
    _detilLabel=[[UILabel alloc]init];
    _detilLabel.center=CGPointMake(XWIDTH/2, CGRectGetMaxY(_imageView.frame)+10);
    _detilLabel.bounds=CGRectMake(0, 0, 100, 20);
    _detilLabel.text=_name;
    _detilLabel.textAlignment=NSTextAlignmentCenter;
    _detilLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:_detilLabel];
    
    _priceLabel=[[UILabel alloc]init];
    _priceLabel.center=CGPointMake(CGRectGetMaxX(_detilLabel.frame)+20, _detilLabel.center.y);
    _priceLabel.bounds=CGRectMake(0, 0, 50*1.5, 20*1.5);
    _priceLabel.text=[NSString stringWithFormat:@"%d元",_price];
    _priceLabel.textAlignment=NSTextAlignmentCenter;
    _priceLabel.textColor=[UIColor orangeColor];
    _priceLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_priceLabel];
}

-(void)wayDetailBut
{
    ProjectDetailVC *proDetailVC=[[ProjectDetailVC alloc]init];
    NSDictionary *typeIdDic=@{@"玫瑰足疗":@"1",
                              @"生姜足疗":@"2",
                              @"草本精油按摩":@"3",
                              @"泰式按摩":@"4",
                              @"艾草足疗":@"7",
                              @"肩颈按摩":@"8"};
    proDetailVC.typeId=typeIdDic[_name];
    proDetailVC.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:proDetailVC animated:YES completion:^{
    }];
}
-(void)wayBackBut
{
    self.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
