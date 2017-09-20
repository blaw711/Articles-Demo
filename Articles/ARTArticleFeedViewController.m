//
//  ARTArticleFeedViewController.m
//  Articles
//
//  Created by Bob Law on 9/18/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTArticleFeedViewController.h"
#import "ARTArticleService.h"
#import "ARTArticleFeedResult.h"
#import "ARTArticleFeedCellNode.h"
#import "ARTArticleFeedViewModel.h"
#import "ARTArticle.h"

@import SafariServices;

@interface ARTArticleFeedViewController () <ASTableDataSource, ASTableDelegate>

@property (nonatomic, strong) ASTableNode *tableNode;

@property (nonatomic, strong) ARTArticleService *articleService;

@property (nonatomic, strong) NSArray <ARTArticle *> *articles;

@property (nonatomic, strong) ARTArticleFeedViewModel *viewModel;

@end

@implementation ARTArticleFeedViewController

- (instancetype)initWithArticleService:(ARTArticleService *)articleService
{
  _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
  
  if (self = [super initWithNode:_tableNode]) {
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    
    _articleService = articleService;
    
    _viewModel = [[ARTArticleFeedViewModel alloc] initWithArticleService:articleService];
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"Feed";
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarButtonItemPressed:)];
    
  self.tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
  
  [self.viewModel pageArticleFeedWithCompletion:^(NSArray * _Nullable articles, NSError * _Nullable error) {
    [self.tableNode reloadData];
  }];
}

#pragma mark - Action Handlers

- (void)searchBarButtonItemPressed:(id)sender
{
  
}

#pragma mark - ASTableDataSource

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode
{
  return 1;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
  return [self.viewModel numberOfRows];
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ARTArticle *article = [self.viewModel articleForIndexPath:indexPath];
  
  return ^{
    ARTArticleFeedCellNode *feedCellNode = [[ARTArticleFeedCellNode alloc] initWithArticle:article];
    return feedCellNode;
  };
}

#pragma mark - ASTableDelegate

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ARTArticle *article = [self.viewModel articleForIndexPath:indexPath];

  SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:article.URL];
  safariViewController.title = article.title;
  
  [self.navigationController pushViewController:safariViewController animated:YES];
}

- (BOOL)shouldBatchFetchForTableNode:(ASTableNode *)tableNode
{
  return [self.viewModel canFetchMorePages];
}

- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context
{
  [self.viewModel pageArticleFeedWithCompletion:^(NSArray * _Nullable articles, NSError * _Nullable error) {
    if (articles.count > 0) {
      [self insertArticles:articles completion:^(BOOL finished) {
        [context completeBatchFetching:YES];
      }];
    } else {
      [context completeBatchFetching:YES];
    }
  }];
}

#pragma mark - Convenience Methods

// methods calculates the indexPaths for the new articles and inserts them into the tableNode
- (void)insertArticles:(NSArray <ARTArticle *> *)articles completion:(void(^)(BOOL finished))completion
{
  NSInteger section = 0;
  NSMutableArray *indexPaths = [NSMutableArray new];
  NSInteger totalNewArticles = [self.viewModel numberOfRows];
  
  for (NSInteger row = (totalNewArticles - articles.count); row < totalNewArticles; row++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
    [indexPaths addObject:indexPath];
  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableNode performBatchAnimated:NO updates:^{
      [self.tableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    } completion:^(BOOL finished) {
      if (completion) {
        completion(finished);
      }
    }];
  });
}

@end
