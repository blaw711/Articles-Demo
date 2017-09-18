//
//  ARTAPIClient.m
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTAPIClient.h"
#import "ARTArticleFeedResult.h"

static NSString *const ARTBaseURLString = @"https://www.grailed.com/";
static NSString *const ARTInitialFeedURLString = @"/api/articles/ios_index?page=0";

@implementation ARTAPIClient

- (instancetype)init
{
  if (self = [super initWithBaseURL:[NSURL URLWithString:ARTBaseURLString]]) {
    
  }
  
  return self;
}

- (void)fetchArticlesFeedWithPageURLString:(NSString *)urlString completion:(void (^ _Nullable)(ARTArticleFeedResult * _Nullable, NSError * _Nullable))completion
{
  if (!urlString) {
    urlString = ARTInitialFeedURLString;
  }
  
  [self GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    ARTArticleFeedResult *result;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
      result = [[ARTArticleFeedResult alloc] initWithDictionary:responseObject];
    }
    
    if (completion) {
      completion(result, nil);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (completion) {
      completion(nil, error);
    }
  }];
}

- (void)fetchSavedSearchesWithCompletion:(void (^)(NSArray<ARTArticle *> * _Nullable, NSError * _Nullable))completion
{
  [self GET:@"/api/merchandise/marquee" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
  }];
}

@end
