//
//  NSObject+Utility.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/6.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "NSObject+Utility.h"
#import <objc/runtime.h>

@implementation NSObject (Utility)

- (NSString *)className{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

-(void)helloBoy{
    NSLog(@"category");
}

-(void)setTeAssco:(NSString *)teAssco{
    objc_setAssociatedObject(self, @"9099876", teAssco, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)teAssco{
    NSString *object = objc_getAssociatedObject(self, @"9099876");
    return object;
}

@end
