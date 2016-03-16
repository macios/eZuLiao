

#import "UrserNeedKnowVC.h"

@interface UrserNeedKnowVC ()
{
    UILabel *_ceterLabel;
}
@end

@implementation UrserNeedKnowVC


- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [MyBackBut creatBackByTarget:self action:@selector(wayBackBut) showOnView:self.view];
    [MyTitleLabel creatLabelByText:@"用户协议" showOnView:self.view];
    UIImageView *iconView=[[UIImageView alloc]init];
    iconView.center=CGPointMake(XWIDTH/2, 100-5);
    iconView.bounds=CGRectMake(0, 0, 100*0.618, 100*0.618);
    iconView.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:iconView];
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 80+64, XWIDTH-20, YHEIGHT-80-64)];
    scrollView.showsHorizontalScrollIndicator=NO;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, XWIDTH-40, YHEIGHT-80-64)];
    label.numberOfLines = 0;
    //文字的阴影效果
    NSShadow *shaw = [[NSShadow alloc] init];
    shaw.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shaw.shadowOffset = CGSizeMake(10, 10);
    //    (段落)
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 10.0f;
    paragraphStyle.maximumLineHeight = 30.0f;
    paragraphStyle.minimumLineHeight = 10.0f;
    paragraphStyle.alignment = NSTextAlignmentJustified;//设置对齐方式
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.firstLineHeadIndent = 0.0;
    paragraphStyle.headIndent = 0.0;
    paragraphStyle.tailIndent = 20.0;
    paragraphStyle.lineSpacing = 20.0;
    //    paragraphStyle.hyphenationFactor = 3.0;
    /*
     alignment //对齐方式
     firstLineHeadIndent //首行缩进
     headIndent //缩进
     tailIndent  //尾部缩进
     lineBreakMode  //断行方式
     maximumLineHeight  //最大行高
     minimumLineHeight  //最低行高
     lineSpacing  //行距
     paragraphSpacing  //段距
     paragraphSpacingBefore  //段首空间
     baseWritingDirection  //句子方向
     lineHeightMultiple  //可变行高,乘因数。
     hyphenationFactor //连字符属性
     */
    
    //做富文本
    NSMutableAttributedString *attributedText =[[NSMutableAttributedString alloc] initWithString:@"北京\n欢迎您bndahsdlkfjbnklcnbirhiaerksd北京欢迎您rgilebklsfnblshtirus阿斯顿发发呆时范德萨“神奇读心术”解读心理亚健康趋势\n恋爱居然也能导致发胖？\n为什么那么多明星吸毒？几大诀窍抵抗躁郁\n对人体最有害的情绪竟然是……\n总是觉得累的真相北京欢迎您\n^-^北京\n欢迎您bndahsdlkfjbnklcnbirhiaerksd北京欢迎您rgilebklsfnblshtirus阿斯顿发发呆时范德萨“神奇读心术”解读心理亚健康趋势\n恋爱居然也能导致发胖？\n为什么那么多明星吸毒？几大诀窍抵抗躁郁\n对人体最有害的情绪竟然是……\n总是觉得累的真相北京欢迎您\n^-^北京\n欢迎您bndahsdlkfjbnklcnbirhiaerksd北京欢迎您rgilebklsfnblshtirus阿斯顿发发呆时范德萨“神奇读心术”解读心理亚健康趋势\n恋爱居然也能导致发胖？\n为什么那么多明星吸毒？几大诀窍抵抗躁郁\n对人体最有害的情绪竟然是……\n总是觉得累的真相北京欢迎您\n^-^北京\n欢迎您bndahsdlkfjbnklcnbirhiaerksd北京欢迎您rgilebklsfnblshtirus阿斯顿发发呆时范德萨“神奇读心术”解读心理亚健康趋势\n恋爱居然也能导致发胖？\n为什么那么多明星吸毒？几大诀窍抵抗躁郁\n对人体最有害的情绪竟然是……\n总是觉得累的真相北京欢迎您\n^-^北京\n欢迎您bndahsdlkfjbnklcnbirhiaerksd北京欢迎您rgilebklsfnblshtirus阿斯顿发发呆时范德萨“神奇读心术”解读心理亚健康趋势\n恋爱居然也能导致发胖？\n为什么那么多明星吸毒？几大诀窍抵抗躁郁\n对人体最有害的情绪竟然是……\n总是觉得累的真相北京欢迎您\n^-^北京\n欢迎您bndahsdlkfjbnklcnbirhiaerksd北京欢迎您rgilebklsfnblshtirus阿斯顿发发呆时范德萨“神奇读心术”解读心理亚健康趋势\n恋爱居然也能导致发胖？\n为什么那么多明星吸毒？几大诀窍抵抗躁郁\n对人体最有害的情绪竟然是……\n总是觉得累的真相"
                                                                                      attributes:nil];
    
    label.attributedText = attributedText;
    [label sizeToFit];
    [self.view addSubview:scrollView];
    [scrollView addSubview:label];
    scrollView.contentSize=CGSizeMake(CGRectGetWidth(label.frame), CGRectGetHeight(label.frame));
   
}
-(void)wayBackBut
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
