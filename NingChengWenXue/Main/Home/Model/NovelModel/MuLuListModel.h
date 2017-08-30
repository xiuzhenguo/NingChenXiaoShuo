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

@property (nonatomic, strong) NSString *Content;

@property (nonatomic, assign) NSInteger ReadTextLength;

@property (nonatomic, strong) NSString *Pre; // 上一章主键

@property (nonatomic, strong) NSString *Next; // 下一章主键

@property (nonatomic, assign) NSInteger IsCollect;// 判断小说是否收藏


@end
