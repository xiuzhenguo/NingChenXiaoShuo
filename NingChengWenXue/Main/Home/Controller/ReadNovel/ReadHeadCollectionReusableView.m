//
//  ReadHeadCollectionReusableView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/30.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ReadHeadCollectionReusableView.h"

@implementation ReadHeadCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.font = [UIFont boldSystemFontOfSize:18];
        self.titleLab.textColor = [UIColor blackColor];
        //        headLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLab];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.titleLab.frame = CGRectMake(15, 0, BXScreenW-30, 40);
    
}

@end
