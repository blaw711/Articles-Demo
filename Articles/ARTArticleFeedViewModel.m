//
//  ARTArticleFeedViewModel.m
//  Articles
//
//  Created by Bob Law on 9/19/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

@import UIKit;

#import "ARTArticleFeedViewModel.h"
#import "ARTArticleService.h"
#import "ARTArticleFeedResult.h"
//#import "ARTArticle.h"

@interface ARTArticleFeedViewModel ()

@property (nonatomic, strong) ARTArticleService *articleService;

@property (nonatomic, strong) NSMutableArray <ARTArticle *> *__nonnull articles;

@property (nonatomic, strong) NSString *nextPageURLString;

@property (nonatomic, assign) BOOL isFetchingFeed;

@end

@implementation ARTArticleFeedViewModel

- (instancetype)initWithArticleService:(ARTArticleService *)articleService
{
  if (self = [super init]) {
    _articleService = articleService;
    _articles = [NSMutableArray new];
  }
  
  return self;
}

- (NSInteger)numberOfRows
{
  return self.articles.count;
}

- (ARTArticle *)articleForIndexPath:(NSIndexPath *)indexPath
{
  return self.articles[indexPath.row];
}

- (BOOL)canFetchMorePages
{
  return [self.nextPageURLString isKindOfClass:[NSString class]] && !self.isFetchingFeed;
}

- (void)pageArticleFeedWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
  if (self.isFetchingFeed) {
    if (completion) {
      completion(nil, nil);
    }
    return;
  }
  
  self.isFetchingFeed = YES;
  
  [self.articleService fetchArticlesFeedWithPageURLString:self.nextPageURLString completion:^(ARTArticleFeedResult * _Nullable feedResult, NSError * _Nullable error) {
    [self.articles addObjectsFromArray:feedResult.articles];
    self.nextPageURLString = feedResult.nextPage;
    
    self.isFetchingFeed = NO;
    
    if (completion) {
      completion(feedResult.articles, error);
    }
  }];
}

@end
