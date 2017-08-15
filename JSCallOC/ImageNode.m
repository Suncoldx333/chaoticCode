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
    ASDisplayNode *show;
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
    
    show = [[ASDisplayNode alloc] init];
    show.backgroundColor = hexColor(0x404040);
//    [self addSubnode:show];
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 10, 15, 20) child:netImage];
}

@end
