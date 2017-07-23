//
//  CataTestView+BridgeTest.m
//  JSCallOC
//
//  Created by WangZhaoyun on 2017/7/16.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "CataTestView+BridgeTest.h"
#import <objc/runtime.h>

#define signKey @"signKey"

@implementation CataTestView (BridgeTest)

-(void)setSign:(NSString *)sign{
    
    objc_setAssociatedObject(self, signKey, sign, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

-(NSString *)sign{
    
    return objc_getAssociatedObject(self, signKey);
}

-(NSString *)makeSign{
    NSString *sign = @"sssssss";
    return sign;
}

@end
