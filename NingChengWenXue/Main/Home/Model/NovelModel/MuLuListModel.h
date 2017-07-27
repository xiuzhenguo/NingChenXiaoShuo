//
//  MuLuListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MuLuListModel : NSObject

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *SectionId;

@property (nonatomic, strong) NSString *SectionName;

@property (nonatomic, assign) NSInteger SectionStatus;

@property (nonatomic, assign) NSInteger SectionIndex;

@property (nonatomic, assign) NSInteger IsRead;

@property (nonatomic, assign) NSInteger CharacterCount;

@property (nonatomic, strong) NSString *Title;


@end
