//
//  main.m
//  LocationXMLToSqlite
//
//  Created by 龚杰洪 on 2018/9/28.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "XMLDecode.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc != 5) {
            NSLog(@"invalid params \neg. \nLocationXMLToSqlite -i [input path] -o [ouput path]");
            return 0;
        }
        
        NSString *inputPath = [[NSString alloc] initWithCString:argv[2] encoding:NSUTF8StringEncoding];
        NSString *outpuPath = [[NSString alloc] initWithCString:argv[4] encoding:NSUTF8StringEncoding];
        
        NSLog(@"inputPath = %@", inputPath);
        NSLog(@"outpuPath = %@", outpuPath);
        
        XMLDecode *parser = [[XMLDecode alloc] initWithInputURL:[NSURL fileURLWithPath:inputPath]];
        DBManager *db = [[DBManager alloc] initWithDBPath:outpuPath];
        [db insertLocationInfo:parser.resultArray];
    }
    
    return 0;
}
