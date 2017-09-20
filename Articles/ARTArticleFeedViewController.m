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
#import "ARTArticle.h"

@import SafariServices;

@interface ARTArticleFeedViewController () <ASTableDataSource, ASTableDelegate>

@property (nonatomic, strong) ASTableNode *tableNode;

@property (nonatomic, strong) ARTArticleService *articleService;

@property (nonatomic, strong) NSArray <ARTArticle *> *articles;

@end

@implementation ARTArticleFeedViewController

- (instancetype)initWithArticleService:(ARTArticleService *)articleService
{
  _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
  
  if (self = [super initWithNode:_tableNode]) {
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    
    _articleService = articleService;
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"Feed";
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarButtonItemPressed:)];
    
  self.tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
  
  [self.articleService fetchArticlesFeedWithPageURLString:nil completion:^(ARTArticleFeedResult * _Nullable feedResult, NSError * _Nullable error) {
    self.articles = feedResult.articles;
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
  return self.articles.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ARTArticle *article = self.articles[indexPath.row];
  
  return ^{
    ARTArticleFeedCellNode *feedCellNode = [[ARTArticleFeedCellNode alloc] initWithArticle:article];
    return feedCellNode;
  };
}

#pragma mark - ASTableDelegate

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ARTArticle *article = self.articles[indexPath.row];

  SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:article.URL];
  safariViewController.title = article.title;
  
  [self.navigationController pushViewController:safariViewController animated:YES];
}

@end
