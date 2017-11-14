//
//  BackgroundNode.m
//  JSCallOC
//
//  Created by 11111 on 2017/11/1.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BackgroundNode.h"
#import "BasicNode.h"
#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>
#import "testView.h"

@implementation BackgroundNode{
    BasicNode *bgNode;
    ASTextNode *hahaNode;
    ASNetworkImageNode *imagenode;
    ASDisplayNode *disnode;
    testView *test;
}

+(void)drawRect:(CGRect)bounds withParameters:(id)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing{
    CGFloat locations[2];
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:2];
    [colors addObject:(id)[hexColor(0xffffff) CGColor]];
    locations[0] = 0.0;
    [colors addObject:(id)[hexColor(0x333333) CGColor]];
    locations[1] = 1.0;
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
    
    CGContextDrawLinearGradient(ctx, gradient, CGPointZero, CGPointMake(bounds.size.width, bounds.size.height), 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

-(instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = hexColor(0xe6e6e6);
    
    test = [[testView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self.view addGestureRecognizer:tap];
    
    disnode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        return test;
    }];
    disnode.style.preferredSize = CGSizeMake(50, 50);
    [self addSubnode:disnode];
    
    bgNode = [[BasicNode alloc] init];
    bgNode.backgroundColor = hexColor(0xffffff);
    bgNode.style.preferredSize = CGSizeMake(100, 100);
    bgNode.cornerRadius = 50;
    [self addSubnode:bgNode];

    hahaNode = [[ASTextNode alloc] init];
    hahaNode.attributedText = [self createnEWAttr];
    hahaNode.backgroundColor = hexColor(0xffffff);
    hahaNode.style.spacingBefore = 10;
    hahaNode.maximumNumberOfLines = 2;
    [self addSubnode:hahaNode];

    self.textNode = [[ASTextNode alloc] init];
//    self.textNode.style.preferredSize = CGSizeMake(90, 20);
    self.textNode.backgroundColor = hexColor(0xb2b2b2);
    self.textNode.attributedText = [self createAttr];

    __weak typeof(self) weakSelf = self;
    bgNode.sizeThatFitBlock = ^ASLayoutSpec *(ASSizeRange constrainedSize) {
        ASCenterLayoutSpec *center = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionDefault child:weakSelf.textNode];
        return  center;
    };
    [bgNode addSubnode:self.textNode];

}

-(void)tapEvent{
    test.backgroundColor = [hexColor(0xff4438) colorWithAlphaComponent:0.2];
}

-(NSMutableAttributedString *)createAttr{
    NSString *a = @"签到";
    NSString *b = @"00:00:00";
    NSString *title = [NSString stringWithFormat:@"%@\n%@",a,b];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:title];

    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.paragraphSpacing = 10;
    para.alignment = NSTextAlignmentCenter;

    [attr addAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:hexColor(0x333333),NSForegroundColorAttributeName,para,NSParagraphStyleAttributeName, nil] range:NSMakeRange(0, title.length)];
    [attr addAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:30],NSFontAttributeName,nil] range:NSMakeRange(0, a.length)];
    [attr addAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName, nil] range:NSMakeRange(a.length + 1, b.length)];
    return attr;
}

-(NSMutableAttributedString *)createnEWAttr{
    NSString *a = @"签到";
    NSString *b = @"00:00:00";
    NSString *title = [NSString stringWithFormat:@"%@\n%@",a,b];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:title];

    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.paragraphSpacing = 10;
    para.alignment = NSTextAlignmentCenter;

    [attr addAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:hexColor(0x333333),NSForegroundColorAttributeName,para,NSParagraphStyleAttributeName, nil] range:NSMakeRange(0, title.length)];
    [attr addAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:20],NSFontAttributeName,nil] range:NSMakeRange(0, a.length)];
    [attr addAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:20],NSFontAttributeName, nil] range:NSMakeRange(a.length + 1, b.length)];
    return attr;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{

    ASStackLayoutSpec *veri = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                      spacing:0
                                                               justifyContent:ASStackLayoutJustifyContentStart
                                                                   alignItems:ASStackLayoutAlignItemsCenter
                                                                     children:@[disnode,bgNode,hahaNode]];
    return veri;
}

@end
