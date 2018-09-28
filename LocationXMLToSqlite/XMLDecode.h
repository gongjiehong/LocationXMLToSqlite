//
//  XMLDecode.h
//  LocationXMLToSqlite
//
//  Created by 龚杰洪 on 2018/9/28.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMLDecode : NSObject

@property (nonatomic, strong) NSXMLParser *parser;

@property (nonatomic, strong) NSMutableArray *resultArray;

- (instancetype)initWithInputURL:(NSURL *)inpuURL;

@end

NS_ASSUME_NONNULL_END
