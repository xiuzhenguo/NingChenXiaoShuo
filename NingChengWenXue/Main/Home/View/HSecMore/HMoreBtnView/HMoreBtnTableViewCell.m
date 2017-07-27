//
//  HMoreBtnTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HMoreBtnTableViewCell.h"
@interface HMoreBtnTableViewCell ()
{
    UIView  * _bgView;
}
@end

@implementation HMoreBtnTableViewCell

+ (HMoreBtnTableViewCell *)setMyTableViewCellWithTableView:(UITableView *)tableView {
    static NSString * cell_id = @"MyId";
    HMoreBtnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[HMoreBtnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
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
    
    NSArray *imgArray = @[@"home_nogridview_phb",@"home_nogridview_fl",@"home_nogridview_wb",@"home_nogridview_xylm",@"home_nogridview_cjh",@"home_nogridview_tuijian"];
    NSArray *titleArray = @[@"排行榜",@"分类",@"完本",@"校园联盟",@"超精华",@"推荐"];
    for (int i = 0; i < 6; i++) {
        // 创建自定义按钮
        UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_click.frame = CGRectMake(i % 4 * ((BXScreenW)/4.0), i / 4 * (55 + 10), (BXScreenW)/4.0, 55);
        // 创建普通状态按钮图片
        [btn_click setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        // 设置按钮普通状态标题
        [btn_click setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn_click setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
        btn_click.titleLabel.font = THIRDFont;
        // 按钮图片和标题总高度
        CGFloat totalHeight = (btn_click.imageView.frame.size.height + btn_click.titleLabel.frame.size.height);
        // 设置按钮图片偏移
        [btn_click setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn_click.imageView.frame.size.height), 0.0, 0.0, -btn_click.titleLabel.frame.size.width)];
        // 设置按钮标题偏移
        [btn_click setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn_click.imageView.frame.size.width, -(totalHeight - btn_click.titleLabel.frame.size.height),0.0)];
        btn_click.tag = 1000 + i;
        // 加载按钮到视图
        [_bgView addSubview:btn_click];
        [btn_click addTarget:self action:@selector(HClickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.height = CGRectGetMaxY(btn_click.frame)+10;
        _bgView.frame = CGRectMake(0, 0, BXScreenW, CGRectGetMaxY(btn_click.frame)+10);
    }
    
}

    
- (void)HClickButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(createUIButtonWithButton:Section:)]) {
        [self.delegate createUIButtonWithButton:sender Section:self.section];
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
