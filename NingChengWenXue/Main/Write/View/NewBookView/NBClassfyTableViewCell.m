//
//  NBClassfyTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBClassfyTableViewCell.h"

@interface NBClassfyTableViewCell ()
{
    UIView  * _bgView;
}
@end

@implementation NBClassfyTableViewCell

+ (NBClassfyTableViewCell *)setMyTableViewCellWithTableView:(UITableView *)tableView {
    static NSString * cell_id = @"MyId";
    NBClassfyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[NBClassfyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
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
    
    self.lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 0.5)];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [_bgView addSubview:self.lineLab];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 14.5, BXScreenW - 30, 15)];
    self.titleLab.textColor = BXColor(40, 40, 40);
    self.titleLab.font = THIRDFont;
    [_bgView addSubview:self.titleLab];
    
    for (int i = 0; i < arr.count; i++) {
        TypeListModel *model = arr[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15+i % 4 * ((BXScreenW - 60)/4.0+10), 45 + i / 4 * (29 + 10), (BXScreenW - 60)/4.0, 29)];
        [btn setTitle:model.ClassName forState:UIControlStateNormal];
        btn.tag = 1000+i+ self.section *100;

        if (model.IsCheck == YES) {
            btn.backgroundColor = BXColor(236,105,65);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.selected = YES;
        }else{
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:BXColor(101,101,101) forState:UIControlStateNormal];
            btn.selected = NO;
        }
        
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = BXColor(101,101,101).CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = FIFFont;
        [_bgView addSubview:btn];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == arr.count - 1) {
            self.height = CGRectGetMaxY(btn.frame)+15;
            _bgView.frame = CGRectMake(0, 0, BXScreenW, CGRectGetMaxY(btn.frame)+15);
        }
        
    }
}



- (void)clickButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(createUIButtonWithTitle:Section:)]) {
        [self.delegate createUIButtonWithTitle:sender Section:self.section];
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
