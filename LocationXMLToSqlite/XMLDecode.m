//
//  XMLDecode.m
//  LocationXMLToSqlite
//
//  Created by 龚杰洪 on 2018/9/28.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

#import "XMLDecode.h"

@interface XMLDecode() <NSXMLParserDelegate>
{
    NSString *lastCountry;
    NSString *lastState;
    
    BOOL lastIsCountry;
}


@end

@implementation XMLDecode

- (instancetype)initWithInputURL:(NSURL *)inpuURL {
    self = [super init];
    if (nil != self) {
        _resultArray = [NSMutableArray array];
        
        lastState = @"";
        lastCountry = @"";
        
        _parser = [[NSXMLParser alloc] initWithContentsOfURL:inpuURL];
        _parser.delegate = self;
        [_parser setShouldProcessNamespaces:NO];
        [_parser setShouldReportNamespacePrefixes:NO];
        [_parser setShouldResolveExternalEntities:NO];
        [_parser parse];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"CountryRegion"]) {
        if (lastIsCountry) {
            NSDictionary *tempDic = @{@"country": lastCountry, @"state": lastCountry, @"city": lastCountry};
            [_resultArray addObject:tempDic];
        }
        lastIsCountry = true;
        NSString *countryName = [attributeDict objectForKey:@"Name"];
        lastCountry = countryName;
        
    } else if ([elementName isEqualToString:@"State"]) {
        lastIsCountry = false;
        NSString *stateName = [attributeDict objectForKey:@"Name"];
        lastState = stateName;
        if (lastState == nil) {
            lastState = lastCountry;
        }
    } else if ([elementName isEqualToString:@"City"]) {
        lastIsCountry = false;
        NSString *cityName = [attributeDict objectForKey:@"Name"];
        NSDictionary *tempDic = @{@"country": lastCountry, @"state": lastState, @"city": cityName};
        [_resultArray addObject:tempDic];
    }
    
//    NSLog(@"elementName = %@, qName = %@, namespaceURI = %@, attributeDict = %@, name = %@", elementName, qName, namespaceURI, attributeDict, [attributeDict objectForKey:@"Name"]);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"%@", string);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
//    NSLog(@"elementName = %@, qName = %@, namespaceURI = %@", elementName, qName, namespaceURI);
}



@end
