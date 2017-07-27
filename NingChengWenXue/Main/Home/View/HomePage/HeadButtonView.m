//
//  HeadButtonView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/16.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HeadButtonView.h"

@implementation HeadButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpButtonUI];
    }
    return self;
}

#pragma mark - 创建按钮UI
- (void) setUpButtonUI {
    
    CGFloat width = (BXScreenW - 75)/4.0;
    NSArray *imgArray = @[@"home_nogridview_phb",@"home_nogridview_fl",@"home_nogridview_wb",@"home_nogridview_xylm",@"home_nogridview_cjh",@"home_nogridview_tuijian",@"home_nogridview_more"];
    NSArray *titleArray = @[@"排行榜",@"分类",@"完本",@"校园联盟",@"超精华",@"推荐",@"更多"];
    self.btnArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        // 创建自定义按钮
        UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
        // 创建普通状态按钮图片
        [btn_click setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        // 设置按钮普通状态标题
        [btn_click setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn_click setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
        // 按钮坐标和尺寸
        if (i < 4) {
            btn_click.frame = CGRectMake(15 + (width+15)*i, 10, width, 58);
        }else{
            btn_click.frame = CGRectMake(15 + (width+15)*(i-4), 20 + 58, width, 58);
        }
        btn_click.titleLabel.font = THIRDFont;
        // 按钮图片和标题总高度
        CGFloat totalHeight = (btn_click.imageView.frame.size.height + btn_click.titleLabel.frame.size.height);
        // 设置按钮图片偏移
        [btn_click setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn_click.imageView.frame.size.height), 0.0, 0.0, -btn_click.titleLabel.frame.size.width)];
        // 设置按钮标题偏移
        [btn_click setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn_click.imageView.frame.size.width, -(totalHeight - btn_click.titleLabel.frame.size.height),0.0)];
        btn_click.tag = 1000 + i;
        // 加载按钮到视图
        [self addSubview:btn_click];
        [self.btnArray addObject:btn_click];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 145.5, BXScreenW, 0.5)];
    lineView.backgroundColor = BXColor(195, 195, 195);
    [self addSubview:lineView];
}

@end
