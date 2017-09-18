//
//  ARTAPIClient.h
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class ARTArticleFeedResult, ARTArticle;

@interface ARTAPIClient : AFHTTPSessionManager

- (void)fetchArticlesFeedWithPageURLString:(NSString * __nullable)urlString completion:(void (^ __nullable) (ARTArticleFeedResult  * __nullable feedResult, NSError  * __nullable error))completion;

- (void)fetchSavedSearchesWithCompletion:(void (^ __nullable) (NSArray <ARTArticle *>  * __nullable articles, NSError  * __nullable error))completion;

@end
