//
//  ARTArticleFeedViewModel.h
//  Articles
//
//  Created by Bob Law on 9/19/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARTArticleService, ARTArticle;

@interface ARTArticleFeedViewModel : NSObject

- (instancetype __nullable)initWithArticleService:(ARTArticleService * __nullable)articleService;

- (NSInteger)numberOfRows;

- (ARTArticle * __nullable)articleForIndexPath:(NSIndexPath *__nonnull)indexPath;

- (BOOL)canFetchMorePages;

//- (void)fetchInitialArticleFeedPageWithCompletion:(void (^ __nullable)(NSArray * __nullable articles, NSError *__nullable error))completion;

- (void)pageArticleFeedWithCompletion:(void (^ __nullable)(NSArray * __nullable articles, NSError *__nullable error))completion;

@end
