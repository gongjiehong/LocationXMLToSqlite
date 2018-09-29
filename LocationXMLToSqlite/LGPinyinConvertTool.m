//
//  LGPinyinConvertTool.m
//  Sudy
//
//  Created by 龚杰洪 on 2017/1/11.
//  Copyright © 2017年 龚杰洪. All rights reserved.
//

#import "LGPinyinConvertTool.h"
#import "LGPinyin.h"

@implementation NSString (FirstLetter)

- (NSString *)lg_uppercasePinYinFirstLetter
{
    unichar firstLetter = [self characterAtIndex:0];
    char cFirstLetter = lg_pinyinFirstLetter(firstLetter);
    return [[NSString stringWithFormat:@"%c",cFirstLetter] uppercaseString];
}

- (NSString *)lg_lowercasePinYinFirstLetter
{
    unichar firstLetter = [self characterAtIndex:0];
    char cFirstLetter = lg_pinyinFirstLetter(firstLetter);
    return [[NSString stringWithFormat:@"%c",cFirstLetter] lowercaseString];
}

@end
