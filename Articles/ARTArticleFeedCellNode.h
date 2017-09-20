//
//  ARTArticleFeedCellNode.h
//  Articles
//
//  Created by Bob Law on 9/19/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class ARTArticle;

@interface ARTArticleFeedCellNode : ASCellNode

- (instancetype __nullable)initWithArticle:(ARTArticle * __nullable)article;

@end
