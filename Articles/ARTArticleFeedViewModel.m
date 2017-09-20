//
//  ARTArticleFeedViewModel.m
//  Articles
//
//  Created by Bob Law on 9/19/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTArticleFeedViewModel.h"
#import "ARTArticleService.h"

@interface ARTArticleFeedViewModel ()

@property (nonatomic, strong) ARTArticleService *articleService;

@end

@implementation ARTArticleFeedViewModel

- (instancetype)initWithArticleService:(ARTArticleService *)articleService
{
  if (self = [super init]) {
    _articleService = articleService;
  }
  
  return self;
}


@end
