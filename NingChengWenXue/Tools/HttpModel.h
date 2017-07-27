//
//  HttpModel.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface HttpModel : NSObject

@property (assign, nonatomic) NSInteger StatusCode;
@property (copy, nonatomic) NSString *Message;
@property (copy, nonatomic) NSArray *Result;


@end
