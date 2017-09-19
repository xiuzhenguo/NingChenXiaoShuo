//
//  MinePerInfoHeaderView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MinePerInfoHeaderView.h"

@implementation MinePerInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BXColor(236,105,65);
        [self personInformationUI];
        //        [self setPhoneTexyField];
    }
    return self;
}

-(void) personInformationUI{
    UILabel *uuLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, BXScreenW/2.0 - 0.5, 30)];
    uuLab.textColor = [UIColor whiteColor];
    uuLab.text = @"UU点";
    uuLab .font = FIFFont;
    uuLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:uuLab];
    
    self.UULab = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, BXScreenW/2.0 - 0.5, 50)];
    self.UULab.textColor = [UIColor whiteColor];
    self.UULab.text = @"0";
    self.UULab.font = [UIFont systemFontOfSize:30];
    self.UULab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.UULab];
    
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW/2.0+0.5, 10, BXScreenW/2.0 - 0.5, 30)];
    money.textColor = [UIColor whiteColor];
    money.text = @"铜板";
    money .font = FIFFont;
    money.textAlignment = NSTextAlignmentCenter;
    [self addSubview:money];
    
    self.monLab = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW/2.0+0.5, 45, BXScreenW/2.0 - 0.5, 50)];
    self.monLab.textColor = [UIColor whiteColor];
    self.monLab.text = @"0";
    self.monLab.textAlignment = NSTextAlignmentCenter;
    self.monLab.font = [UIFont systemFontOfSize:30];
    [self addSubview:self.monLab];
    
    UIView *lineLab = [[UIView alloc] initWithFrame:CGRectMake(BXScreenW/2.0-0.5, 12.5, 1, 80)];
//    lineLab.backgroundColor = BXColor(195,195,195);
    [self addSubview:lineLab];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineLab.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineLab.frame) / 2, CGRectGetHeight(lineLab.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:BXColor(195,195,195).CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineLab.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:5], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineLab.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineLab.layer addSublayer:shapeLayer];
    
    
}


@end
