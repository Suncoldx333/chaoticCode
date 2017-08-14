//
//  LLDBLearnObject+NewVar.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/14.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "LLDBLearnObject+NewVar.h"
#import <objc/runtime.h>

@implementation LLDBLearnObject (NewVar)

-(NSString *)varByCata{
    
    NSString *var = objc_getAssociatedObject(self, @"hello");
    return var;
    
}

-(void)setVarByCata:(NSString *)varByCata{
    
    objc_setAssociatedObject(self, @"hello", varByCata, OBJC_ASSOCIATION_ASSIGN);
    
}

@end
