//
//  ARTArticleFeedViewModel.h
//  Articles
//
//  Created by Bob Law on 9/19/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARTArticleService;

@interface ARTArticleFeedViewModel : NSObject

- (instancetype __nullable)initWithArticleService:(ARTArticleService * __nullable)articleService;

- (void)fetchInitialArticleFeedPageWithCompletion:(void (^ __nullable)(NSArray * __nullable articles))completion;

//- (void)fetchNextArticleFeedPageWithCompletion:

@end
