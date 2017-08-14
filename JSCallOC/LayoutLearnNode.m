//
//  LayoutLearnNode.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/12.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "LayoutLearnNode.h"

@implementation LayoutLearnNode{
    ASTextNode *usernameNode;
    ASTextNode *postLocationNode;
    ASTextNode *postTimeNode;
}

-(instancetype)init{
    if (self = [super init]) {
        
        [self initUI];
        
    }
    return self;
}

-(void)initUI{
    usernameNode = [[ASTextNode alloc] init];
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0f] };
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"usrname" attributes:attrs];
    usernameNode.attributedText = string;
    
    postLocationNode = [[ASTextNode alloc] init];
    NSAttributedString *string_post = [[NSAttributedString alloc] initWithString:@"postLocation" attributes:attrs];
    postLocationNode.attributedText = string_post;
    
    postTimeNode = [[ASTextNode alloc] init];
    NSAttributedString *string_time = [[NSAttributedString alloc] initWithString:@"postTime" attributes:attrs];
    postTimeNode.attributedText = string_time;
    
    
    [self addSubnode:usernameNode];
    [self addSubnode:postLocationNode];
    [self addSubnode:postTimeNode];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    // when the username / location text is too long,
    // shrink the stack to fit onscreen rather than push content to the right, offscreen
    ASStackLayoutSpec *nameLocationStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    nameLocationStack.style.flexShrink = 1.0;
    nameLocationStack.style.flexGrow = 1.0;
    
    // if fetching post location data from server,
    // check if it is available yet and include it if so
    nameLocationStack.children = @[usernameNode,postLocationNode];

    
    // horizontal stack
    ASStackLayoutSpec *headerStackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                 spacing:40
                                                                          justifyContent:ASStackLayoutJustifyContentSpaceAround
                                                                              alignItems:ASStackLayoutAlignItemsCenter
                                                                                children:@[usernameNode, postTimeNode]];
    
    // inset the horizontal stack
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) child:headerStackSpec];
}

@end
