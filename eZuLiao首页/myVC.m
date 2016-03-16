

#import "myVC.h"
#import "AppDelegate.h"
#import "PhoneNoVC.h"
#import "preferentialVC.h"

@interface myVC ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *_nameFiled;
    UILabel *_nameLabel;
    
    UIButton *_imageBut;
    UILabel *_imageLabel;
    UITableView *_tableView;
    UIButton *_phoneNoBut;
    UIImageView *_phoneImageView;
    
    UIView *_alplaView;
    UIView *_locationView;
    UIButton *_cancelbut;
    UILabel *_promptLabel;
    UITextField *_locationTextFiled;
    UITextField *_numTextFiled;
    UIButton *_finishBut;
    
    MyVisual *_visual;
}
@property(strong,nonatomic)UIImagePickerController *picker;
@property(nonatomic,strong)AppDelegate *app;
@property(nonatomic,strong)UIView *ceterView;
@end

@implementation myVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _app=[[AppDelegate alloc]init];
    _app.user=[NSUserDefaults standardUserDefaults];
    [self creatLocationAndPreferential];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==_locationTextFiled) {
        [_locationTextFiled resignFirstResponder];
        [_numTextFiled becomeFirstResponder];
    }
    if (textField==_numTextFiled) {
        [_numTextFiled resignFirstResponder];
        if (YHEIGHT==480) {
            _cancelbut.center=CGPointMake(XWIDTH/2, CGRectGetMinY(_locationView.frame));
        }
    }
    if (textField==_nameFiled) {
        [_nameFiled resignFirstResponder];
    }
    return YES;

}

#pragma mark 我的地址与优惠劵
- (void)creatLocationAndPreferential {
    [self creatPhotoImageView];
    [self creatNameAndNumTextFiled];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_phoneNoBut.frame)+60, XWIDTH, 83)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    [self.view addSubview:_tableView];
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(55, CGRectGetMinY(_tableView.frame)-1, XWIDTH, 1)];
    lineView.backgroundColor=[UIColor blackColor];
    lineView.alpha=0.1;
    [self.view addSubview:lineView];
    
    _alplaView=[[UIView alloc]initWithFrame:self.view.bounds];
    _alplaView.backgroundColor=[UIColor blackColor];
    _alplaView.hidden=YES;
    _alplaView.alpha=0.5;
    [self.view addSubview:_alplaView];
    _locationView=[[UIView alloc]initWithFrame:CGRectMake(20, 0.2*YHEIGHT, XWIDTH-40, 0.618*YHEIGHT-20)];
    _locationView.layer.cornerRadius=10;
    _locationView.clipsToBounds=YES;
    _locationView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_locationView];
    _locationView.hidden=YES;
    _cancelbut=[UIButton buttonWithType:UIButtonTypeCustom];
    _cancelbut.center=CGPointMake(XWIDTH/2, CGRectGetMinY(_locationView.frame));
    _cancelbut.bounds=CGRectMake(0, 0, 41, 41);
    _cancelbut.hidden=YES;
    [_cancelbut setImage:[UIImage imageNamed:@"icon_cancel"] forState:UIControlStateNormal];
    [_cancelbut addTarget:self action:@selector(wayCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelbut];
    
    _promptLabel=[[UILabel alloc]init];
    _promptLabel.center=CGPointMake((XWIDTH-40)/2, 0+40);
    _promptLabel.bounds=CGRectMake(0, 0, 100, 20);
    _promptLabel.text=@"填写地址";
    _promptLabel.textAlignment=NSTextAlignmentCenter;
    _promptLabel.font=[UIFont systemFontOfSize:14];
    [_locationView addSubview:_promptLabel];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    _locationTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_promptLabel.frame)+20, CGRectGetWidth(_locationView.frame)-20, 40)];
    _locationTextFiled.placeholder=@"请输入小区名";
    _locationTextFiled.leftView=view1;
    _locationTextFiled.leftViewMode = UITextFieldViewModeAlways;
    _locationTextFiled.autocapitalizationType=UITextAutocorrectionTypeNo;
    _locationTextFiled.clearButtonMode=UITextFieldViewModeAlways;
    _locationTextFiled.clearsOnBeginEditing=YES;
    _locationTextFiled.delegate=self;
    _locationTextFiled.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _locationTextFiled.layer.cornerRadius=CGRectGetHeight(_locationTextFiled.frame)/2;
    NSString *locationStr=[_app.user objectForKey:@"location"];
    if (locationStr.length>0) {
        _locationTextFiled.text=locationStr;
    }
    [_locationView addSubview:_locationTextFiled];
    
     UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    _numTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_locationTextFiled.frame)+20, CGRectGetWidth(_locationView.frame)-20, 40)];
    _numTextFiled.placeholder=@"请输入门牌号";
    _numTextFiled.leftView=view2;
    _numTextFiled.leftViewMode = UITextFieldViewModeAlways;
    _numTextFiled.autocapitalizationType=UITextAutocorrectionTypeNo;
    _numTextFiled.clearButtonMode=UITextFieldViewModeAlways;
    _numTextFiled.clearsOnBeginEditing=YES;
    _numTextFiled.backgroundColor=[[UIColor alloc]initWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _numTextFiled.delegate=self;
    _numTextFiled.layer.cornerRadius=CGRectGetHeight(_numTextFiled.frame)/2;
    _numTextFiled.returnKeyType=UIReturnKeyDone;
    NSString *noStr=[_app.user objectForKey:@"doorNo"];
    if (noStr.length>0) {
        _numTextFiled.text=noStr;
    }
    [_locationView addSubview:_numTextFiled];
    
    _finishBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _finishBut.center=CGPointMake((XWIDTH-40)/2, CGRectGetHeight(_locationView.frame)-40);
    _finishBut.bounds=CGRectMake(0, 0, 60, 30);
    _finishBut.backgroundColor=[UIColor blackColor];
    _finishBut.layer.cornerRadius=15;
    _finishBut.clipsToBounds=YES;
    [_finishBut setTitle:@"保存" forState:UIControlStateNormal];
    [_finishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_finishBut addTarget:self action:@selector(wayfinishBut) forControlEvents:UIControlEventTouchUpInside];
    [_locationView addSubview:_finishBut];
    
    if (YHEIGHT==480) {
        _cancelbut.center=CGPointMake(XWIDTH/2, CGRectGetMinY(_locationView.frame)-50);
        _locationView.frame=CGRectMake(20, 0.2*YHEIGHT-50, XWIDTH-40, 0.618*YHEIGHT-20);
    }

}
-(void)wayCancel
{
    [_locationTextFiled resignFirstResponder];
    [_numTextFiled resignFirstResponder];
    
    _cancelbut.hidden=YES;
    _alplaView.hidden=YES;
    _locationView.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;
}
-(void)wayfinishBut
{
    if (_locationTextFiled.text.length>0) {
        [_app.user setObject:_locationTextFiled.text forKey:@"location"];
        [_app.user synchronize];
    }
    if (_numTextFiled.text.length>0) {
        [_app.user setObject:_numTextFiled.text forKey:@"doorNo"];
        [_app.user synchronize];
    }
    _cancelbut.hidden=YES;
    _alplaView.hidden=YES;
    _locationView.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"iden"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iden"];
    }
    if (indexPath.row==0) {
        cell.imageView.image=[UIImage imageNamed:@"profile_coupon"];
        cell.textLabel.text=@"优惠劵";
    }
    if (indexPath.row==1) {
        cell.imageView.image=[UIImage imageNamed:@"profile_position"];
        cell.textLabel.text=@"我的地址";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     [_nameFiled resignFirstResponder];
    if (indexPath.row==0) {
        preferentialVC *pro=[[preferentialVC alloc]init];
        pro.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:pro animated:YES completion:^{
            
        }];
    }
    if (indexPath.row==1) {
        _cancelbut.center=CGPointMake(XWIDTH/2, CGRectGetMinY(_locationView.frame));
        _cancelbut.hidden=NO;
        _alplaView.hidden=NO;
        _locationView.hidden=NO;
        self.tabBarController.tabBar.hidden=YES;
    }
}
#pragma mark 传头像并且保存头像位置
- (void)creatPhotoImageView {
    UILabel *ceter=[[UILabel alloc]init];
    ceter.center=CGPointMake(XWIDTH/2, 44);
    ceter.bounds=CGRectMake(0, 0, 100, 30);
    ceter.text=@"个人中心";
    ceter.textAlignment=NSTextAlignmentCenter;
    ceter.font=[UIFont boldSystemFontOfSize:18];
    [self.view addSubview:ceter];
    
    _imageBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _imageBut.center=CGPointMake(XWIDTH/2, 104);
    _imageBut.bounds=CGRectMake(0, 0, 64, 64);
    _imageBut.backgroundColor=[UIColor darkGrayColor];
    _imageBut.layer.cornerRadius=32;
    _imageBut.clipsToBounds=YES;
    _imageBut.userInteractionEnabled=YES;
    [_imageBut setBackgroundImage:[UIImage imageNamed:@"bg_image"] forState:UIControlStateNormal];
    [_imageBut addTarget:self action:@selector(wayImageBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imageBut];
    
       UIImage *image = [UIImage imageWithData:[_app.user objectForKey:@"myHead"]];
    if (image) {
        [_imageBut setImage:image forState:UIControlStateNormal];
    }
 }

-(void)wayImageBut
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"添加后可拖动" message:@"请选择上传方式" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册", nil];
    _visual=[MyVisual creatVisualOnView:self.view];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_visual removeFromSuperview];
   
    if (buttonIndex==1) {
         [KVNProgress showWithStatus:@"正在进入相册"];
        _picker=[[UIImagePickerController alloc]init];
        _picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.delegate=self;
        [self presentViewController:_picker animated:YES completion:^{
            [KVNProgress showSuccessWithStatus:@"进入成功"];
        }];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    //png格式转为data
    NSData *data = UIImagePNGRepresentation(image);
    //jpg格式转为data
    NSData *data1 = UIImageJPEGRepresentation(image, 0.8);
    if (data) {
         [_app.user setObject:data forKey:@"myHead"];
    }
    if (data1) {
         [_app.user setObject:data1 forKey:@"myHead"];
    }
    [_app.user synchronize];

    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:1000];
    imageView.image=image;
    [self creatPhotoImageView];

    [self dismissViewControllerAnimated:YES completion:^{}];
    [self creatLocationAndPreferential];
}
- (void)creatPhoneNoLabel {
    NSString *phoneNoStr=[_app.user objectForKey:@"myPhoneNumber"];
    if (phoneNoStr.length>0) {
        [_phoneNoBut setTitle:phoneNoStr forState:UIControlStateNormal];
        [_phoneNoBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }else{
        [_phoneNoBut setTitle:@"请输入号码" forState:UIControlStateNormal];
    }
}

#pragma mark 注册名字与号码
- (void)creatNameAndNumTextFiled {
    //姓名
    _nameFiled=[[UITextField alloc]init];
    _nameFiled.center=CGPointMake(XWIDTH/2, CGRectGetMaxY(_imageBut.frame)+20);
    _nameFiled.bounds=CGRectMake(0, 0, 115, 20);
    _nameFiled.font=[UIFont systemFontOfSize:16];
    _nameFiled.textAlignment=NSTextAlignmentCenter;
    _nameFiled.borderStyle=UITextBorderStyleRoundedRect;
    _nameFiled.keyboardType=UIKeyboardTypeDefault;
    _nameFiled.returnKeyType=UIReturnKeyDone;
    _nameFiled.autocorrectionType=UITextAutocorrectionTypeNo;
    _nameFiled.delegate=self;
    _nameFiled.tag=1100;
    _nameFiled.userInteractionEnabled=YES;
    [self.view addSubview:_nameFiled];
    
    _nameLabel=[[UILabel alloc]init];
    _nameLabel.center=CGPointMake(118/2, 22/2);
    _nameLabel.bounds=CGRectMake(0, 0, 118, 22);
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    if ([_app.user objectForKey:@"myName"]) {
        _nameLabel.text=[_app.user objectForKey:@"myName"];
        _nameFiled.placeholder=nil;
    }
    _nameLabel.backgroundColor=[UIColor whiteColor];
    [_nameFiled addSubview:_nameLabel];
    if (_nameLabel.text.length<1)
        _nameFiled.placeholder=@"添加昵称";
    //号码
    _phoneNoBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _phoneNoBut.center=CGPointMake(XWIDTH/2, CGRectGetMaxY(_nameFiled.frame)+20);
    _phoneNoBut.bounds=CGRectMake(0, 0, 115, 20);
    _phoneNoBut.titleLabel.font=[UIFont systemFontOfSize:16];
    _phoneNoBut.titleLabel.textAlignment=NSTextAlignmentCenter;
    _phoneNoBut.backgroundColor=[UIColor clearColor];
    [_phoneNoBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [_phoneNoBut addTarget:self action:@selector(wayPhoneNoBut) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:_phoneNoBut];
    
}
-(void)wayPhoneNoBut
{
    PhoneNoVC *phon=[[PhoneNoVC alloc]init];
    phon.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:phon animated:YES completion:^{
        
    }];
}
//键盘出现时调用
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_nameFiled.editing) {
        _nameLabel.text=nil;
        _nameFiled.placeholder=@"请输入昵称";
    }

}
//键盘收回时调用
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==_nameFiled) {
        [_app.user setObject:_nameFiled.text forKey:@"myName"];
        [_app.user synchronize];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nameFiled resignFirstResponder];
    [_numTextFiled resignFirstResponder];
    [_locationTextFiled resignFirstResponder];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        cell.frame=CGRectMake(XWIDTH, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        [UIView animateWithDuration:1*0.618 animations:^{
            cell.frame=CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        }];
    }
    if (indexPath.row==1) {
        cell.frame=CGRectMake(XWIDTH, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        [UIView animateWithDuration:2*0.618*0.618 animations:^{
            cell.frame=CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        }];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self creatPhoneNoLabel];
    [_tableView reloadData];
}



@end
