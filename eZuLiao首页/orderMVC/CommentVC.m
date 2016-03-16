

#import "CommentVC.h"
#import "MySlider.h"

@interface CommentVC ()<UIScrollViewDelegate,UITextViewDelegate>
{
    UILabel *_oneLabel;
    UIView *_oneView;
    UIButton *_oneOneBut;
    UIButton *_oneTwoBut;
    UIButton *_oneThreeBut;
   
    UILabel *_twoLabel;
    MySlider *_twoSlider;
    
    UILabel *_threeLabel;
    MySlider *_threeSlider;
    
    UILabel *_fourLabel;
    MySlider *_fourSlider;
    
    UISwitch *_switch;
    UIButton *_finishBut;
    
    UITextView *_commentTextView;
    UILabel *_commentPlaceLabel;
    
    int _i;//1表示是，0表示否
    float _aver;//平均数评价值
}
@end

@implementation CommentVC

- (void)creatCommentView {
    _oneLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 80, 20)];
    _oneLabel.text=@"总体评价";
    _oneLabel.textColor=[UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    _oneLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:_oneLabel];
    
    _oneView=[[UIView alloc]init];
    _oneView.center=CGPointMake(XWIDTH/2+35, _oneLabel.center.y);
    _oneView.bounds=CGRectMake(0, 0, XWIDTH*0.55,30);
    _oneView.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _oneView.layer.cornerRadius=CGRectGetHeight(_oneView.frame)/2.0;
    _oneView.clipsToBounds=YES;
    [self.view addSubview:_oneView];
    
    _oneOneBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _oneOneBut.center=CGPointMake(CGRectGetWidth(_oneView.frame)/3/2, CGRectGetHeight(_oneView.frame)/2);
    _oneOneBut.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame)/3, CGRectGetHeight(_oneView.frame));
    _oneOneBut.layer.cornerRadius=CGRectGetHeight(_oneOneBut.frame)/2;
    _oneOneBut.backgroundColor=[UIColor clearColor];
    [_oneOneBut setTitle:@"差评" forState:UIControlStateNormal];
    [_oneOneBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_oneOneBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    _oneOneBut.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [_oneView addSubview:_oneOneBut];
    
    _oneTwoBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _oneTwoBut.center=CGPointMake(CGRectGetWidth(_oneView.frame)/2, CGRectGetHeight(_oneView.frame)/2);
    _oneTwoBut.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame)/3, CGRectGetHeight(_oneView.frame));
    _oneTwoBut.layer.cornerRadius=CGRectGetHeight(_oneOneBut.frame)/2;
    _oneTwoBut.backgroundColor=[UIColor clearColor];
    [_oneTwoBut setTitle:@"中评" forState:UIControlStateNormal];
    [_oneTwoBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_oneTwoBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    _oneTwoBut.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [_oneView addSubview:_oneTwoBut];
    
    _oneThreeBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _oneThreeBut.center=CGPointMake(CGRectGetWidth(_oneView.frame)-CGRectGetWidth(_oneView.frame)/3/2, CGRectGetHeight(_oneView.frame)/2);
    _oneThreeBut.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame)/3, CGRectGetHeight(_oneView.frame));
    _oneThreeBut.layer.cornerRadius=CGRectGetHeight(_oneOneBut.frame)/2;
    _oneThreeBut.backgroundColor=[UIColor blackColor];
    [_oneThreeBut setTitle:@"好评" forState:UIControlStateNormal];
    [_oneThreeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_oneThreeBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    _oneThreeBut.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [_oneView addSubview:_oneThreeBut];
    
    
    
    
    _twoLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_oneLabel.frame)+40, 80, 20)];
    _twoLabel.text=@"手       法";
    _twoLabel.textColor=[UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    _twoLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:_twoLabel];
    
    _twoSlider=[[MySlider alloc]init];
    _twoSlider.center=CGPointMake(_oneView.center.x,_twoLabel.center.y);
    _twoSlider.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame), CGRectGetHeight(_oneView.frame)/4);
    _twoSlider.maximumValue=5.0;
    _twoSlider.value=5.0;
    _twoSlider.continuous=YES;
    _twoSlider.minimumTrackTintColor=[UIColor colorWithRed:197/255.0 green:32/255.0 blue:32/255.0 alpha:1];
    _twoSlider.maximumTrackTintColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [_twoSlider setThumbImage:[UIImage imageNamed:@"plane"] forState:UIControlStateNormal];
    [self.view addSubview:_twoSlider];
    
    _threeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_twoLabel.frame)+40, 80, 20)];
    _threeLabel.text=@"态       度";
    _threeLabel.textColor=[UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    _threeLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:_threeLabel];
    
    _threeSlider=[[MySlider alloc]init];
    _threeSlider.center=CGPointMake(_oneView.center.x,_threeLabel.center.y);
    _threeSlider.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame), CGRectGetHeight(_oneView.frame)/4);
    _threeSlider.maximumValue=5.0;
    _threeSlider.value=5.0;
    _threeSlider.continuous=YES;
    _threeSlider.maximumTrackTintColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _threeSlider.minimumTrackTintColor=[UIColor colorWithRed:103/255.0 green:158/255.0 blue:34/255.0 alpha:1];
    [_threeSlider setThumbImage:[UIImage imageNamed:@"plane——green"] forState:UIControlStateNormal];
    [self.view addSubview:_threeSlider];
    
    _fourLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_threeLabel.frame)+40, 80, 20)];
    _fourLabel.text=@"时       间";
    _fourLabel.textColor=[UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    _fourLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:_fourLabel];
    
    _fourSlider=[[MySlider alloc]init];
    _fourSlider.center=CGPointMake(_oneView.center.x,_fourLabel.center.y);
    _fourSlider.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame), CGRectGetHeight(_oneView.frame)/4);
    _fourSlider.maximumValue=5;
    _fourSlider.continuous=YES;
    _fourSlider.value=5.0;
    _fourSlider.maximumTrackTintColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _fourSlider.minimumTrackTintColor=[UIColor colorWithRed:29/255.0 green:149/255.0 blue:226/255.0 alpha:1];
    [_fourSlider setThumbImage:[UIImage imageNamed:@"plane_blue"] forState:UIControlStateNormal];
    [self.view addSubview:_fourSlider];
    
    _aver=(_fourSlider.value+_threeSlider.value+_twoSlider.value)/3;
    [_twoSlider addTarget:self action:@selector(wayslider:) forControlEvents:UIControlEventValueChanged];
    [_threeSlider addTarget:self action:@selector(wayslider:) forControlEvents:UIControlEventValueChanged];
    [_fourSlider addTarget:self action:@selector(wayslider:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _i=3;
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"评价服务" showOnView:self.view];
    
    [self creatCommentView];
    
//    (YHEIGHT-CGRectGetMaxY(_fourLabel.frame))/2
    
    _finishBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _finishBut.center=CGPointMake(XWIDTH/2,YHEIGHT-32);
    _finishBut.bounds=CGRectMake(0, 0, 100, CGRectGetHeight(_oneView.frame));
    _finishBut.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _finishBut.layer.cornerRadius=CGRectGetHeight(_finishBut.frame)/2;
    [_finishBut setTitle:@"保存" forState:UIControlStateNormal];
    _finishBut.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [_finishBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_finishBut addTarget:self action:@selector(wayFinishBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishBut];
    
    _commentTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_fourLabel.frame)+20, XWIDTH-40, 80)];
    _commentTextView.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    _commentTextView.delegate=self;
    _commentTextView.returnKeyType=UIReturnKeyDone;
    _commentTextView.layer.cornerRadius=10;
    [self.view addSubview:_commentTextView];
    _commentPlaceLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMinY(_commentTextView.frame)+8, XWIDTH, 14)];
    _commentPlaceLabel.text=@"请输入评论内容";
    _commentPlaceLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1];
    [self.view addSubview:_commentPlaceLabel];
    
    _switch=[[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMinX(_commentTextView.frame), CGRectGetMaxY(_commentTextView.frame)+10, 60, 35)];
    _switch.on=NO;
    [_switch addTarget:self action:@selector(waySwitch) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_switch];
    UILabel *switchLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_switch.frame)+10, CGRectGetMinY(_switch.frame), 200, 35)];
    switchLabel.font=[UIFont systemFontOfSize:14];
    switchLabel.numberOfLines=0;
    switchLabel.text=@"下次是否选择这次服务技师\n绿色-是，白色-否";
    [self.view addSubview:switchLabel];
}
-(void)waySwitch{
    if (_switch.on) {
        _i=1;
    }else{
        _i=0;
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _commentPlaceLabel.hidden=YES;
    if(YHEIGHT==480){
      self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2-168);
    }
    if(YHEIGHT==568){
    self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2-60);
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        _commentPlaceLabel.hidden=NO;
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
    [_commentTextView resignFirstResponder];
    self.view.center=CGPointMake(XWIDTH/2, YHEIGHT/2);
}

-(void)wayslider:(UISlider *)sli
{
    [_commentTextView resignFirstResponder];
    _aver=(_fourSlider.value+_threeSlider.value+_twoSlider.value)/3;
    if (_aver>3.5) {
        _oneOneBut.backgroundColor=[UIColor clearColor];
        [_oneOneBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _oneTwoBut.backgroundColor=[UIColor clearColor];
        [_oneTwoBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _oneThreeBut.backgroundColor=[UIColor blackColor];
        [_oneThreeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if(_aver<3.5&&_aver>1.5){
        _oneOneBut.backgroundColor=[UIColor clearColor];
        [_oneOneBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _oneThreeBut.backgroundColor=[UIColor clearColor];
        [_oneThreeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _oneTwoBut.backgroundColor=[UIColor blackColor];
        [_oneTwoBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        _oneTwoBut.backgroundColor=[UIColor clearColor];
        [_oneTwoBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _oneThreeBut.backgroundColor=[UIColor clearColor];
        [_oneThreeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _oneOneBut.backgroundColor=[UIColor blackColor];
        [_oneOneBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
-(void)wayBut:(UIButton *)but
{
    [_commentTextView resignFirstResponder];
    _oneThreeBut.backgroundColor=[UIColor clearColor];
    [_oneThreeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _oneOneBut.backgroundColor=[UIColor clearColor];
    [_oneOneBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _oneTwoBut.backgroundColor=[UIColor clearColor];
    [_oneTwoBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but.backgroundColor=[UIColor blackColor];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (but==_oneOneBut) {
        [UIView animateWithDuration:1 animations:^{
            _fourSlider.value=1.5;
            _twoSlider.value=1.5;
            _threeSlider.value=1.5;
        }];
    }else if(but==_oneTwoBut){
        _fourSlider.value=2.5;
        _twoSlider.value=2.5;
        _threeSlider.value=2.5;
    }else{
        _fourSlider.value=4.5;
        _twoSlider.value=4.5;
        _threeSlider.value=4.5;
    }
    _aver=(_fourSlider.value+_threeSlider.value+_twoSlider.value)/3;
   [_commentTextView resignFirstResponder];
}
-(void)wayFinishBut{
  
   // _aver上传这个值评分
    [KVNProgress show];
    int aver;
    if (_aver>(int)_aver) {
        aver=(int)_aver+1;
    }else{
        aver=_aver;
    }
    if (aver==0) {
        aver=1;
    }
    AppDelegate *app=[[AppDelegate alloc]init];
    app.user=[NSUserDefaults standardUserDefaults];
//192.168.0.101/Api/User/submitComment?&typeid=1&order_number=142684056323&&

    NSMutableDictionary *submitCommentDic=[[NSMutableDictionary alloc]init];
    [submitCommentDic setObject:[app.user objectForKey:@"access"] forKey:@"access_token"];
    [submitCommentDic setObject:[app.user objectForKey:@"myPhoneNumber"] forKey:@"phone"];
    if (_commentTextView.text.length>0) {
        [submitCommentDic setObject:_commentTextView.text forKey:@"content"];
    }
    [submitCommentDic setObject:[NSString stringWithFormat:@"%d",aver] forKey:@"star"];
    if (_i!=3) {
        [submitCommentDic setObject:[NSString stringWithFormat:@"%d",_i] forKey:@"next_same_art"];
    }
    NSLog(@"%@",self.mode.typeid);
    [submitCommentDic setObject:_mode.typeid forKey:@"typeid"];
    [submitCommentDic setObject:_mode.order_number forKey:@"order_number"];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
     manager.requestSerializer.timeoutInterval = 5;
    [manager POST:API_SubmitComment parameters:submitCommentDic success:^(AFHTTPRequestOperation * op, id json) {
        if ([json[@"status"] intValue]==1) {
            [KVNProgress showSuccessWithStatus:@"感谢您的支持"];
        }
        if ([json[@"status"] intValue]==0) {
           [KVNProgress showErrorWithStatus:@"网络异常，请稍后再试"];
        }
    } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
        [KVNProgress showErrorWithStatus:@"网络异常，请稍后再试"];
    }];
}
-(void)wayBackBut{
    [_commentTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
