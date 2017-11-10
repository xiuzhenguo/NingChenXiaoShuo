//
//  OrderHeader.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "OrderHeader.h"

@implementation OrderHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUPHeaderViewUI];
    }
    return self;
}

-(void)setUPHeaderViewUI{
    // 图片
    self.addImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 40, 15, 20)];
    self.addImg.image = [UIImage imageNamed:@"确认订单_地址"];
    [self addSubview:self.addImg];
    //收货人
    self.perpleLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 17, BXScreenW - 165, 15)];
    self.perpleLab.font = FIFFont;
    self.perpleLab.textColor = BXColor(101,101,101);
    [self addSubview:self.perpleLab];
    //电话号码
    self.phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW - 115, 17, 100, 15)];
    self.phoneLab.font = FIFFont;
    self.phoneLab.textColor = BXColor(101,101,101);
    [self addSubview:self.phoneLab];
    //更多符号
    self.moreLab = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW - 20, 42, 20, 15)];
    self.moreLab.font = FIFFont;
    self.moreLab.textColor = BXColor(101,101,101);
    self.moreLab.text = @">";
    [self addSubview:self.moreLab];
    //地址
    self.addressLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 42, BXScreenW - 75, 40)];
    self.addressLab.font = FIFFont;
    self.addressLab.textColor = BXColor(101,101,101);
    self.addressLab.numberOfLines = 0;
    [self addSubview:self.addressLab];
    //分隔图
    self.lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addressLab.frame)+17, BXScreenW, 5)];
    self.lineImg.image = [UIImage imageNamed:@"确认订单_分割线"];
    [self addSubview:self.lineImg];
    
    self.height = CGRectGetMaxY(self.lineImg.frame);
    
    self.perpleLab.text = @"收货人：张三";
    self.phoneLab.text = @"15522890862";
    self.addressLab.text = @"收货地址：辽宁省大连市甘井子区轻工院1号大连工业大学";
    
}

@end
