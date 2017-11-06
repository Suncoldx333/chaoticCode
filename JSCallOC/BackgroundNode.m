//
//  BackgroundNode.m
//  JSCallOC
//
//  Created by 11111 on 2017/11/1.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BackgroundNode.h"
#import "BasicNode.h"

@implementation BackgroundNode{
    BasicNode *bgNode;
    ASTextNode *hahaNode;
}

-(instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = hexColor(0xe6e6e6);
    
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
                                                                     children:@[bgNode,hahaNode]];
    return veri;
}

@end
