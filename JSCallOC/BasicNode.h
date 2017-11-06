//
//  BasicNode.h
//  JSCallOC
//
//  Created by 11111 on 2017/11/3.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

typedef ASLayoutSpec *(^OverviewDisplayNodeSizeThatFitsBlock)(ASSizeRange constrainedSize);

@interface BasicNode : ASDisplayNode

@property (nonatomic,copy) OverviewDisplayNodeSizeThatFitsBlock sizeThatFitBlock;

@end
