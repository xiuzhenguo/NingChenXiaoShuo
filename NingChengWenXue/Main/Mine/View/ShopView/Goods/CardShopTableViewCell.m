//
//  CardShopTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CardShopTableViewCell.h"
@interface CardShopTableViewCell ()
{
    UIView  * _bgView;
}
@end

@implementation CardShopTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
    }
    return self;
}

- (void)setArr:(NSArray *)arr {
    _arr = arr;
    for (UIView * view in _bgView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < arr.count; i++) {
//        TypeListModel *model = arr[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15 + i % 4 * ((BXScreenW - 54)/4.0 + 8), i / 4 * 169.5, (BXScreenW - 54)/4.0, 169.5)];
        btn.tag = 1000+i;
        [_bgView addSubview:btn];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, btn.frame.size.width, 100)];
        imgView.backgroundColor = [UIColor whiteColor];
        [btn addSubview:imgView];
        
        UILabel * nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, btn.frame.size.width, 15)];
        nameLab.font = THIRDFont;
        nameLab.textColor = BXColor(101,101,101);
        [btn addSubview: nameLab];
        
        UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, btn.frame.size.width, 15)];
        priceLab.font = FIFFont;
        priceLab.textColor = BXColor(236,105,65);
        [btn addSubview:priceLab];
        
        imgView.image = [UIImage imageNamed:@"卡片"];
        nameLab.text = @"猪八戒经验卡";
        priceLab.text = @"¥ 12";
        
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 169.5+(i/4*169.5), BXScreenW - 30, 0.5)];
        lineLab.backgroundColor = BXColor(195, 195, 195);
        [_bgView addSubview:lineLab];
        
        if (i == arr.count - 1) {
            self.height = CGRectGetMaxY(btn.frame);
            _bgView.frame = CGRectMake(0, 0, BXScreenW, CGRectGetMaxY(btn.frame));
        }
    }
}

- (void)clickButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(createUIButtonWithTitle:Tag:)]) {
        [self.delegate createUIButtonWithTitle:sender.titleLabel.text Tag:sender.tag];
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
