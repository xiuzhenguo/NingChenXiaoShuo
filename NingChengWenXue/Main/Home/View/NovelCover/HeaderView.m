//
//  HeaderView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpHeadViewUI];
    }
    return self;
}

- (void)setModel:(NovelDatailModel *)model{
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.UserImage] placeholderImage:[UIImage imageNamed:@"打赏头像"]];
    
    self.nameLab.text = model.FictionName;
    [_nameLab sizeToFit];
    
    self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame) + 10, 15, 32, 20);
    self.typeLab.text = model.BookStatusName;
    
    self.writorLab.text = [NSString stringWithFormat:@"%@（%@）",model.AuthorName,model.UUID];
    [self.writorLab sizeToFit];
    
    self.readLab.text = [NSString stringWithFormat:@"%ld阅读/%ld文字/%@",model.Reader,model.Character,model.UpdateTime];
    
    self.rankLab.text = [NSString stringWithFormat:@"Lv%ld",model.Lv];
    self.rankLab.frame = CGRectMake(CGRectGetMaxX(self.writorLab.frame) + 20, CGRectGetMaxY(self.readLab.frame)+22, 32, 15);
    
    self.dainjiLab.text = [NSString stringWithFormat:@"%ld",model.Click];
    self.shoucangLab.text = [NSString stringWithFormat:@"%ld",model.Collect];
    self.guanzhuLab.text = [NSString stringWithFormat:@"%ld",model.Foucs];
    self.fenxiangLab.text = [NSString stringWithFormat:@"%ld",model.Share];
}

-(void) setUpHeadViewUI {
    // 小说名字
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, BXScreenW - 62, 20)];
    nameLable.font = [UIFont boldSystemFontOfSize:18];
//    nameLable.text = @"好父母胜过好老师";
    nameLable.textColor = BXColor(40, 40, 40);
    [self addSubview:nameLable];
    self.nameLab = nameLable;
    // 形式
    UILabel *type  = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLable.frame) + 10, 15, 32, 20)];
//    type.text = @"完结";
    type.textColor = BXColor(236,105,65);
    type.textAlignment = NSTextAlignmentCenter;
    type.font = ELEFont;
    type.borderWidth = 1;
    type.borderColor = BXColor(236,105,65);
    [self addSubview:type];
    self.typeLab = type;
    // 阅读数、文字、更新
    UILabel *readLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, BXScreenW - 30, 15)];
    readLable.text = @"0阅读 / 0文字 / 0小时前更新";
    readLable.font = THIRDFont;
    readLable.textColor = BXColor(35,35,35);
    [self addSubview:readLable];
    self.readLab = readLable;
    // 作者头像
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(readLable.frame)+15, 30, 30)];
//    imgView.image = [UIImage imageNamed:@"作者头像"];
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.layer.cornerRadius = 15;
    imgView.clipsToBounds = YES;
    [self addSubview:imgView];
    self.imgView = imgView;
    // 作者的名字及ID
    UILabel *writer = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+7, CGRectGetMaxY(readLable.frame)+20, 250, 20)];
    writer.text = @"爱猫咪的小樱 (UUID:123444555)";
    writer.font = FIFFont;
    writer.textColor = BXColor(35, 35, 35);
    [writer sizeToFit];
    [self addSubview:writer];
    self.writorLab = writer;
    // 等级
    UILabel *rank = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(writer.frame) + 20, CGRectGetMaxY(readLable.frame)+22, 32, 15)];
    rank.text = @"Lv20";
    rank.textColor = BXColor(0,160,233);
    rank.font = ELEFont;
    rank.borderWidth = 1;
    rank.textAlignment = NSTextAlignmentCenter;
    rank.borderColor = BXColor(0,160,233);
    [self addSubview:rank];
    self.rankLab = rank;
    // > 图
    UIButton *more = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(readLable.frame)+15, BXScreenW - 15, 30)];
    [more setTitle:@">" forState:UIControlStateNormal];
    more.titleLabel.font = ELEFont;
    [more setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
    more.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    more.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    [self addSubview:more];
//    more.backgroundColor = [UIColor whiteColor];
    self.moreBtn = more;
    
    NSArray *array = @[@"点击",@"收藏",@"关注",@"分享"];
    for (int i = 0; i<4; i++) {
        UIButton *backView = [[UIButton alloc] initWithFrame:CGRectMake((BXScreenW/4.0)*i, CGRectGetMaxY(imgView.frame)+5, (BXScreenW/4.0), 50)];
//        [backView addTarget:self action:@selector(cliclk) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backView];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, (BXScreenW/4.0), 15)];
        lable.text = array[i];
        lable.font = [UIFont boldSystemFontOfSize:13];
        lable.textColor = BXColor(35, 35, 35);
        lable.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:lable];
        
        UILabel *numlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, BXScreenW/4.0, 15)];
        numlab.text = @"888888";
        numlab.font = THIRDFont;
        numlab.textAlignment = NSTextAlignmentCenter;
        numlab.textColor = BXColor(152, 152, 152);
        [backView addSubview:numlab];
        if (i == 0) {
            self.dainjiLab = numlab;
        }else if (i == 1){
            self.shoucangLab = numlab;
        }else if (i == 2){
            self.guanzhuLab = numlab;
        }else{
            self.fenxiangLab = numlab;
        }
        
    }
    
    for (int i = 0; i < 3; i++) {
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake((BXScreenW/4.0)*(i+1), CGRectGetMaxY(imgView.frame)+15, 1, 30)];
        lineLab.backgroundColor = BXColor(242, 242, 242);
        [self addSubview:lineLab];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+55, BXScreenW, 10)];
    lineView.backgroundColor = BXColor(242, 242, 242);
    [self addSubview:lineView];
    
    self.height = CGRectGetMaxY(imgView.frame)+5+50+10;
    
}

@end
