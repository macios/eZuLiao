

#import "reserveVC.h"

#import "AFNetworking.h"
#import "ReserceMode.h"
#import "DetailVC.h"
#import "CallBut.h"


@interface reserveVC ()<UIScrollViewDelegate,UIAlertViewDelegate,UIAlertViewDelegate>
{
    UIScrollView *_scroll;
    UIButton *_foreBut;//前图片按钮
    UIButton *_centerBut;//中图片按钮
    UIButton *_endBut;//后图片按钮
    UILabel *_foreNameLabel;
    UILabel *_centerNameLabel;
    UILabel *_endNameLabel;
    UILabel *_foreLabel;
    UILabel *_centerLabel;
    UILabel *_endLabel;
    NSMutableArray *_dataArr;//存储数据
    int _i;
    
    UIButton *_foreCallBut;
    UIButton *_centerCallBut;
    UIButton *_endCallBut;
    
    UIScrollView *_leftRightScrollView;
    MyVisual *_visual;
    
    NSMutableArray *_newsDataMArry;
}
@end

@implementation reserveVC



- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app=[[AppDelegate alloc]init];
    app.user=[NSUserDefaults standardUserDefaults];
//    [app.user setObject:_phoneNoTextFiled.text forKey:@"myPhoneNumber"];
//    [app.user setObject:json[@"content"][@"access_token"] forKey:@"access"]
    NSLog(@"%@ %@",[app.user objectForKey:@"myPhoneNumber"],[app.user objectForKey:@"access"]);
    _i=0;
    _dataArr=[NSMutableArray array];
    NSLog(@"%@",NSHomeDirectory());
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, XWIDTH, YHEIGHT-100-49)];
    _scroll.contentSize=CGSizeMake(XWIDTH, 525+55);
    _scroll.bounces=YES;
    _scroll.showsHorizontalScrollIndicator=NO;
    _scroll.showsVerticalScrollIndicator=NO;
    _scroll.pagingEnabled=NO;
    _scroll.contentOffset=CGPointMake(0, 0);
    _scroll.backgroundColor=[UIColor clearColor];
    
    _leftRightScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, XWIDTH, YHEIGHT-100-49)];
    _leftRightScrollView.contentSize=CGSizeMake(XWIDTH*4, YHEIGHT-100-49);
    _leftRightScrollView.bounces=YES;
    _leftRightScrollView.showsHorizontalScrollIndicator=NO;
    _leftRightScrollView.showsVerticalScrollIndicator=YES;
    _leftRightScrollView.pagingEnabled=YES;
    _leftRightScrollView.contentOffset=CGPointMake(0, 0);
    _leftRightScrollView.delegate=self;
    [self.view addSubview:_leftRightScrollView];
    [_leftRightScrollView addSubview:_scroll];

    
    
    self.view.backgroundColor=[UIColor whiteColor];
    NSData *data=[NSData dataWithContentsOfFile:JSON_PATH];
    NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    for (NSDictionary *dic in dataDic[@"content"]) {
        [_dataArr addObject:dic];
    }
    [self creatDataLabel];
    [self loadData];
    [self creatInforBut];
    [self creatBut];
   
   
}
#pragma mark 加载数据
-(void)loadData
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:API_MAIN parameters:nil success:^(AFHTTPRequestOperation * op, id data) {
        NSLog(@"bbb");
        if (data!=nil) {
            [_dataArr removeAllObjects];
             _dataArr=data[@"content"];
        }
    } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
        NSData *data=[NSData dataWithContentsOfFile:JSON_PATH];
        NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [_dataArr removeAllObjects];
        for (NSDictionary *dic in dataDic[@"content"]) {
            [_dataArr addObject:dic];
        }
           }];
}
#pragma mark 创建界面顶部按钮视图
- (void)creatInforBut {
    /*title*/
    NSArray *arr=@[@"按摩",@"足疗",@"女士",@"会员"];
    for (int i=0; i<4; i++) {
        UIButton *inforButton=[UIButton buttonWithType:UIButtonTypeSystem];
        inforButton.frame=CGRectMake(i*((XWIDTH-80-4*50)/3+50)+40, 50*0.618, 50, 50);
        inforButton.backgroundColor=[UIColor clearColor];
        [inforButton setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        [inforButton setTitle:arr[i] forState:UIControlStateNormal];
        [inforButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i==0) {
            [inforButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [inforButton setBackgroundImage:[UIImage imageNamed:@"index_bg_s"] forState:UIControlStateNormal];
        }
        [inforButton addTarget:self action:@selector(wayButton:) forControlEvents:UIControlEventTouchUpInside];
        inforButton.tag=1000+i;
        [self.view addSubview:inforButton];
    }
}
#pragma mark 创建界面文字视图
- (void)creatDataLabel {
    _foreNameLabel=[MyTitleLabel creatBigLabel:CGPointMake(XWIDTH/2, 260+10-100-30) withBounds:CGRectMake(0, 0, 200, 20) withText:_dataArr[2][@"name"] withFontOfSize:20];
    [_scroll addSubview:_foreNameLabel];
    _foreLabel=[MyTitleLabel creatLabel:CGPointMake(XWIDTH/2, 285+10-100-30) withBounds:CGRectMake(0, 0, 300, 20) withText:_dataArr[2][@"desc"] withFontOfSize:15];
    [_scroll addSubview:_foreLabel];
    
    _centerNameLabel=[MyTitleLabel creatBigLabel:CGPointMake(XWIDTH/2, 370-30) withBounds:CGRectMake(0, 0, 200, 20) withText:_dataArr[3][@"name"] withFontOfSize:20];
    [_scroll addSubview:_centerNameLabel];
    _centerLabel=[MyTitleLabel creatLabel:CGPointMake(XWIDTH/2, 395-30) withBounds:CGRectMake(0, 0, 300, 20) withText:_dataArr[3][@"desc"] withFontOfSize:15];
    [_scroll addSubview:_centerLabel];
    
    _endNameLabel=[MyTitleLabel creatBigLabel:CGPointMake(XWIDTH/2, 570-30) withBounds:CGRectMake(0, 0, 200, 20) withText:_dataArr[7][@"name"] withFontOfSize:20];
    [_scroll addSubview:_endNameLabel];
    _endLabel=[MyTitleLabel creatLabel:CGPointMake(XWIDTH/2, 595-30) withBounds:CGRectMake(0, 0, 300, 20) withText:_dataArr[7][@"desc"] withFontOfSize:15];
    [_scroll addSubview:_endLabel];
}
#pragma mark 创建图片按钮视图
- (void)creatBut {
    /*product
     product_massage_oil 400*260,product_pedicure_ginger*/
    _foreBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _foreBut.center=CGPointMake(XWIDTH/2, 195-100-30);
    _foreBut.bounds=CGRectMake(0, 0, 200, 130);
    [_foreBut setImage:[UIImage imageNamed:@"product_massage_oil"] forState:UIControlStateNormal];
    [_foreBut addTarget:self action:@selector(wayDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_foreBut];

    _centerBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _centerBut.center=CGPointMake(XWIDTH/2, 290-30);
    _centerBut.bounds=CGRectMake(0, 0, 200, 130);
    [_centerBut setImage:[UIImage imageNamed:@"product_massage_taishi-"] forState:UIControlStateNormal];
    [_centerBut addTarget:self action:@selector(wayDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_centerBut];
    
    _endBut=[UIButton buttonWithType:UIButtonTypeCustom];
    _endBut.center=CGPointMake(XWIDTH/2, 500-10-30);
    _endBut.bounds=CGRectMake(0, 0, 200, 130);
    [_endBut setImage:[UIImage imageNamed:@"product_massage_neck-"] forState:UIControlStateNormal];
    [_endBut addTarget:self action:@selector(wayDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_endBut];
    
    _foreCallBut=[CallBut CreatCallButWithFram:CGRectMake(CGRectGetMaxX(_foreBut.frame)/2.5+_foreBut.imageView.image.size.width/2+10,CGRectGetMinY(_foreBut.frame)-_foreBut.imageView.image.size.height/4-5, 100, 100) addTarget:self action:@selector(wayCallBut) onShow:_scroll];
    _centerCallBut=[CallBut CreatCallButWithFram:CGRectMake(CGRectGetMaxX(_centerBut.frame)/2.5+_centerBut.imageView.image.size.width/2+10, CGRectGetMinY(_centerBut.frame)-_centerBut.imageView.image.size.height/4, 100, 100) addTarget:self action:@selector(wayCallBut) onShow:_scroll];
    _endCallBut=[CallBut CreatCallButWithFram:CGRectMake(CGRectGetMaxX(_endBut.frame)/2+_endBut.imageView.image.size.width/2.5+10, CGRectGetMinY(_endBut.frame)-_endBut.imageView.image.size.height/4, 100, 100) addTarget:self action:@selector(wayCallBut) onShow:_scroll];
//    
//    _foreCallBut=[CallBut CreatCallButAddTarget:self action:@selector(wayCallBut) onShow:_foreBut];
//    _centerCallBut=[CallBut CreatCallButAddTarget:self action:@selector(wayCallBut) onShow:_centerBut];
//    _endCallBut=[CallBut CreatCallButAddTarget:self action:@selector(wayCallBut) onShow:_endBut];
//    _foreBut.userInteractionEnabled=YES;
//    _centerBut.userInteractionEnabled=YES;
//    _endBut.userInteractionEnabled=YES;
//    _foreCallBut.userInteractionEnabled=YES;
//    _centerCallBut.userInteractionEnabled=YES;
//    _endCallBut.userInteractionEnabled=YES;
}
-(void)wayCallBut{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"预约热线" message:@"预约、投诉、建议,请拨打热线电话\n\n免费热线:4001606030\n热线时间:周一至周天9:00-22:00" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"拨打", nil];
     _visual=[MyVisual creatVisualOnView:self.view];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001606030"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
    [_visual removeFromSuperview];
}
#pragma mark 创建顶部按钮事件
-(void)wayButton:(UIButton *)but
{
    for (int i=0; i<4; i++) {
        UIButton *button=(UIButton *)[self.view viewWithTag:1000+i];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
    }
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"index_bg_s"] forState:UIControlStateNormal];
    
    _scroll.contentOffset=CGPointMake(0, 0);
   
    _endCallBut.hidden=NO;
    _centerCallBut.hidden=NO;
    _foreCallBut.hidden=NO;
    
    if (but.tag==1000) {
        [_leftRightScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//        _leftRightScrollView.contentOffset=CGPointMake(0, 0);
         _scroll.frame=CGRectMake(0, 0, XWIDTH, YHEIGHT-100-49);
        _scroll.contentSize=CGSizeMake(XWIDTH, 525+55);
        _foreNameLabel.text=_dataArr[2][@"name"];
        _foreLabel.text=_dataArr[2][@"desc"];
        _centerNameLabel.text=_dataArr[3][@"name"];
        _centerLabel.text=_dataArr[3][@"desc"];
        _endNameLabel.text=_dataArr[7][@"name"];
        _endLabel.text=_dataArr[7][@"desc"];
        [_foreBut setImage:[UIImage imageNamed:@"product_massage_oil"] forState:UIControlStateNormal];
        [_centerBut setImage:[UIImage imageNamed:@"product_massage_taishi-"] forState:UIControlStateNormal];
        [_endBut setImage:[UIImage imageNamed:@"product_massage_neck-"] forState:UIControlStateNormal];
        _i=0;
    }
    /*product_pedicure_rose,product_pedicure_mugwort-*/

    else if (but.tag==1001) {
        [_leftRightScrollView setContentOffset:CGPointMake(XWIDTH, 0) animated:YES];
//        _leftRightScrollView.contentOffset=CGPointMake(XWIDTH, 0);
         _scroll.frame=CGRectMake(XWIDTH*1, 0, XWIDTH, YHEIGHT-100-49);
        _scroll.contentSize=CGSizeMake(XWIDTH, 525+55);
        _foreNameLabel.text=_dataArr[4][@"name"];
        _foreLabel.text=_dataArr[4][@"desc"];
        _centerNameLabel.text=_dataArr[1][@"name"];
        _centerLabel.text=_dataArr[1][@"desc"];
        _endNameLabel.text=_dataArr[6][@"name"];
        _endLabel.text=_dataArr[6][@"desc"];
        [_foreBut setImage:[UIImage imageNamed:@"product_pedicure_rose"] forState:UIControlStateNormal];
        [_centerBut setImage:[UIImage imageNamed:@"product_pedicure_ginger"] forState:UIControlStateNormal];
        [_endBut setImage:[UIImage imageNamed:@"product_pedicure_mugwort-"] forState:UIControlStateNormal];
        _i=1;
    }
    /*product_massage_neck-,product_massage_taishi-@2x*/
    else if (but.tag==1002) {
        [_leftRightScrollView setContentOffset:CGPointMake(XWIDTH*2, 0) animated:YES];
//        _leftRightScrollView.contentOffset=CGPointMake(XWIDTH*2, 0);
         _scroll.frame=CGRectMake(XWIDTH*2, 0, XWIDTH, YHEIGHT-100-49);
        _scroll.contentSize=CGSizeMake(XWIDTH, 380);
        _foreNameLabel.text=_dataArr[4][@"name"];
        _foreLabel.text=_dataArr[4][@"desc"];
        _centerNameLabel.text=_dataArr[2][@"name"];
        _centerLabel.text=_dataArr[2][@"desc"];
        _endNameLabel.text=nil;
        _endLabel.text=nil;
        [_foreBut setImage:[UIImage imageNamed:@"big_product_lady_pedicure"] forState:UIControlStateNormal];
        [_centerBut setImage:[UIImage imageNamed:@"product_lady_oil"] forState:UIControlStateNormal];
        [_endBut setImage:nil forState:UIControlStateNormal];
        _i=2;
        _endCallBut.hidden=YES;
    }
    
    else  {
        [_leftRightScrollView setContentOffset:CGPointMake(XWIDTH*3, 0) animated:YES];
         _scroll.frame=CGRectMake(XWIDTH*3, 0, XWIDTH, YHEIGHT-100-49);
//        _leftRightScrollView.contentOffset=CGPointMake(XWIDTH*3, 0);
        _scroll.contentSize=CGSizeMake(XWIDTH, YHEIGHT-100-49);
        _foreNameLabel.text=nil;
        _foreLabel.text=@"敬请期待~~";
        _centerNameLabel.text=nil;
        _centerLabel.text=nil;
        _endNameLabel.text=nil;
        _endLabel.text=nil;
        [_foreBut setImage:[UIImage imageNamed:@"net_connect_delay@2x"] forState:UIControlStateNormal];
        [_centerBut setImage:nil forState:UIControlStateNormal];
        [_endBut setImage:nil forState:UIControlStateNormal];
        _i=3;
        _centerCallBut.hidden=YES;
        _endCallBut.hidden=YES;
    }
}
#pragma mark 页面左右滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [_leftRightScrollView hu_setAnimationWithType:@"cube" subType:@"endProgress" andDuration:0.4];
    _endCallBut.hidden=NO;
    _centerCallBut.hidden=NO;
    _foreCallBut.hidden=NO;
    if (scrollView==_leftRightScrollView) {
        int i=_leftRightScrollView.contentOffset.x/XWIDTH;
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:_scroll cache:YES];
           [UIView commitAnimations];

        for (int j=0; j<4; j++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:1000+j];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"index_bg_n"] forState:UIControlStateNormal];
        }
         UIButton *but=(UIButton *)[self.view viewWithTag:1000+i];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"index_bg_s"] forState:UIControlStateNormal];
        if (i==0) {
            [_leftRightScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            _scroll.frame=CGRectMake(0, 0, XWIDTH, YHEIGHT-100-49);
            _scroll.contentSize=CGSizeMake(XWIDTH, 525+55);
            _foreNameLabel.text=_dataArr[2][@"name"];
            _foreLabel.text=_dataArr[2][@"desc"];
            _centerNameLabel.text=_dataArr[3][@"name"];
            _centerLabel.text=_dataArr[3][@"desc"];
            _endNameLabel.text=_dataArr[7][@"name"];
            _endLabel.text=_dataArr[7][@"desc"];
            [_foreBut setImage:[UIImage imageNamed:@"product_massage_oil"] forState:UIControlStateNormal];
            [_centerBut setImage:[UIImage imageNamed:@"product_massage_taishi-"] forState:UIControlStateNormal];
            [_endBut setImage:[UIImage imageNamed:@"product_massage_neck-"] forState:UIControlStateNormal];
            _i=0;
        }
        /*product_pedicure_rose,product_pedicure_mugwort-*/
        
        else if (i==1) {
            _scroll.frame=CGRectMake(XWIDTH*1, 0, XWIDTH, YHEIGHT-100-49);
            _scroll.contentSize=CGSizeMake(XWIDTH, 525+55);
            _foreNameLabel.text=_dataArr[4][@"name"];
            _foreLabel.text=_dataArr[4][@"desc"];
            _centerNameLabel.text=_dataArr[1][@"name"];
            _centerLabel.text=_dataArr[1][@"desc"];
            _endNameLabel.text=_dataArr[6][@"name"];
            _endLabel.text=_dataArr[6][@"desc"];
            [_foreBut setImage:[UIImage imageNamed:@"product_pedicure_rose"] forState:UIControlStateNormal];
            [_centerBut setImage:[UIImage imageNamed:@"product_pedicure_ginger"] forState:UIControlStateNormal];
            [_endBut setImage:[UIImage imageNamed:@"product_pedicure_mugwort-"] forState:UIControlStateNormal];
            _i=1;
        }
        /*product_massage_neck-,product_massage_taishi-@2x*/
        else if (i==2) {
            _scroll.frame=CGRectMake(XWIDTH*2, 0, XWIDTH, YHEIGHT-100-49);
            _scroll.contentSize=CGSizeMake(XWIDTH, 380);
            _foreNameLabel.text=_dataArr[4][@"name"];
            _foreLabel.text=_dataArr[4][@"desc"];
            _centerNameLabel.text=_dataArr[2][@"name"];
            _centerLabel.text=_dataArr[2][@"desc"];
            _endNameLabel.text=nil;
            _endLabel.text=nil;
            [_foreBut setImage:[UIImage imageNamed:@"big_product_lady_pedicure"] forState:UIControlStateNormal];
            [_centerBut setImage:[UIImage imageNamed:@"product_lady_oil"] forState:UIControlStateNormal];
            [_endBut setImage:nil forState:UIControlStateNormal];
            _i=2;
            _endCallBut.hidden=YES;
        }
        
        else  {
            _scroll.frame=CGRectMake(XWIDTH*3, 0, XWIDTH, YHEIGHT-100-49);

            _scroll.contentSize=CGSizeMake(XWIDTH, YHEIGHT-100-49);
            _foreNameLabel.text=nil;
            _foreLabel.text=@"敬请期待~~";
            _centerNameLabel.text=nil;
            _centerLabel.text=nil;
            _endNameLabel.text=nil;
            _endLabel.text=nil;
            [_foreBut setImage:[UIImage imageNamed:@"net_connect_delay@2x"] forState:UIControlStateNormal];
            [_centerBut setImage:nil forState:UIControlStateNormal];
            [_endBut setImage:nil forState:UIControlStateNormal];
            _i=3;
            _centerCallBut.hidden=YES;
            _endCallBut.hidden=YES;
        }

    }
}

#pragma mark 图片按钮跳转到下一页的方法
-(void)wayDetailButton:(UIButton *)but
{
    if (_i==3) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"别敲我，我会努力的" message:nil delegate:nil cancelButtonTitle:@"安慰一下" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        DetailVC *detailVC=[[DetailVC alloc]init];
        detailVC.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        if (but==_foreBut) {
            if (_i==0) {
                detailVC.name=_dataArr[2][@"name"];
                detailVC.price=[_dataArr[2][@"min_price"] intValue];
                detailVC.imageName=@"product_massage_oil";
            }
            if (_i==1) {
                detailVC.name=_dataArr[4][@"name"];
                detailVC.price=[_dataArr[4][@"min_price"] intValue];
                detailVC.imageName=@"product_pedicure_rose";
            }
            if (_i==2) {
                detailVC.name=_dataArr[4][@"name"];
                detailVC.price=[_dataArr[4][@"min_price"] intValue];
                detailVC.imageName=@"big_product_lady_pedicure";
            }
            [self presentViewController:detailVC animated:YES completion:^{
                
            }];
        }
        else if(but==_centerBut){
            if (_i==0) {
                detailVC.name=_dataArr[3][@"name"];
                detailVC.price=[_dataArr[3][@"min_price"] intValue];
                detailVC.imageName=@"product_massage_taishi-";
            }
            if (_i==1) {
                detailVC.name=_dataArr[1][@"name"];
                detailVC.price=[_dataArr[1][@"min_price"] intValue];
                detailVC.imageName=@"product_pedicure_ginger";
            }
            if (_i==2) {
                detailVC.name=_dataArr[2][@"name"];
                detailVC.price=[_dataArr[2][@"min_price"] intValue];
                detailVC.imageName=@"product_lady_oil";
            }
            [self presentViewController:detailVC animated:YES completion:^{
                
            }];
        }
        else {
            if (_i==0) {
                detailVC.name=_dataArr[7][@"name"];
                detailVC.price=78;
                NSLog(@"%d",detailVC.price);
                detailVC.imageName=@"product_massage_neck-";
                [self presentViewController:detailVC animated:YES completion:^{
                    
                }];
            }
            if (_i==1) {
                detailVC.name=_dataArr[6][@"name"];
                detailVC.price=[_dataArr[6][@"min_price"] intValue];
                detailVC.imageName=@"product_pedicure_mugwort-";
                [self presentViewController:detailVC animated:YES completion:^{
                    
                }];
            }
        }
    }
}


@end
