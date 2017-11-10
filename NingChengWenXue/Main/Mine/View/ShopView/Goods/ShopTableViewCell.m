//
//  ShopTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "GoodsModel.h"

@implementation ShopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self  =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self UIConfigure];
    }
    
    return  self;
    
}
-(void)countOfButton:(NSInteger)count namearray:(NSArray *)dataArray{
    for (UIView * view in _scroll.subviews) {
        [view removeFromSuperview];
    }
    UIButton * firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton = [self viewWithTag:10];
    if (!firstButton) {
        for (int i=0; i<count; i++) {
            UIButton * bookBtn = [[UIButton alloc]init];
            bookBtn.frame = CGRectMake(15+i*88, 15, 80, 100);
            _scroll.contentSize = CGSizeMake(count*88 + 23, 80);
            bookBtn.tag = i+10000;
            
            [bookBtn addTarget:self action:@selector(btnCli:) forControlEvents:1<<6];
            [_scroll addSubview: bookBtn];
            _classBtn = bookBtn;
            
            UILabel * classLab = [[UILabel alloc]initWithFrame:CGRectMake(15+i*88, 120, 80, 15)];
            _classLab = classLab;
            _classLab.font = THIRDFont;
            _classLab.textColor = BXColor(101,101,101);
            [_scroll addSubview: classLab];
            
            UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(15+i*88, 140, 80, 15)];
            _priceLab = priceLab;
            _priceLab.font = FIFFont;
            _priceLab.textColor = BXColor(236,105,65);
            [_scroll addSubview:_priceLab];
            
            GoodsModel *model = dataArray[i];
            NSString *avatarUrlStr = model.ProductImage;
            [_classBtn sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"卡片"]];
            
            _classLab.text = model.ProductName;
            _priceLab.text = [NSString stringWithFormat:@"￥%ld",model.ProductPrice];
            
            
        }
        
    }
}

-(void)UIConfigure{
    
    UILabel *firstLine = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, 0.5)];
    firstLine.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:firstLine];
    
    UIScrollView * scv = [[UIScrollView alloc]initWithFrame:CGRectMake(0.5, 0,BXScreenW, 169.5)];
    scv.showsHorizontalScrollIndicator = NO;
    scv.showsVerticalScrollIndicator = NO;
    _scroll = scv;
    [self.contentView addSubview: scv];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 170, BXScreenW, 10)];
    line.backgroundColor = BXColor(242, 242, 242);
    [self.contentView addSubview:line];
    
}

-(void)btnCli:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(BFCell:didClickBFBtnTag:currentBFBtn:)]) {
        
        [self.delegate BFCell:self didClickBFBtnTag:sender.tag currentBFBtn:sender];
    }
    
    
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
