//
//  PWContentView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "PWContentView.h"

@implementation PWContentView

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array height:(CGFloat)height{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        for (int i = 0; i < array.count; i ++)
        {
            //        Area *are = cell_Array[i];
            
            NSString *name = array[i];
            static UIButton *recordBtn =nil;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            
            CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
            
            CGFloat BtnW = rect.size.width + 10;
            CGFloat BtnH = rect.size.height + 10;
            
            if (i == 0)
            {
                btn.frame =CGRectMake(0, 0, BtnW, BtnH);
            }
            else{
                
                CGFloat yuWidth = self.frame.size.width -recordBtn.frame.origin.x -recordBtn.frame.size.width;
                
                if (yuWidth >= rect.size.width) {
                    
                    btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 5, recordBtn.frame.origin.y, BtnW, BtnH);
                }else{
                    
                    btn.frame =CGRectMake(0, recordBtn.frame.origin.y+recordBtn.frame.size.height+5, BtnW, BtnH);
                }
                
            }
            btn.borderWidth = 1;
            btn.borderColor = BXColor(191,44,36);
            [btn setTitle:name forState:UIControlStateNormal];
            [self addSubview:btn];
            
            NSLog(@"btn.frame.origin.y  %f", btn.frame.origin.y);
            self.frame = CGRectMake(10, height, BXScreenW - 30,CGRectGetMaxY(btn.frame));
            recordBtn = btn;
            
            btn.tag = 100 + i;
            [btn setTitleColor:BXColor(191,44,36) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    return self;
    
}

-(void) BtnClick:(UIButton *)sender{
    
    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.btnBlock) {
        
        weakSelf.btnBlock(sender.tag);
    }
    
}

-(void) btnClickBlock:(BtnBlock)btnBlock{
    
    self.btnBlock = btnBlock;
    
}

@end
