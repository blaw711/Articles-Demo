//
//  ARTArticleFeedResult.m
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTArticleFeedResult.h"
#import "ARTArticle.h"

static NSString *const ARTArticleFeedResultDataKey = @"data";
static NSString *const ARTArticleFeedResultMetaDataKey = @"metadata";

static NSString *const ARTArticleFeedResultPaginationkey = @"pagination";

static NSString *const ARTArticleFeedResultCurrentPageKey = @"current_page";
static NSString *const ARTArticleFeedResultNextPageKey = @"next_page";
static NSString *const ARTArticleFeedResultPreviousPageKey = @"previous_page";

@interface ARTArticleFeedResult ()

@property (nonatomic, strong) NSArray <ARTArticle *> * __nullable articles;

@property (nonatomic, strong) NSString * __nullable previousPage;
@property (nonatomic, strong) NSString * __nullable currentPage;
@property (nonatomic, strong) NSString * __nullable nextPage;

@end

@implementation ARTArticleFeedResult

- (instancetype __nullable)initWithDictionary:(NSDictionary <NSString *, id> * __nonnull)dictionary
{
  if (self = [super init]) {
    NSArray *dataArray = [self guardJSONElement:[dictionary objectForKey:ARTArticleFeedResultDataKey]];
    
    if ([dataArray isKindOfClass:[NSArray class]]) {
      _articles = [self articlesFromArray:dataArray];
    }
    
    NSDictionary *metaData = [self guardJSONElement:[dictionary objectForKey:ARTArticleFeedResultMetaDataKey]];
    
    if ([metaData isKindOfClass:[NSDictionary class]]) {
      NSDictionary *pagination = [self guardJSONElement:[metaData objectForKey:ARTArticleFeedResultPaginationkey]];
      
      if ([pagination isKindOfClass:[NSDictionary class]]) {
        _previousPage = [self guardJSONElement:[pagination objectForKey:ARTArticleFeedResultPreviousPageKey]];
        _currentPage = [self guardJSONElement:[pagination objectForKey:ARTArticleFeedResultCurrentPageKey]];
        _nextPage = [self guardJSONElement:[pagination objectForKey:ARTArticleFeedResultNextPageKey]];
      }
    }
  }
  
  return self;
}

- (NSArray <ARTArticle *> *)articlesFromArray:(NSArray <NSDictionary *> *)array
{
  NSMutableArray *mutableArticlesArray = [NSMutableArray arrayWithCapacity:array.count];
  
  [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
    ARTArticle *article = [[ARTArticle alloc] initWithDictionary:dictionary];
    [mutableArticlesArray addObject:article];
  }];
  
  return mutableArticlesArray.copy;
}

- (id)guardJSONElement:(id)element
{
  return [element isKindOfClass:[NSNull class]] ? nil : element;
}

@end
