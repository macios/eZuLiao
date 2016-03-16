

#import "ProjectDetailVC.h"
#import "ProjectDetailMode.h"

@interface ProjectDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIView *_oneView;
    UIButton *_oneBut;
    UIButton *_twoBut;
    UIButton *_threeBut;
    UIButton *_fourBut;
    UITableView *_tableView;
    UIScrollView *_scrollView;
    
    NSMutableArray *_dataArr;
}
@end

@implementation ProjectDetailVC
#pragma mark 创建按钮视图
- (void)creatButView {
    _oneView=[[UIView alloc]initWithFrame:CGRectMake(20, 84, XWIDTH-40, 30)];
    _oneView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    _oneView.layer.cornerRadius=CGRectGetHeight(_oneView.frame)/2.0;
    _oneView.clipsToBounds=YES;
    [self.view addSubview:_oneView];
    
    _oneBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _oneBut.center=CGPointMake(CGRectGetWidth(_oneView.frame)/4/2, CGRectGetHeight(_oneView.frame)/2);
    _oneBut.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame)/4, CGRectGetHeight(_oneView.frame));
    _oneBut.layer.cornerRadius=CGRectGetHeight(_oneBut.frame)/2;
    _oneBut.backgroundColor=[UIColor blackColor];
    [_oneBut setTitle:@"评价" forState:UIControlStateNormal];
    [_oneBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_oneBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    _oneBut.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [_oneView addSubview:_oneBut];
    
    _twoBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _twoBut.center=CGPointMake(CGRectGetWidth(_oneView.frame)/4+CGRectGetWidth(_oneView.frame)/4/2, CGRectGetHeight(_oneView.frame)/2);
    _twoBut.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame)/4, CGRectGetHeight(_oneView.frame));
    _twoBut.layer.cornerRadius=CGRectGetHeight(_twoBut.frame)/2;
    _twoBut.backgroundColor=[UIColor clearColor];
    [_twoBut setTitle:@"服务内容" forState:UIControlStateNormal];
    [_twoBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    [_twoBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    _twoBut.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [_oneView addSubview:_twoBut];
    
    _threeBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _threeBut.center=CGPointMake(CGRectGetWidth(_oneView.frame)/4*2+CGRectGetWidth(_oneView.frame)/4/2, CGRectGetHeight(_oneView.frame)/2);
    _threeBut.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame)/4, CGRectGetHeight(_oneView.frame));
    _threeBut.layer.cornerRadius=CGRectGetHeight(_threeBut.frame)/2;
    _threeBut.backgroundColor=[UIColor clearColor];
    [_threeBut setTitle:@"用户须知" forState:UIControlStateNormal];
    [_threeBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    [_threeBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    _threeBut.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [_oneView addSubview:_threeBut];
    
    _fourBut=[UIButton buttonWithType:UIButtonTypeSystem];
    _fourBut.center=CGPointMake(CGRectGetWidth(_oneView.frame)-CGRectGetWidth(_oneView.frame)/4/2, CGRectGetHeight(_oneView.frame)/2);
    _fourBut.bounds=CGRectMake(0, 0, CGRectGetWidth(_oneView.frame)/4, CGRectGetHeight(_oneView.frame));
    _fourBut.layer.cornerRadius=CGRectGetHeight(_fourBut.frame)/2;
    _fourBut.backgroundColor=[UIColor clearColor];
    [_fourBut setTitle:@"不适宜者" forState:UIControlStateNormal];
    [_fourBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    [_fourBut addTarget:self action:@selector(wayBut:) forControlEvents:UIControlEventTouchUpInside];
    _fourBut.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [_oneView addSubview:_fourBut];
}
#pragma mark 服务内容
- (void)creatTwoLabel {
    UILabel *twoLabel=[[UILabel alloc]initWithFrame:CGRectMake(XWIDTH+20, 20, XWIDTH-40, 0)];
    twoLabel.numberOfLines=0;
    NSDictionary *instructionDic=@{@"1":@"玫瑰：具有滋养子宫、镇静心灵、调节内分泌和改善微循环的功能。同时具有很好的美肤功效，促进黑色素分解，缓解衰老。是爱美女性的不二之选。        \n\n60分钟：包含基本泡脚（10-15分钟）+ 双脚按摩（45-50分钟）。         \n90分钟：包含基本泡脚（10-15分钟）+ 双脚按摩（45-50分钟）+ 肩颈和背部按摩（30分钟）。         \n",
                                   @"2":@"生姜：具有驱寒解表、抵抗邪寒、活血化淤，帮助解决解决怕风、手脚冰凉、“老寒腿”等问题的功效。并且可以刺激毛细血管，改善血液循环和新陈代谢。 \n\n60分钟：包含基本泡脚（10-15分钟）+ 双脚按摩（45-50分钟）。 \nB．90分钟：包含基本泡脚（10-15分钟）+ 双脚按摩（45-50分钟）+ 肩颈和背部按摩（30分钟）。 \n",
                                   @"3":@"草本精油按摩-90分钟：\n使用精纯按摩油透过按摩与穴位的刺激，精油渗入皮肤后能疏通淋巴组织，消除堆积的毒素，帮助分解多余脂肪。促进血液循环、排除多余水分，缓解疲劳和压力。 \n\n按摩部位包含：身体放松，背部，下肢腿部后侧，上身以及腰腹部，手部，下肢腿部前侧。 \n包含精油。",
                                   @"4":@"泰式按摩-90分钟：\n多采用指压手法，着重于四肢和大肌肉群的拉伸和推捏。可以疏通经络，消除疲劳，对于“筋骨”僵硬有很好的改善作用。 \n\n按摩部位包含：下肢腿部前侧，腰腹部，上肢部按摩，下肢腿部后侧，上身以及背部，肩颈和头部。 \n不包含精油。",
                                   @"7":@"艾草泡脚：艾草被称为百草之王，能通十二经，走三阴，理气血，暖子宫，有通经活络，祛除阴寒，消肿敷结等作用。艾叶能祛寒、除湿、温经、抗过敏及抗菌的作用，因现代人普遍寒湿重，所以艾叶就成了我治病不可缺少的帮手。用艾叶水泡脚能有效的祛虚火、寒火，可以治疗门腔溃疡、咽喉肿痛、牙周炎、牙龈炎、中耳炎等头面部反复发作的与虚火、寒火有关的疾病。\n\n60分钟：包含基本泡脚（10-15分钟）+ 双脚按摩（45-50分钟）。 \n90分钟：包含基本泡脚（10-15分钟）+ 双脚按摩（45-50分钟）+ 肩颈和背部按摩（30分钟）。 \n",
                                   @"8":@"肩颈按摩：从头部、脖颈、肩颈、上肢、上背部进行穴位按摩刺激以疏通经络、运行气血，从而达到预防颈椎病、消除疲劳、调整血压、促进睡、增进血液循环、预防亚健康类疾病的功效。是伏案工作人群的不二之选。\n\n两人套餐40分钟：20分钟/每人。\n三人套餐60分钟：20分钟/每人。\n注：套餐也可一个人使用。",};
//    twoLabel.textAlignment=UIViewContentModeTopLeft;
    NSMutableAttributedString *attributedText =[[NSMutableAttributedString alloc] initWithString:instructionDic[_typeId] attributes:nil];
    twoLabel.attributedText=attributedText;
    twoLabel.font=[UIFont systemFontOfSize:14];
    [twoLabel sizeToFit];
    [_scrollView addSubview:twoLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArr=@[].mutableCopy;
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"产品详情" showOnView:self.view];
    
    [self creatButView];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_oneView.frame)+10, XWIDTH, YHEIGHT-CGRectGetMaxY(_oneView.frame))];
    _scrollView.contentSize=CGSizeMake(XWIDTH*4, CGRectGetHeight(_scrollView.frame));
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    
    [self creatTwoLabel];
    
    UILabel *threeLabel=[[UILabel alloc]initWithFrame:CGRectMake(XWIDTH*2+20, 20, XWIDTH-40, 0)];
    threeLabel.numberOfLines=0;
    threeLabel.font=[UIFont systemFontOfSize:14];
    threeLabel.text=@"asdaaaaaaaaaaaaaaaaaaaaaaa";
    [threeLabel sizeToFit];
    [_scrollView addSubview:threeLabel];
    
    UILabel *fourLabel=[[UILabel alloc]initWithFrame:CGRectMake(XWIDTH*3+20, 20, XWIDTH-40, 0)];
    fourLabel.numberOfLines=0;
    fourLabel.font=[UIFont systemFontOfSize:14];
    fourLabel.text=@"bbbbbbbbbbbbbbbbbbb";
    [fourLabel sizeToFit];
    [_scrollView addSubview:fourLabel];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(20, 10, XWIDTH-40, YHEIGHT-CGRectGetMaxY(_oneView.frame)) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.showsVerticalScrollIndicator=NO;
    [_scrollView addSubview:_tableView];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:APT_PROCOM,[_typeId intValue]] parameters:0 success:^(AFHTTPRequestOperation * op, id json) {
        NSArray *arr=json[@"content"];
        for (NSDictionary *dic in arr) {
            ProjectDetailMode *mode=[[ProjectDetailMode alloc]init];
            [mode setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:mode];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation * foo, NSError * error) {
        
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int i=_scrollView.contentOffset.x/XWIDTH;
    [_fourBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    _fourBut.backgroundColor=[UIColor clearColor];
    [_twoBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    _twoBut.backgroundColor=[UIColor clearColor];
    [_threeBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    _threeBut.backgroundColor=[UIColor clearColor];
    [_oneBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    _oneBut.backgroundColor=[UIColor clearColor];
    

    if (i==0) {
        [_oneBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _oneBut.backgroundColor=[UIColor blackColor];
    }else if(i==1){
        [_twoBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _twoBut.backgroundColor=[UIColor blackColor];
    }else if(i==2){
        [_threeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _threeBut.backgroundColor=[UIColor blackColor];
    }else {
        [_fourBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _fourBut.backgroundColor=[UIColor blackColor];
    }
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
    return 70;
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
    ProjectDetailMode *mode=_dataArr[indexPath.row];
    for (int i=0; i<5; i++) {
        UIImageView *starView=[[UIImageView alloc]initWithFrame:CGRectMake(20*i, 15, 15, 15)];
        starView.image=[UIImage imageNamed:@"icon_star_comment_no"];
        [cell.contentView addSubview:starView];
    }
    for (int i=0; i<[mode.star intValue]; i++) {
        UIImageView *starView=[[UIImageView alloc]initWithFrame:CGRectMake(20*i, 15, 15, 15)];
        starView.image=[UIImage imageNamed:@"icon_star_comment_yes"];
        [cell.contentView addSubview:starView];
    }
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, CGRectGetWidth(cell.frame), 40)];
    label.text=mode.content;
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:label];
    
    UILabel *noLabel=[[UILabel alloc]initWithFrame:CGRectMake(XWIDTH/2, 15, XWIDTH/2-40, 15)];
    noLabel.text=mode.phone;
    noLabel.numberOfLines=0;
    noLabel.textAlignment=NSTextAlignmentRight;
    noLabel.font=[UIFont systemFontOfSize:14];
    noLabel.textColor=[UIColor darkGrayColor];
    [cell.contentView addSubview:noLabel];
    return cell;
}
-(void)wayBut:(UIButton *)but
{
    [_fourBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
     _fourBut.backgroundColor=[UIColor clearColor];
    [_twoBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    _twoBut.backgroundColor=[UIColor clearColor];
    [_threeBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    _threeBut.backgroundColor=[UIColor clearColor];
    [_oneBut setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    _oneBut.backgroundColor=[UIColor clearColor];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    but.backgroundColor=[UIColor blackColor];
    if (but==_oneBut) {
        _scrollView.contentOffset=CGPointMake(0, 0);
    }else if(but==_twoBut){
        _scrollView.contentOffset=CGPointMake(XWIDTH, 0);
    }else if(but==_threeBut){
        _scrollView.contentOffset=CGPointMake(XWIDTH*2, 0);
    }else{
        _scrollView.contentOffset=CGPointMake(XWIDTH*3, 0);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, XWIDTH, 20)];
    label.text=@"最新五条评论";
    label.font=[UIFont systemFontOfSize:15];
    return label;
}
-(void)wayBackBut
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
