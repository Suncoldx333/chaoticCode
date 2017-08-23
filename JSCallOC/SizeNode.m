//
//  SizeNode.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/21.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "SizeNode.h"
#import "InnerSizeNode.h"

@implementation SizeNode{
    ASDisplayNode *staticNode;
    
    ASDisplayNode *testSizeNode1;
    ASDisplayNode *testSizeNode2;
    ASDisplayNode *testSizeNode3;
    ASLayoutSpec *spacer;
    
    InnerSizeNode *inner;
}

-(instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    staticNode = [[ASDisplayNode alloc] init];
    staticNode.style.height = ASDimensionMakeWithPoints(100);
    staticNode.style.width = ASDimensionMakeWithPoints(100);
    staticNode.backgroundColor = hexColor(0xffffff);
//    [self addSubnode:staticNode];
    
    testSizeNode1 = [[ASDisplayNode alloc] init];
    testSizeNode1.layerBacked = YES;
    testSizeNode1.backgroundColor = hexColor(0xffffff);
    testSizeNode1.style.preferredSize = CGSizeMake(30, 30);
    
    
    testSizeNode2 = [[ASDisplayNode alloc] init];
    testSizeNode2.layerBacked = YES;
    testSizeNode2.backgroundColor = hexColor(0xffffff);
    testSizeNode2.style.preferredSize = CGSizeMake(30, 30);
    
    
    testSizeNode3 = [[ASDisplayNode alloc] init];
    testSizeNode3.layerBacked = YES;
    testSizeNode3.backgroundColor = hexColor(0xffffff);
    testSizeNode3.style.preferredSize = CGSizeMake(30, 30);
    
//    [self addSubnode:testSizeNode1];
//    [self addSubnode:testSizeNode2];
//    [self addSubnode:testSizeNode3];
    
    inner = [[InnerSizeNode alloc] init];
    inner.backgroundColor = hexColor(0xe6e6e6);
    inner.layerBacked = YES;
    __weak typeof(self) weakSelf = self;
    inner.innerHeightCalBlock = ^(CGFloat height) {
        weakSelf.heightCalBlock(height);
    };
    [self addSubnode:inner];
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    spacer = [[ASLayoutSpec alloc] init];
    spacer.style.flexGrow = 1;
    
    testSizeNode1.style.spacingBefore = 15;
    testSizeNode2.style.spacingBefore = 15;
    testSizeNode3.style.spacingAfter = 15;
    
    ASStackLayoutSpec *ho = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                    spacing:0
                                                             justifyContent:ASStackLayoutJustifyContentCenter
                                                                 alignItems:ASStackLayoutAlignItemsCenter
                                                                   children:@[testSizeNode1,testSizeNode2,spacer,testSizeNode3]];
    
    ASStackLayoutSpec *staticSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                       spacing:0
                                                                justifyContent:ASStackLayoutJustifyContentStart
                                                                    alignItems:ASStackLayoutAlignItemsStart
                                                                       children:@[staticNode]];
    
    ASInsetLayoutSpec *inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:staticNode];
    
    ASStackLayoutSpec *innerStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                            spacing:0
                                                                     justifyContent:ASStackLayoutJustifyContentStart
                                                                         alignItems:ASStackLayoutAlignItemsStart
                                                                           children:@[inner]];
    
    return innerStack;
    
}

-(void)layout{
    [super layout];
    NSLog(@"height = %f",self.bounds.size.height);
}

@end
