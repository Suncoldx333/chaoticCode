//
//  BasicNode.m
//  JSCallOC
//
//  Created by 11111 on 2017/11/3.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BasicNode.h"

@implementation BasicNode

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    OverviewDisplayNodeSizeThatFitsBlock block = self.sizeThatFitBlock;
    if (block != nil) {
        return block(constrainedSize);
    }
    return [super layoutSpecThatFits:constrainedSize];
    
}

@end
