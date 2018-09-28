//
//  DBManager.h
//  LocationXMLToSqlite
//
//  Created by 龚杰洪 on 2018/9/28.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

@property (nonatomic, strong) FMDatabase *db;

- (instancetype)initWithDBPath:(NSString *)path;

- (BOOL)insertLocationInfo:(NSArray *)info;

@end

NS_ASSUME_NONNULL_END
