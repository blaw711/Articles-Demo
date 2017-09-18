//
//  ARTArticle.m
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTArticle.h"

@interface ARTArticle ()

@property (nonatomic, strong) NSNumber *__nullable articleID;

@property (nonatomic, strong) NSString *__nullable author;

@property (nonatomic, strong) NSString *__nullable hero;

@property (nonatomic, strong) NSDate *__nullable publishDate;

@property (nonatomic, strong) NSString *__nullable title;

@property (nonatomic, strong) NSURL *__nullable URL;

@end

@implementation ARTArticle

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
  if (self = [super init]) {
    _articleID = [self guardJSONElement:[dictionary objectForKey:@"id"]];
    _author = [self guardJSONElement:[dictionary objectForKey:@"author"]];
    _hero = [self guardJSONElement:[dictionary objectForKey:@"hero"]];
    _publishDate = [self guardJSONElement:[dictionary objectForKey:@"published_at"]];
    _title = [self guardJSONElement:[dictionary objectForKey:@"title"]];
    
    NSString *url = [self guardJSONElement:[dictionary objectForKey:@"url"]];
    
    if ([url isKindOfClass:[NSString class]]) {
      _URL = [NSURL URLWithString:url];
    }
  }
  
  return self;
}

- (id)guardJSONElement:(id)element
{
  return [element isKindOfClass:[NSNull class]] ? nil : element;
}

@end
