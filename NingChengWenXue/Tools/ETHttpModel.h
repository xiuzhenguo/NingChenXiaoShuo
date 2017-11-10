//
//  ETHttpModel.h
//  ETong_ios
//
//  Created by xiaocool on 16/7/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface ETHttpModel : NSObject
@property (assign, nonatomic) NSInteger StatusCode;
@property (copy, nonatomic) NSString *Message;
@property (copy, nonatomic) NSDictionary *Result;
@property (copy,nonatomic) NSString *datas;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *url;

@end
