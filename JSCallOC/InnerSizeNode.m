//
//  InnerSizeNode.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/21.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "InnerSizeNode.h"

@implementation InnerSizeNode{
    ASDisplayNode *view1;
    ASDisplayNode *view2;
}

-(instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    view1 = [[ASDisplayNode alloc] init];
    view1.backgroundColor = hexColor(0x404040);
    [self addSubnode:view1];
    
    view2 = [[ASDisplayNode alloc] init];
    view2.backgroundColor = hexColor(0x404040);
    [self addSubnode:view2];
    
    for (ASDisplayNode *node in self.subnodes) {
        if (node.supportsLayerBacking) {
            node.layerBacked = YES;
        }
    }
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    view1.style.preferredSize = CGSizeMake(50, 30);
    view1.style.spacingBefore = 5;
    view1.style.spacingAfter = 5;
    
    view2.style.preferredSize = CGSizeMake(100, 50);
    view2.style.spacingBefore = 10;
    view2.style.spacingAfter = 30;
    
    ASStackLayoutSpec *spec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                      spacing:0
                                                               justifyContent:ASStackLayoutJustifyContentStart
                                                                   alignItems:ASStackLayoutAlignItemsStart
                                                                     children:@[view1,view2]];
    return spec;
    
}

-(void)layout{
    [super layout];
//    CGFloat x = self.frame.origin.x;
//    CGFloat y = self.frame.origin.y;
//    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
//    NSLog(@"x = %f,y = %f,width = %f,height = %f",x,y,width,height);
    self.innerHeightCalBlock(height);
}

@end
