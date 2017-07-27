//
//  ETHttpArrayModel.h
//  ETong_ios
//
//  Created by xiaocool on 16/9/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETHttpArrayModel : NSObject

@property (assign, nonatomic) NSInteger *StatusCode;
@property (copy, nonatomic) NSString *Message;
@property (copy, nonatomic) NSArray *Result;

@end
