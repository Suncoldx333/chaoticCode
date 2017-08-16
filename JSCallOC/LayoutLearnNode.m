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
    
    ASStackLayoutSpec *layouts;
    NSMutableArray *children;
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
    usernameNode.backgroundColor = hexColor(0xffffff);
    usernameNode.attributedText = string;
    
    postLocationNode = [[ASTextNode alloc] init];
    NSAttributedString *string_post = [[NSAttributedString alloc] initWithString:@"postLocation" attributes:attrs];
    postLocationNode.backgroundColor = hexColor(0xffffff);
    postLocationNode.attributedText = string_post;
    
    postTimeNode = [[ASTextNode alloc] init];
    NSAttributedString *string_time = [[NSAttributedString alloc] initWithString:@"postTime" attributes:attrs];
    postTimeNode.backgroundColor = hexColor(0xffffff);
    postTimeNode.attributedText = string_time;
    usernameNode.style.spacingAfter = 5;
    
    postLocationNode.style.spacingBefore = 10;
    postLocationNode.style.spacingAfter = 10;
    
    postTimeNode.style.spacingBefore = 15;
    
    [self addSubnode:usernameNode];
    [self addSubnode:postLocationNode];
    [self addSubnode:postTimeNode];
    children = [[NSMutableArray alloc] init];
    [children addObject:usernameNode];
//    [children addObject:postLocationNode];
    [children addObject:postTimeNode];
    
    layouts = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                      spacing:0
                                               justifyContent:ASStackLayoutJustifyContentStart
                                                   alignItems:ASStackLayoutAlignItemsStart
                                                     children:children];
}

-(void)changdText:(NSString *)text{
    
    NSLog(@"time out!");
    [children removeObject:postLocationNode];
//    layouts = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
//                                                      spacing:0
//                                               justifyContent:ASStackLayoutJustifyContentStart
//                                                   alignItems:ASStackLayoutAlignItemsStart
//                                                     children:children];
//    
//    [self setNeedsLayout];
    
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) child:layouts];
}

@end
