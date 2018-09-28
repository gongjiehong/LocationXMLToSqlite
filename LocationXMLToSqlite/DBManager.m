//
//  DBManager.m
//  LocationXMLToSqlite
//
//  Created by 龚杰洪 on 2018/9/28.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

- (instancetype)initWithDBPath:(NSString *)path
{
    self = [super init];
    if (self) {
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            [fileManager removeItemAtPath:path error:&error];
        }
        
        BOOL createFileResult = [fileManager createFileAtPath:path contents:nil attributes:nil];
        if (createFileResult) {
            
        } else {
            
        }
        self.db = [FMDatabase databaseWithPath:path];
        [self createTable];
    }
    return self;
}

- (NSArray *)getDataBySQL:(NSString *)sql
{
    NSMutableArray *res = [NSMutableArray array];
    if ( [self.db open] )
    {
        [self.db setShouldCacheStatements:YES];
        FMResultSet *rs = [self.db executeQuery:sql];
        if([self.db hadError])
        {
            NSLog(@"%s", __FUNCTION__);
            NSLog(@"Err %d: %@", [self.db lastErrorCode], [self.db lastErrorMessage]);
        }
        while([rs next])
        {
            [res addObject:[rs resultDictionary]];
        }
        
        [self.db close];
    }
    
    return res;
}


//insert
- (BOOL)insertDataWithSQL:(NSString *)sql
{
    BOOL success = YES;
    if ( [self.db open] )
    {
        [self.db setShouldCacheStatements:YES];
        [self.db executeUpdate:sql];
        if([self.db hadError])
        {
            NSLog(@"%s", __FUNCTION__);
            NSLog(@"Err %d: %@", [self.db lastErrorCode], [self.db lastErrorMessage]);
            success = NO;
        }
        [self.db close];
    }
    return success;
}

- (BOOL)deleteDataBySQL:(NSString *)sql
{
    BOOL success=YES;
    if ( [self.db open] )
    {
        [self.db setShouldCacheStatements:YES];
        [self.db executeUpdate:sql];
        if([self.db hadError])
        {
            NSLog(@"%s", __FUNCTION__);
            NSLog(@"Err %d: %@", [self.db lastErrorCode], [self.db lastErrorMessage]);
            success=NO;
        }
        [self.db close];
    }
    
    return success;
}

- (void)createTable
{
    NSString *createSQL = @"CREATE TABLE world_cities_cn (country TEXT, state TEXT, city TEXT)";
    BOOL result = [self insertDataWithSQL:createSQL];
    if (result) {
        NSLog(@"create world_cities success");
    }
}

- (BOOL)insertLocationInfo:(NSArray *)infos
{
    for (NSDictionary *info in infos) {
        NSString *insertSql = [NSString stringWithFormat:@"insert into world_cities_cn (country, state, city) values('%@', '%@', '%@')", info[@"country"], info[@"state"], info[@"city"] ];
        if ([self insertDataWithSQL:insertSql]) {
//            NSLog(@"insert success");
        }
    }
    return true;
}


@end
