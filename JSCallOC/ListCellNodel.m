//
//  ListCellNodel.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/21.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "ListCellNodel.h"
#import "TextStyles.h"

@implementation ListCellNodel{
    ASTextNode *author;
    ASTextNode *year;
    ASTextNode *speechName;
    ASDisplayNode *underLine;
    NSMutableArray *children;
}

-(instancetype)initWithModel:(CellNodeModel *)model{
    if (self = [super init]) {
        [self initUIWith:model];
    }
    return self;
}

-(void)initUIWith:(CellNodeModel *)model{
    
    children = [[NSMutableArray alloc] init];
    
    underLine = [[ASDisplayNode alloc] init];
    underLine.backgroundColor = hexColor(0xb2b2b2);
    [self addSubnode:underLine];
    
    author = [[ASTextNode alloc] init];
    author.attributedText = [[NSAttributedString alloc] initWithString:model.author attributes:[TextStyles nameStyle]];
    [self addSubnode:author];
    [children addObject:author];
//    author.style.width = ASDimensionMakeWithPoints(30);
//    author.style.height = ASDimensionMakeWithPoints(30);
    author.style.spacingBefore = 5;
    author.style.spacingAfter = 5;
    
    year = [[ASTextNode alloc] init];
    if (model.year != nil) {
        year.attributedText = [[NSAttributedString alloc] initWithString:model.year attributes:[TextStyles nameStyle]];
        [self addSubnode:year];
        [children addObject:year];
        year.style.spacingBefore = 10;
        year.style.spacingAfter = 10;
    }
    
    speechName = [[ASTextNode alloc] init];
    speechName.attributedText = [[NSAttributedString alloc] initWithString:model.speechName attributes:[TextStyles nameStyle]];
    [self addSubnode:speechName];
    [children addObject:speechName];
    speechName.style.spacingBefore = 15;
    speechName.style.spacingAfter = 15;
    
    for (ASDisplayNode *node in self.subnodes) {
        if (node.supportsLayerBacking) {
            node.layerBacked = YES;
        }
    }
    
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    ASStackLayoutSpec *hori = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                      spacing:0
                                                               justifyContent:ASStackLayoutJustifyContentStart
                                                                   alignItems:ASStackLayoutAlignItemsStart
                                                                     children:children];
    return hori;
    
}

-(void)didLoad{
    [super didLoad];
}

-(void)layout{
    [super layout];
    NSLog(@"height = %f",self.bounds.size.height);
    underLine.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
}

@end
