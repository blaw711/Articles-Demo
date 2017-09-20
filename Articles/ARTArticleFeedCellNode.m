//
//  ARTArticleFeedCellNode.m
//  Articles
//
//  Created by Bob Law on 9/19/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

#import "ARTArticleFeedCellNode.h"
#import <pop/POP.h>
#import "ARTArticle.h"

@interface ARTArticleFeedContentNode : ASDisplayNode

@property (nonatomic, strong, readonly) ASTextNode *titleTextNode;

@property (nonatomic, strong, readonly) ASTextNode *authorTextNode;

@property (nonatomic, strong, readonly) ASTextNode *timestampNode;

@property (nonatomic, strong, readonly) ASNetworkImageNode *networkImageNode;

@end

@implementation ARTArticleFeedContentNode

- (instancetype)init
{
  if (self = [super init]) {
    self.automaticallyManagesSubnodes = YES;

    _titleTextNode = [ASTextNode new];
    _titleTextNode.layerBacked = YES;
    
    _authorTextNode = [ASTextNode new];
    _authorTextNode.layerBacked = YES;
    
    _timestampNode = [ASTextNode new];
    _timestampNode.layerBacked = YES;
    
    _networkImageNode = [ASNetworkImageNode new];
    _networkImageNode.defaultImage = [UIImage as_resizableRoundedImageWithCornerRadius:14 cornerColor:[UIColor clearColor] fillColor:[UIColor colorWithWhite:0.8 alpha:0.7]];
    _networkImageNode.layerBacked = YES;
    
    __weak typeof(self) weakSelf = self;
    _networkImageNode.imageModificationBlock = ^UIImage * _Nullable(UIImage * _Nonnull image) {
      UIImage *modifiedImage;
      CGSize size = weakSelf.networkImageNode.calculatedSize;
      CGRect rect = (CGRect){CGPointZero, size};
      UIGraphicsBeginImageContextWithOptions(size, false, [[UIScreen mainScreen] scale]);
      [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4] addClip];
      [image drawInRect:rect];
      modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      return modifiedImage;
    };
  }
  
  return self;
}

- (void)layoutDidFinish
{
  [super layoutDidFinish];
  
  CAGradientLayer *gradient = [CAGradientLayer layer];
  
  gradient.frame = self.bounds;
  gradient.colors = @[(id)[UIColor colorWithWhite:0.0f alpha:0.0f].CGColor, (id)[UIColor colorWithWhite:0.0f alpha:0.75f].CGColor];
  gradient.locations = @[@(0.45), @(1.0)];
  gradient.cornerRadius = 10.f;
  
  [self.view.layer insertSublayer:gradient atIndex:0];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
  _networkImageNode.style.preferredSize = CGSizeMake(25, 25);
  
  ASLayoutSpec *horizontalSpacer = [ASLayoutSpec new];
  horizontalSpacer.style.flexGrow = YES;
  
  
  ASStackLayoutSpec *verticalAuthorStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0.0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[_authorTextNode, _timestampNode]];
  
  ASStackLayoutSpec *horizontalAuthorStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:8.0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_networkImageNode, verticalAuthorStack, horizontalSpacer]];
  
  ASLayoutSpec *verticalSpacer = [ASLayoutSpec new];
  verticalSpacer.style.flexGrow = YES;
  
  ASStackLayoutSpec *mainVerticalStackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:8.0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[verticalSpacer, _titleTextNode, horizontalAuthorStack]];
  
  return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(7, 10, 7, 10) child:mainVerticalStackSpec];
}

@end

@interface ARTArticleFeedCellNode ()

@property (nonatomic, strong) ASNetworkImageNode *networkImageNode;

@property (nonatomic, strong) ARTArticleFeedContentNode *contentNode;

@property (nonatomic, strong) ARTArticle *article;

@end

@implementation ARTArticleFeedCellNode

- (instancetype)initWithArticle:(ARTArticle *)article
{
  if (self = [super init]) {
    self.automaticallyManagesSubnodes = YES;
    
    _article = article;
    
    _networkImageNode = [ASNetworkImageNode new];
    _networkImageNode.contentMode = UIViewContentModeScaleAspectFill;
    _networkImageNode.layerBacked = YES;
    _networkImageNode.defaultImage = [UIImage as_resizableRoundedImageWithCornerRadius:10.0 cornerColor:[UIColor clearColor] fillColor:ASDisplayNodeDefaultPlaceholderColor()];
    
    __weak typeof(self) weakSelf = self;
    _networkImageNode.imageModificationBlock = ^UIImage * _Nullable(UIImage * _Nonnull image) {
      UIImage *modifiedImage;
      CGSize size = weakSelf.networkImageNode.calculatedSize;
      CGRect rect = (CGRect){CGPointZero, size};
      UIGraphicsBeginImageContextWithOptions(size, false, [[UIScreen mainScreen] scale]);
      [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10] addClip];
      [image drawInRect:rect];
      modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      return modifiedImage;
    };
    
    _contentNode = [ARTArticleFeedContentNode new];
    _contentNode.titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:article.title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}];
    _contentNode.authorTextNode.attributedText = [[NSAttributedString alloc] initWithString:article.author attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]}];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    NSString *timestamp = [dateFormatter stringFromDate:self.article.publishDate];
    
     _contentNode.timestampNode.attributedText = [[NSAttributedString alloc] initWithString:timestamp attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]}];
  }
  
  return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
  ASRatioLayoutSpec *ratioLayout = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:0.65 child:_networkImageNode];

  ASOverlayLayoutSpec *overlaySpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:ratioLayout overlay:_contentNode];
  
  return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:overlaySpec];
}

- (void)didEnterPreloadState
{
  [super didEnterPreloadState];
  
  _networkImageNode.URL = self.article.thumbnailURL;
  _contentNode.networkImageNode.URL = self.article.authorAvatarURL;
}

- (void)setHighlighted:(BOOL)highlighted
{
  [super setHighlighted:highlighted];
  
  if (highlighted) {
    self.backgroundColor = [UIColor whiteColor];
  }
  
  POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  animation.toValue = highlighted ? [NSValue valueWithCGPoint:CGPointMake(1.02, 1.02)] : [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
  animation.duration = 0.2;
  [self.layer pop_addAnimation:animation forKey:kPOPViewSize];
}

- (void)setSelected:(BOOL)selected
{
  if (selected) {
    self.backgroundColor = [UIColor whiteColor];
  }
}

@end
