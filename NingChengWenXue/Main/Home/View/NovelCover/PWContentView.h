//
//  PWContentView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BtnBlock)(NSInteger index);

@interface PWContentView : UIView

@property (nonatomic,copy) BtnBlock btnBlock;

-(void) btnClickBlock:(BtnBlock) btnBlock;

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array height:(CGFloat)height;

@end
