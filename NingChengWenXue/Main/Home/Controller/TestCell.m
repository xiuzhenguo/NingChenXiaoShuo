//
//  TestCell.m
//  RefreshTest
//
//  Created by imac on 16/8/12.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}
#pragma mark ==Cell界面初始化布局==
- (void)initView{
    _testLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, BXScreenW-60, 15)];
    [self addSubview:_testLb];
    _testLb.textAlignment = NSTextAlignmentLeft;
    _testLb.font = FIFFont;
    _testLb.textColor = [UIColor orangeColor];

    _testBtn = [[UIButton alloc]initWithFrame:CGRectMake(BXScreenW-35, 5, 20, 20)];
    [self addSubview:_testBtn];
    _testBtn.layer.cornerRadius = 10;
    _testBtn.backgroundColor  = [UIColor lightGrayColor];
    [_testBtn setTitle:@"" forState:UIControlStateNormal];
    [_testBtn setTitle:@"11" forState:UIControlStateSelected];
    [_testBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)choose:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self.delegate  SelectedCell:sender];
//    if (sender.selected) {
//        sender.backgroundColor = [UIColor orangeColor];
//    }else{
//        sender.backgroundColor = [UIColor lightGrayColor];
//    }
}

@end
