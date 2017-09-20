//
//  ARTArticle.m
//  Articles
//
//  Created by Bob Law on 9/16/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTArticle.h"
#import "UIKit/UIKit.h"

static NSInteger const ARTArticleThumbnailWidth = 600;

@interface ARTArticle ()

@property (nonatomic, strong) NSNumber *__nullable articleID;

@property (nonatomic, strong) NSString *__nullable author;

@property (nonatomic, strong) NSDate *__nullable publishDate;

@property (nonatomic, strong) NSString *__nullable title;

@property (nonatomic, strong) NSURL *__nullable URL;

@property (nonatomic, strong) NSURL *__nullable thumbnailURL;

@property (nonatomic, strong) NSURL *__nullable fullImageURL;

@property (nonatomic, strong) NSURL *__nullable authorAvatarURL;

@end

@implementation ARTArticle

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
  if (self = [super init]) {
    _articleID = [self guardJSONElement:[dictionary objectForKey:@"id"]];
    _title = [self guardJSONElement:[dictionary objectForKey:@"title"]];

    NSString *publishDateString = [self guardJSONElement:[dictionary objectForKey:@"published_at"]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd\'T\'HH:mm:ss.zzzZ"];
    
    _publishDate = [dateFormat dateFromString:publishDateString];
    
    NSString *author = [self guardJSONElement:[dictionary objectForKey:@"author"]];
    _author = author;
    _authorAvatarURL = [self authorAvatarURLForAuthor:author];
    
    NSString *hero = [self guardJSONElement:[dictionary objectForKey:@"hero"]];
    
    if ([hero isKindOfClass:[NSString class]]) {
      _thumbnailURL = [self thumbnailURLFromHero:hero];
    }
    
    NSString *url = [self guardJSONElement:[dictionary objectForKey:@"url"]];

    if ([url isKindOfClass:[NSString class]]) {
      _URL = [NSURL URLWithString:url];
    }
  }
  
  return self;
}

- (id)guardJSONElement:(id)element
{
  return [element isKindOfClass:[NSNull class]] ? nil : element;
}

- (NSURL *)thumbnailURLFromHero:(NSString *)hero
{
  NSString *thumbnailFormat = [NSString stringWithFormat:@"https://cdn.fs.grailed.com/AJdAgnqCST4iPtnUxiGtTz/rotate=deg:exif/rotate=deg:0/resize=width:%ld,fit:crop/output=format:jpg,compress:true,quality:95/%@", (long)ARTArticleThumbnailWidth, hero];
  return [NSURL URLWithString:thumbnailFormat];
}

- (NSURL *)authorAvatarURLForAuthor:(NSString *)author
{
  NSURL *url;
  
  if ([author isKindOfClass:[NSString class]]) {
    author = [author stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceCharacterSet].invertedSet];
    NSString *thumbnail = [NSString stringWithFormat:@"http://api.adorable.io/avatar/50/%@", author];
    url = [NSURL URLWithString:thumbnail];
  }
 
  return url;
}

@end
