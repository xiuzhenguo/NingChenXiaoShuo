//
//  HClassifyTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HClassifyTableViewCell.h"

@interface HClassifyTableViewCell ()
{
    UIView  * _bgView;
}
@end

@implementation HClassifyTableViewCell

+ (HClassifyTableViewCell *)setMyTableViewCellWithTableView:(UITableView *)tableView {
    static NSString * cell_id = @"MyId";
    HClassifyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[HClassifyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    return cell;
}

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
        TypeListModel *model = arr[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i % 4 * ((BXScreenW - 30)/4.0), i / 4 * (29 + 5), (BXScreenW - 30)/4.0-0.5, 29)];
        [btn setTitle:model.ClassName forState:UIControlStateNormal];
        btn.tag = 1000+i;
        [btn setTitleColor:BXColor(40,40,40) forState:UIControlStateNormal];
        btn.titleLabel.font = FIFFont;
        [_bgView addSubview:btn];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(i % 4 * ((BXScreenW - 30)/4.0)+(BXScreenW - 30)/4.0-0.5, i / 4 * (29 + 5), 0.5, 29)];
        lineLab.backgroundColor = BXColor(195,195,195);
        [_bgView addSubview:lineLab];
        if (i % 4 == 3 && i % 4 != 0) {
            [lineLab removeFromSuperview];
        }
        
        if (i == arr.count - 1) {
            self.height = CGRectGetMaxY(btn.frame)+30;
            _bgView.frame = CGRectMake(15, 15, BXScreenW-30, CGRectGetMaxY(btn.frame));
        }
    }
}

- (void)clickButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(createUIButtonWithTitle:Tag:Section:)]) {
        [self.delegate createUIButtonWithTitle:sender.titleLabel.text Tag:sender.tag Section:self.section];
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
