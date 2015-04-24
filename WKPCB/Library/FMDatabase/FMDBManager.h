//
//  FMDBManager.h
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-10.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCBCategrory.h"
#import "Product.h"
#import "FMDB.h"

#define kWKDBName         @"wkpcb.sqlite"
#define kWKDBFolderName   @"wkpcb"

@interface FMDBManager : NSObject
@property (nonatomic,strong) FMDatabaseQueue *dbHelper;

+ (FMDBManager *)shareInstance;
//取得类别
- (NSArray*)GetPCBCategories;
//取得类别下的子项
- (NSArray*)GetCategoryDetailWithType:(NSInteger)type;
- (void)deleteCacheDB;
@end
