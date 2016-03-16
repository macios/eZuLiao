

#import "PhoneNoVC.h"


@interface PhoneNoVC ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UILabel *_ceterLabel;
    UITextField *_phoneNoTextFiled;
    UITextField *_verifyTextiled;
    UIView *_backgroundView;
    
    UIButton *_finishBut;
    UIButton *_convertBut;
    
    int _i;
    NSTimer *_timer;
//    MyVisual *_visual;
}
@end

@implementation PhoneNoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self creatHeadView];
    
    _backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, XWIDTH, YHEIGHT-64)];
    [self.view addSubview:_backgroundView];
    _phoneNoTextFiled=[[UITextField alloc]init];
    _phoneNoTextFiled.center=CGPointMake(XWIDTH/2, 40);
    _phoneNoTextFiled.bounds=CGRectMake(0, 0, XWIDTH-40, 35);
    _phoneNoTextFiled.layer.cornerRadius=CGRectGetHeight(_phoneNoTextFiled.frame)/2;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    _phoneNoTextFiled.leftView=view;
    _phoneNoTextFiled.leftViewMode=UITextFieldViewModeAlways;
    _phoneNoTextFiled.placeholder=@"请输入手机号码";
    _phoneNoTextFiled.font=[UIFont systemFontOfSize:16];
    _phoneNoTextFiled.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _phoneNoTextFiled.returnKeyType=UIReturnKeyDone;
    _phoneNoTextFiled.autocorrectionType=UITextAutocorrectionTypeNo;
    _phoneNoTextFiled.delegate=self;
    _phoneNoTextFiled.clearButtonMode=UITextFieldViewModeAlways;
    _phoneNoTextFiled.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _phoneNoTextFiled.userInteractionEnabled=YES;
    [_backgroundView addSubview:_phoneNoTextFiled];
    
    _convertBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _convertBut.center=CGPointMake(CGRectGetMaxX(_phoneNoTextFiled.frame)-40, _phoneNoTextFiled.center.y);
    _convertBut.bounds=CGRectMake(0, 0, 80, CGRectGetHeight(_phoneNoTextFiled.frame));
    _convertBut.backgroundColor=[UIColor blackColor];
    _convertBut.layer.cornerRadius=CGRectGetHeight(_convertBut.frame)/2;
    [_convertBut setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_convertBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_convertBut addTarget:self action:@selector(wayConvertBut) forControlEvents:UIControlEventTouchUpInside];
    _convertBut.titleLabel.font=[UIFont systemFontOfSize:14];
    [_backgroundView addSubview:_convertBut];
    
    _verifyTextiled=[[UITextField alloc]init];
    _verifyTextiled.center=CGPointMake(XWIDTH/2, CGRectGetMaxY(_phoneNoTextFiled.frame)+20+CGRectGetHeight(_phoneNoTextFiled.frame)/2);
    _verifyTextiled.bounds=CGRectMake(0, 0, XWIDTH-40, 35);
    _verifyTextiled.layer.cornerRadius=CGRectGetHeight(_verifyTextiled.frame)/2;
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    _verifyTextiled.leftView=view1;
    _verifyTextiled.leftViewMode=UITextFieldViewModeAlways;
    _verifyTextiled.placeholder=@"请输入验证码";
    _verifyTextiled.font=[UIFont systemFontOfSize:16];
    _verifyTextiled.keyboardType=UIKeyboardTypeDefault;
    _verifyTextiled.returnKeyType=UIReturnKeyDone;
    _verifyTextiled.autocorrectionType=UITextAutocorrectionTypeNo;
    _verifyTextiled.delegate=self;
    _verifyTextiled.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _verifyTextiled.userInteractionEnabled=YES;
    [_backgroundView addSubview:_verifyTextiled];
    
    _finishBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _finishBut.center=CGPointMake(XWIDTH/2, CGRectGetMaxY(_verifyTextiled.frame)+20+CGRectGetHeight(_verifyTextiled.frame)/2);
    _finishBut.bounds=CGRectMake(0, 0, 80,CGRectGetHeight(_verifyTextiled.frame));
    _finishBut.backgroundColor=[UIColor lightGrayColor];
    _finishBut.layer.cornerRadius=CGRectGetHeight(_verifyTextiled.frame)/2;
    [_finishBut setTitle:@"确定" forState:UIControlStateNormal];
    [_finishBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_finishBut addTarget:self action:@selector(wayFinishBut) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_finishBut];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==_phoneNoTextFiled) {
        [_phoneNoTextFiled resignFirstResponder];
    }else{
        [_verifyTextiled resignFirstResponder];
    }
    return YES;
}
-(void)handleTimer
{
    _i--;
    [_convertBut setTitle:[NSString stringWithFormat:@"%d 秒",_i] forState:UIControlStateNormal];
    _convertBut.backgroundColor=[UIColor lightGrayColor];
    if (_i <= 0) { // 当i<=0了，停止Timer
        [_timer invalidate];
        //        return;
        _convertBut.enabled=YES;
        _phoneNoTextFiled.enabled=YES;
        _convertBut.backgroundColor=[UIColor blackColor];
        [_convertBut setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timer fire];
    }
}
-(void)wayConvertBut
{
    NSString *str=[PhoneNoIsOrNo valiMobile:_phoneNoTextFiled.text];
    [_phoneNoTextFiled resignFirstResponder];
    [_verifyTextiled resignFirstResponder];
    if (str.length>0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        _convertBut.enabled=NO;
        _phoneNoTextFiled.enabled=NO;
        _i=60;
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSString *urlStr=[NSString stringWithFormat:API_VerifyCode,_phoneNoTextFiled.text];
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * op, id json) {
            NSLog(@"===========%@",json);
            if ([json[@"status"] intValue]==1) {
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"已成功发送,请查看短信并输入验证码" message:nil delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
                //                [alert show];
                [KVNProgress showSuccessWithStatus:@"已成功发送，请查看短信" onView:_backgroundView];
            }
            if([json[@"status"] intValue]!=1)
            {
                [KVNProgress showError];
                UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"获取失败,请重新点击获取" message:nil delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
                [aler show];
                
            }
        } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
            
        }];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    [_visual removeFromSuperview];
}
-(void)wayFinishBut
{
    
    
    //            NSLog(@"%@",[app.user objectForKey:@"myPhoneNumber"]);
    //        if ([app.user objectForKey:@"myPhoneNumber"]!=nil&&[app.user objectForKey:@"access"]!=nil) {
    if (_verifyTextiled.text.length<1||_phoneNoTextFiled.text.length<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"请填写完整" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSString *urlStr=[NSString stringWithFormat:API_CheckVC,_phoneNoTextFiled.text,_verifyTextiled.text];
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * op, id json) {
            NSLog(@"***********%@",json);
            NSLog(@"aaa=%@",json[@"content"] );
            if ([json[@"content"] isKindOfClass:[NSDictionary class]]) {
                NSLog(@"bbb=%@",json[@"content"][@"access_token"]);
            }
            
            if ([json[@"status"] intValue]==1) {
                AppDelegate *app=[[AppDelegate alloc]init];
                app.user=[NSUserDefaults standardUserDefaults];
                [app.user setObject:_phoneNoTextFiled.text forKey:@"myPhoneNumber"];
                [app.user setObject:json[@"content"][@"access_token"] forKey:@"access"];
                [app.user synchronize];
                UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"注册成功" message:nil delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
                [aler show];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                
                
                UIAlertView *aler=[[UIAlertView alloc]initWithTitle:json[@"content"] message:nil delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
                [aler show];
            }
        } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
            
        }];
        
    }

}

- (void)creatHeadView {
   [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
   [MyTitleLabel creatLabelByText:@"手机验证" showOnView:self.view];
}

-(void)wayBackBut
{
   [self dismissViewControllerAnimated:YES completion:^{
    
   }];
}

@end
