//
//  ARTSearchService.m
//  Articles
//
//  Created by Bob Law on 9/18/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTSearchService.h"
#import "ARTAPIClient.h"

@interface ARTSearchService ()

@property (nonnull, strong) ARTAPIClient *APIClient;

@end

@implementation ARTSearchService

- (instancetype)initWithAPIClient:(ARTAPIClient *)APIClient
{
  if (self = [super init]) {
    _APIClient = APIClient;
  }
  
  return self;
}

@end
