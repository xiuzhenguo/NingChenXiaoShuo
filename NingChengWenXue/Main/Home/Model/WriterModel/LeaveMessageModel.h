//
//  LeaveMessageModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/19.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaveMessageModel : NSObject

@property (nonatomic, strong) NSString *Id;

@property (nonatomic, strong) NSString *AuthorId;

@property (nonatomic, strong) NSString *LeaveUserId;

@property (nonatomic, assign) NSInteger ReplyCount;

@property (nonatomic, strong) NSString *Content;

@property (nonatomic, strong) NSString *LeaveTime;

@property (nonatomic, strong) NSString *UserImage;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSArray *ReplyList;

@end
