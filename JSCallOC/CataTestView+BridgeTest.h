//
//  CataTestView+BridgeTest.h
//  JSCallOC
//
//  Created by WangZhaoyun on 2017/7/16.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "CataTestView.h"

@interface CataTestView (BridgeTest)

@property (nonatomic,copy) NSString *sign;

-(NSString *)makeSign;

@end
