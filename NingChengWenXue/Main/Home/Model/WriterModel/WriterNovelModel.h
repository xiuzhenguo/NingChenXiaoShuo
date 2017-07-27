//
//  WriterNovelModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WriterNovelModel : NSObject

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *FictiomImage;

@property (nonatomic, strong) NSString *UpdateTime;

@property (nonatomic, assign) NSInteger CollectCount;

@property (nonatomic, assign) NSInteger ReadCount;

@property (nonatomic, assign) NSInteger PostCount;



@property (nonatomic, strong) NSString *ComName;
@property (nonatomic, strong) NSString *ComId;

@end
