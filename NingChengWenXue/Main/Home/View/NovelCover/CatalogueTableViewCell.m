//
//  CatalogueTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CatalogueTableViewCell.h"

@implementation CatalogueTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.catalogueLab = [[UILabel alloc] init];
    self.catalogueLab.font = [UIFont boldSystemFontOfSize:15];
    self.catalogueLab.textColor = BXColor(35, 35, 35);
    self.catalogueLab.text = @"目录";
    [self.contentView addSubview:self.catalogueLab];
    
    self.catNumLab = [[UILabel alloc] init];
    self.catNumLab.font = THIRDFont;
    self.catNumLab.textColor = BXColor(35, 35, 35);
    [self.contentView addSubview:self.catNumLab];
    
    self.moreImg = [[UIImageView alloc] init];
    self.moreImg.image = [UIImage imageNamed:@"箭头-1"];
    [self.contentView addSubview:self.moreImg];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
    
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.catalogueLab.frame = CGRectMake(15, 15, 40, 15);
    self.catNumLab.frame = CGRectMake(CGRectGetMaxX(self.catalogueLab.frame)+10, 15, 200, 15);
    self.moreImg.frame = CGRectMake(BXScreenW - 25, 15, 10, 15);
    self.lineLab.frame = CGRectMake(0, 43.5, BXScreenW, 0.5);
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
