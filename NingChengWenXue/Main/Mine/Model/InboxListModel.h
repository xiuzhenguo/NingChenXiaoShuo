//
//  InboxListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InboxListModel : NSObject

@property (nonatomic, strong) NSString *Id;

@property (nonatomic, strong) NSString *Title;

@property (nonatomic, assign) BOOL IsRead;

@property (nonatomic, strong) NSString *Time;

@property (nonatomic, strong) NSString *Content;

@property (nonatomic, strong) NSString *SendId;

@property (nonatomic, strong) NSString *SendName;

@property (nonatomic, assign) NSInteger MessageGener;

@end
