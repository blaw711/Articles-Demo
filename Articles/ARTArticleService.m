//
//  ARTArticleService.m
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTArticleService.h"
#import "ARTAPIClient.h"
#import "ARTArticleFeedResult.h"

@interface ARTArticleService ()

@property (nonnull, strong) ARTAPIClient *APIClient;

@end

@implementation ARTArticleService

- (instancetype)initWithAPIClient:(ARTAPIClient *)APIClient
{
  if (self = [super init]) {
    _APIClient = APIClient;
  }
  
  return self;
}

- (void)fetchArticlesFeedWithPageURLString:(NSString *)urlString completion:(void (^)(ARTArticleFeedResult * _Nullable, NSError * _Nullable))completion
{
  [self.APIClient fetchArticlesFeedWithPageURLString:urlString completion:^(ARTArticleFeedResult * _Nullable feedResult, NSError * _Nullable error) {
    if ([feedResult isKindOfClass:[ARTArticleFeedResult class]]) {
      // save feed result?
    }
    
    if (completion) {
      completion(feedResult, error);
    }
  }];
}

@end
