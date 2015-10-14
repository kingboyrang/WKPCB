//
//  FMDBManager.m
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-10.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "FMDBManager.h"
#import "FileHelper.h"

@implementation FMDBManager
+ (FMDBManager *)shareInstance{
    static dispatch_once_t  onceToken;
    static FMDBManager * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[FMDBManager alloc] init];
    });
    return sSharedInstance;
}
- (id)init{
    if (self=[super init]) {
        NSString *path=[self GetDBPath];
        if (![FileHelper existsFilePath:path]) {
            NSString *dbpath=[[NSBundle mainBundle] pathForResource:@"wkpcb" ofType:@"sqlite"];
            NSData *mainBundleFile = [NSData dataWithContentsOfFile:dbpath];
            [[NSFileManager defaultManager] createFileAtPath:path
                                                    contents:mainBundleFile
                                                  attributes:nil];
            //self.dbHelper=[FMDatabaseQueue databaseQueueWithPath:path];
        }
    }
    return self;
}
- (NSString*)GetDBPath{
    NSString *path=[FileHelper createDocumentDirectoryWithName:kWKDBFolderName];
    return [path stringByAppendingPathComponent:kWKDBName];
}
- (NSArray*)GetPCBCategories{
    @synchronized(self.dbHelper)
    {
        if (!self.dbHelper) {
            self.dbHelper=[FMDatabaseQueue databaseQueueWithPath:[self GetDBPath]];
        }
        //select * from PCBCategrory where ParentId is null order by Sort asc
      __block  NSString *t_sql=@"select * from PCBCategrory";
      __block  NSMutableArray *aList = [[NSMutableArray alloc] initWithCapacity:0];
        [self.dbHelper inDatabase:^(FMDatabase *db) {
            FMResultSet *result = [db executeQuery:t_sql];
            if (result)
            {
                while ([result next])
                {
                    PCBCategrory *entity=[[PCBCategrory alloc] init];
                    NSArray *keyList = [[result columnNameToIndexMap] allKeys];
                    NSString *aKey=@"";
                    for (NSInteger i=0;i<keyList.count;i++)
                    {
                        aKey=[result columnNameForIndex:i];
                        id obj = [result objectForColumnName:aKey];
                        SEL sel=NSSelectorFromString(aKey);
                        if ([entity respondsToSelector:sel]) {
                            [entity setValue:obj forKey:aKey];
                        }
                    }
                    [aList addObject:entity];
                }
                [result close];
            }
        }];
        
        
        NSMutableArray *results=[NSMutableArray arrayWithCapacity:0];
        //取得第一层元素
        NSPredicate *pred=[NSPredicate predicateWithFormat:@"self.ParentId==0"];
        NSArray *firstArr=[aList filteredArrayUsingPredicate:pred];
        firstArr=[firstArr sortedArrayUsingComparator:^NSComparisonResult(PCBCategrory *obj1, PCBCategrory *obj2) {
            if (obj1.Sort>obj2.Sort) {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
        }];
        if (firstArr&&[firstArr count]>0) {
            [results addObjectsFromArray:firstArr];
            //取得子项
            for (PCBCategrory *item in firstArr) {
                NSPredicate *pred=[NSPredicate predicateWithFormat:@"self.ParentId==%d",item.CategoryId];
                NSArray *secondArr=[aList filteredArrayUsingPredicate:pred];
                secondArr=[secondArr sortedArrayUsingComparator:^NSComparisonResult(PCBCategrory *obj1, PCBCategrory *obj2) {
                    if (obj1.Sort>obj2.Sort) {
                        return NSOrderedDescending;
                    }
                    return NSOrderedAscending;
                }];
                if (secondArr&&[secondArr count]>0) {
                    item.childs=secondArr;
                }
            }
            
        }
        return results;
    }
    
}
//取得类别下的子项
- (NSArray*)GetCategoryDetailWithType:(NSInteger)type{
    @synchronized(self.dbHelper){
        if (!self.dbHelper) {
            self.dbHelper=[FMDatabaseQueue databaseQueueWithPath:[self GetDBPath]];
        }
       __block NSString *t_sql=[NSString stringWithFormat:@"select * from Product where Category=%d order by ProductId asc",type];
       __block  NSMutableArray *aList = [[NSMutableArray alloc] initWithCapacity:0];
        [self.dbHelper inDatabase:^(FMDatabase *db) {
            FMResultSet *result = [db executeQuery:t_sql];
            if (result)
            {
                while ([result next])
                {
                    Product *entity=[[Product alloc] init];
                    NSArray *keyList = [[result columnNameToIndexMap] allKeys];
                    NSString *aKey=@"";
                    for (NSInteger i=0;i<keyList.count;i++)
                    {
                        aKey=[result columnNameForIndex:i];
                        id obj = [result objectForColumnName:aKey];
                        SEL sel=NSSelectorFromString(aKey);
                        if ([entity respondsToSelector:sel]) {
                            [entity setValue:obj forKey:aKey];
                        }
                    }
                    [aList addObject:entity];
                }
                [result close];
            }
        }];
        return aList;
    
    }
}
- (void)deleteCacheDB{
    @synchronized(self.dbHelper){
        if (self.dbHelper) {
            [self.dbHelper close];
            self.dbHelper=nil;
        }
        NSString *path=[self GetDBPath];
        if ([FileHelper existsFilePath:path]) {
            [FileHelper deleteFileWithPath:path];
        }
    }
}
@end
