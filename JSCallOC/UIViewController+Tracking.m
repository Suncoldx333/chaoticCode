//
//  UIViewController+Tracking.m
//  JSCallOC
//
//  Created by 11111 on 2017/5/27.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swizzle_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMwthod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMwthod), method_getTypeEncoding(swizzledMwthod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMwthod);
        }
    });
}

-(void)swizzle_viewWillAppear:(BOOL)animated{
    [self swizzle_viewWillAppear:animated];
    NSLog(@"swizzledViewWillAppear : %@",self);
}

@end
