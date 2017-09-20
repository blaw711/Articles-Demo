//
//  ARTArticleFeedViewController.h
//  Articles
//
//  Created by Bob Law on 9/18/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class ARTArticleService;

@interface ARTArticleFeedViewController : ASViewController

- (instancetype __nullable)initWithArticleService:(ARTArticleService * __nullable)articleService;

@end
