//
//  ImageNode.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/15.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "ImageNode.h"

@implementation ImageNode{
    ASNetworkImageNode *netImage;
}

-(instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    netImage = [[ASNetworkImageNode alloc] init];
    netImage.layerBacked = YES;
    netImage.contentMode = UIViewContentModeScaleAspectFill;
    netImage.defaultImage = [UIImage imageNamed:@"topicGuide"];
    netImage.cropRect = CGRectMake(1, 0, 0, 0);
    [netImage setURL:[NSURL URLWithString:@"http://gxapp-images.oss-cn-hangzhou.aliyuncs.com/news-images/20170510/5387f9a7c2af45eda6a70ceea78d8bac.jpg"] resetToDefault:YES];
    [self addSubnode:netImage];
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *spec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    spec.children = @[netImage];
//    netImage.style.preferredSize = CGSizeMake(50, 50);
//    spec.style.flexGrow = 1.0;
//    spec.style.flexShrink = 1.0;
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:spec];
}

@end
