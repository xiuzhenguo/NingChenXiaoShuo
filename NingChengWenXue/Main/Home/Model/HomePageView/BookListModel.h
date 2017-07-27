//
//  BookListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookListModel : NSObject

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *Unity;

@property (nonatomic, strong) NSString *Index;

@property (nonatomic, strong) NSString *HeadImage;

@property (nonatomic, strong) NSArray *Keys;

@property (nonatomic, strong) NSString *UserId;

@property (nonatomic, strong) NSString *UserName;

@property (nonatomic, strong) NSString *Unit;

@property (nonatomic, strong) NSString *UUID;

@property (nonatomic, strong) NSString *Energy;

@property (nonatomic, assign) NSInteger Lv;

@property (nonatomic, strong) NSString *Signature;

@property (nonatomic, strong) NSArray *FictionList;

@property (nonatomic, strong) NSString *DataTime;

@property (nonatomic, assign) NSInteger ClassId;

@property (nonatomic, strong) NSString *ClassName;

@property(nonatomic,assign)NSInteger row;
@property (nonatomic, strong) NSString *Select;
@property(nonatomic,assign)BOOL isShowBig;


@end
