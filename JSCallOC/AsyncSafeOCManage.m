//
//  AsyncSafeOCManage.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/25.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "AsyncSafeOCManage.h"

@implementation AsyncSafeOCManage

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)traverseArr{
    
    if (self.dataArr == nil) {
        NSLog(@"error!");
        return;
    }
    
    for (NSString *str in self.dataArr) {
        NSLog(@"now show %@",str);
    }
    
}

-(void)deleteArr{
    if (self.dataArr == nil) {
        NSLog(@"error!");
        return;
    }

    [self.dataArr removeAllObjects];
    NSLog(@"after delete count = %lu",(unsigned long)self.dataArr.count);
}

@end
