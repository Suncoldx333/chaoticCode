//
//  InnerSizeNode.h
//  JSCallOC
//
//  Created by 11111 on 2017/8/21.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface InnerSizeNode : ASDisplayNode

@property (nonatomic,copy) void(^innerHeightCalBlock)(CGFloat height);

@end
