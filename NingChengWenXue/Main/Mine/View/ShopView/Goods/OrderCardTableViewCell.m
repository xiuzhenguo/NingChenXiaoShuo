//
//  OrderCardTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "OrderCardTableViewCell.h"

@implementation OrderCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void)setUpTableViewCellUI{
    self.firLineLab = [[UILabel alloc] init];
    self.firLineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.firLineLab];
    //图片
    self.cardImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.cardImg];
    //名称
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(101,101,101);
    self.nameLab.numberOfLines = 0;
    [self.contentView addSubview:self.nameLab];
    //价格
    self.priceLab = [[UILabel alloc] init];
    self.priceLab.font = FIFFont;
    self.priceLab.textColor = BXColor(236,105,65);
    self.priceLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.priceLab];
    //数量
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = FIFFont;
    self.numLab.backgroundColor = BXColor(245,245,245);
    self.numLab.textColor = BXColor(40, 40, 40);
    self.numLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.numLab];
    //总数量
    self.allNumLab = [[UILabel alloc] init];
    self.allNumLab.font = FIFFont;
    self.allNumLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.allNumLab];
    //总价格
    self.allPriceLab = [[UILabel alloc] init];
    self.allPriceLab.font = FIFFont;
    [self.contentView addSubview:self.allPriceLab];
    //减少按钮
    self.subBtn = [[UIButton alloc] init];
    self.subBtn.backgroundColor = BXColor(251,251,251);
    [self.subBtn setTitle:@"－" forState:UIControlStateNormal];
    [self.subBtn setTitleColor:BXColor(203,203,203) forState:UIControlStateNormal];
    [self.subBtn addTarget:self action:@selector(clickSubButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.subBtn];
    //增加按钮
    self.addBtn = [[UIButton alloc] init];
    self.addBtn.backgroundColor = BXColor(245,245,245);
    [self.addBtn setTitle:@"＋" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:BXColor(145,145,145) forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addBtn];
    
    self.twoLineLab = [[UILabel alloc] init];
    self.twoLineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.twoLineLab];
    
    self.thiLineLab = [[UILabel alloc] init];
    self.thiLineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.thiLineLab];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = BXColor(242, 242, 242);
    [self.contentView addSubview:self.lineView];
    
}

- (void)setViewModel:(ViewModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    self.firLineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
    
    self.cardImg.frame = CGRectMake(15, 15, 50, 63);
    self.cardImg.image = [UIImage imageNamed:@"商品-数量图"];
    
    self.twoLineLab.frame = CGRectMake(0, 87.5, BXScreenW, 0.5);
    
    self.nameLab.frame = CGRectMake(75, 15, BXScreenW - 195, 63);
    self.nameLab.text = @"的千万花都区我还得去问花都区都不去我海淀区";
    
    self.priceLab.frame = CGRectMake(BXScreenW - 115, 15, 100, 15);
    self.priceLab.text = @"¥ 38";
    
    self.subBtn.frame = CGRectMake(BXScreenW - 107, 53, 28, 25);
    self.addBtn.frame = CGRectMake(BXScreenW - 43, 53, 28, 25);
    self.numLab.frame = CGRectMake(BXScreenW - 77, 53, 32, 25);
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.currentCountNumber];
    
    self.allPriceLab.text = @"合计：￥38";
    CGRect with = Adaptive_Width(self.allPriceLab.text, self.allPriceLab.font);
    self.allPriceLab.frame = CGRectMake(BXScreenW - with.size.width - 15, 88, with.size.width, 43.5);
    
    self.allNumLab.frame = CGRectMake(0, 88, BXScreenW - with.size.width - 25, 43.5);
    self.allNumLab.text = @"共计 2 商品";
    
    self.thiLineLab.frame = CGRectMake(0, 131.5, BXScreenW, 0.5);
    self.lineView.frame = CGRectMake(0, 132, BXScreenW, 5);
}

-(void)clickAddButton{
    self.currentCountNumber++;
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.currentCountNumber];
}

#pragma mark - 减少商品数量按钮的点击事件
-(void)clickSubButton{
    if (self.currentCountNumber <= 1) {
        NSLog(@"超出范围");
    }else{
        self.currentCountNumber = self.currentCountNumber - 1;
    }
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.currentCountNumber];
    NSLog(@"%@",self.numLab.text);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
