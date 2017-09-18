//
//  ARTArticleFeedResult.h
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARTArticle;

@interface ARTArticleFeedResult : NSObject

@property (nonatomic, strong, readonly) NSArray <ARTArticle *> * __nullable articles;

@property (nonatomic, strong, readonly) NSString * __nullable previousPage;
@property (nonatomic, strong, readonly) NSString * __nullable currentPage;
@property (nonatomic, strong, readonly) NSString * __nullable nextPage;

- (instancetype __nullable)initWithDictionary:(NSDictionary <NSString *, id> * __nonnull)dictionary;

@end
