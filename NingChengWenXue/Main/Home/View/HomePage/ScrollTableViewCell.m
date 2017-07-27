//
//  ScrollTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/16.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "BookKeysModel.h"

@implementation ScrollTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self  =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self UIConfigure];
    }
    
    return  self;
    
}
-(void)countOfButton:(NSInteger)count namearray:(NSArray *)nameArray imgarray:(NSArray *)imgArray{
    for (UIView * view in _scroll.subviews) {
        [view removeFromSuperview];
    }
    UIButton * firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton = [self viewWithTag:10];
    if (!firstButton) {
        for (int i=0; i<count; i++) {
            UIButton * bookBtn = [[UIButton alloc]init];
            bookBtn.frame = CGRectMake(15+i*105, 0, 90, 122);
            _scroll.contentSize = CGSizeMake(count*100+100, 90);
            bookBtn.tag = i+10000;
            //        [bookBtn setBackgroundImage:[UIImage imageNamed:@"上首页_6"] forState:UIControlStateNormal];
            [bookBtn addTarget:self action:@selector(btnCli:) forControlEvents:1<<6];
            [_scroll addSubview: bookBtn];
            _classBtn = bookBtn;
            
            UILabel * classLab = [[UILabel alloc]initWithFrame:CGRectMake(15+i*105, 127, 90, 22)];
            _classLab = classLab;
            classLab.font = [UIFont systemFontOfSize:16];
            [_scroll addSubview: classLab];
        
            BookKeysModel *model = nameArray[i];
            NSString *avatarUrlStr = model.FictionImage;
            [_classBtn sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"大主宰"]];

            _classLab.text = model.FictionName;
            
        }
        
    }
}

-(void)UIConfigure{
    UIScrollView * scv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,BXScreenW, 149)];
    scv.showsHorizontalScrollIndicator = NO;
    scv.showsVerticalScrollIndicator = NO;
    _scroll = scv;
    [self.contentView addSubview: scv];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(15, 164, BXScreenW-15, 1)];
    line.backgroundColor = BXColor(195, 195, 195);
//    [self.contentView addSubview:line];
    
    
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
    //    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end

