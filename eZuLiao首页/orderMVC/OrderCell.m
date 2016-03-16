
#import "OrderCell.h"

@implementation OrderCell
{
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UILabel *_statusLabel;
    UILabel *_timeLabel;
    UIImageView *_timeImageView;
    UILabel *_priceAndMinuteLabel;
    UIImageView *_priceImageView;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
        
    }
    return self;
}
-(void)creatUI
{
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame)+10, 10, 270*0.35,210*0.3)];
    
    [self.contentView addSubview:_imageView];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, CGRectGetMinY(_imageView.frame), 200, 20)];
    _nameLabel.font=[UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_nameLabel];
    
    _statusLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame)-100, CGRectGetMinY(_nameLabel.frame), 50, 20)];
    _statusLabel.font=[UIFont systemFontOfSize:12];
    _statusLabel.textColor=[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    _statusLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_statusLabel];
    
    
    _timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame)+5+3, 15,15)];
    [self.contentView addSubview:_timeImageView];
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_timeImageView.frame)+5, CGRectGetMaxY(_nameLabel.frame)+5, 200, 20)];
    _timeLabel.font=[UIFont systemFontOfSize:12];
    _timeLabel.textColor=[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    [self.contentView addSubview:_timeLabel];
    
    _priceImageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_timeLabel.frame)+3, 15,15)];
    [self.contentView addSubview:_priceImageView];
    
    
    _priceAndMinuteLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_priceImageView.frame)+5, CGRectGetMaxY(_timeLabel.frame), 200, 20)];
    _priceAndMinuteLabel.font=[UIFont systemFontOfSize:12];
    _priceAndMinuteLabel.textColor=[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    [self.contentView addSubview:_priceAndMinuteLabel];
    
}
-(void)setModel:(OrderMode *)model
{
    NSDictionary *pictureDic=@{@"草本精油按摩":@"product_massage_oil",
                               @"泰式按摩":@"product_massage_taishi-",
                               @"肩颈按摩":@"product_massage_neck-",
                               @"玫瑰足疗":@"product_pedicure_rose",
                               @"生姜足疗":@"product_pedicure_ginger",
                               @"艾草足疗":@"product_pedicure_mugwort-",};
    
    NSDictionary *statusDic=@{@"0":@"预定",
                              @"1":@"已受理",
                              @"2":@"已取消",
                              @"3":@"已完成",
                              @"4":@"进行中"};
    
    _model=model;
    _imageView.image=[UIImage imageNamed:pictureDic[model.type_name]];
    
    _timeImageView.image=[UIImage imageNamed:@"order_time"];
    _priceImageView.image=[UIImage imageNamed:@"order_price"];
    _nameLabel.text=model.type_name;
    
    _timeLabel.text=model.time;
    
    _priceAndMinuteLabel.text=[NSString stringWithFormat:@"总价¥:%@元/时间:%@分钟",model.total_price,model.minute];
    if ([model.status isEqualToString: @"0"]||[model.status isEqualToString: @"1"]||[model.status isEqualToString: @"2"]||[model.status isEqualToString: @"3"]||[model.status isEqualToString: @"4"]) {
        _statusLabel.text=[NSString stringWithFormat:@"%@",statusDic[model.status]];
        _statusLabel.backgroundColor=[UIColor whiteColor];
    }
    if ([model.status isEqualToString: @"3"]&&model.has_comment==false) {
        _statusLabel.text=[NSString stringWithFormat:@"%@",@"待评价"];
        _statusLabel.backgroundColor=[UIColor orangeColor];
        _statusLabel.textColor=[UIColor whiteColor];
        _statusLabel.layer.cornerRadius=CGRectGetHeight(_statusLabel.frame)/2;
        _statusLabel.clipsToBounds=YES;
    }
    if ([model.status isEqualToString: @"0"]||[model.status isEqualToString: @"1"]||[model.status isEqualToString: @"4"]) {
        _statusLabel.backgroundColor=[UIColor orangeColor];
        _statusLabel.textColor=[UIColor whiteColor];
        _statusLabel.layer.cornerRadius=CGRectGetHeight(_statusLabel.frame)/2;
        _statusLabel.clipsToBounds=YES;
    }
}


- (void)awakeFromNib {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
