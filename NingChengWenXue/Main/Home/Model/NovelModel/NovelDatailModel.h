//
//  NovelDatailModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NovelDatailModel : NSObject

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *AuthorId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, assign) NSInteger Reader;

@property (nonatomic, assign) NSInteger Character;

@property (nonatomic, strong) NSString *UpdateTime;

@property (nonatomic, strong) NSString *FictionImage;

@property (nonatomic, strong) NSString *UUID;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *UserImage;

@property (nonatomic, assign) NSInteger Lv;

@property (nonatomic, assign) NSInteger Click;

@property (nonatomic, assign) NSInteger Foucs;

@property (nonatomic, assign) NSInteger Collect;

@property (nonatomic, assign) NSInteger Share;

@property (nonatomic, strong) NSString *Intro;

@property (nonatomic, strong) NSString *KeyWord;

@property (nonatomic, assign) NSInteger SectionIndex;

@property (nonatomic, assign) NSInteger EvalauteIndex;

@property (nonatomic, assign) NSInteger SerialNumber;

@property (nonatomic, strong) NSString *BookStatusName;

@property (nonatomic, assign) NSInteger FictionClassID;

@property (nonatomic, assign) NSInteger PraiseCount;

@property (nonatomic, assign) NSInteger IsPraise;

@property (nonatomic, strong) NSArray *FictionList;

@end
