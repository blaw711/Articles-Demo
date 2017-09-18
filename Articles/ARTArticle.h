//
//  ARTArticle.h
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARTArticle : NSObject

@property (nonatomic, strong, readonly) NSNumber *__nullable articleID;

@property (nonatomic, strong, readonly) NSString *__nullable author;

@property (nonatomic, strong, readonly) NSString *__nullable hero;

@property (nonatomic, strong, readonly) NSDate *__nullable publishDate;

@property (nonatomic, strong, readonly) NSString *__nullable title;

@property (nonatomic, strong, readonly) NSURL *__nullable URL;

- (instancetype __nullable)initWithDictionary:(NSDictionary <NSString *, id> * __nonnull)dictionary;

@end
