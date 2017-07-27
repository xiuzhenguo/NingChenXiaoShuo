//
//  ShuPingListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShuPingListModel : NSObject

@property (nonatomic, assign) NSInteger PostClass;

@property (nonatomic, strong) NSString *Content;

@property (nonatomic, assign) NSInteger SectionIndex;

@property (nonatomic, assign) NSInteger IsApplaud;

@property (nonatomic, strong) NSString *SectionName;

@property (nonatomic, strong) NSString *Id;

@property (nonatomic, strong) NSString *AuthorId;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *UserHeadImage;

@property (nonatomic, strong) NSString *Time;

@property (nonatomic, assign) NSInteger Reply;

@property (nonatomic, assign) NSInteger Applaud;

@property (nonatomic, strong) NSString *AuthorHeadImage;

@property (nonatomic, strong) NSString *PublishTime;

@property (nonatomic, strong) NSArray *ApplaudItem;


@end
