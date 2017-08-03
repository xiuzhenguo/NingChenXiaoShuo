//
//  SectionListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/25.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionListModel : NSObject

@property (nonatomic, strong) NSString *SectionId;

@property (nonatomic, strong) NSString *SectionName;

@property (nonatomic, assign) NSInteger Character;

@property (nonatomic, assign) NSInteger SectionStatus;

@property (nonatomic, strong) NSString *SectionContent;

@end
