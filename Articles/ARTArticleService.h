//
//  ARTArticleService.h
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARTAPIClient, ARTArticleFeedResult;

@interface ARTArticleService : NSObject

- (instancetype __nullable)initWithAPIClient:(ARTAPIClient * __nullable)APIClient;

- (void)fetchArticlesFeedWithPageURLString:(NSString * __nullable)urlString completion:(void (^ __nullable) (ARTArticleFeedResult  * __nullable feedResult, NSError  * __nullable error))completion;

@end
