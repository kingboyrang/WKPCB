//
//  PCBCategrory.h
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-10.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCBCategrory : NSObject
@property (nonatomic,assign) NSInteger CategoryId;
@property (nonatomic,strong) NSString *CategoryName;
@property (nonatomic,assign) NSInteger ParentId;
@property (nonatomic,assign) NSInteger Sort;
@property (nonatomic,strong) NSArray *childs;

- (BOOL)hasChild;
@end
