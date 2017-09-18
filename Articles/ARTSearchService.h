//
//  ARTSearchService.h
//  Articles
//
//  Created by Bob Law on 9/18/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARTAPIClient;

@interface ARTSearchService : NSObject

- (instancetype __nullable)initWithAPIClient:(ARTAPIClient * __nullable)APIClient;

@end
