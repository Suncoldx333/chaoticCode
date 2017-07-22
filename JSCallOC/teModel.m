//
//  teModel.m
//  JSCallOC
//
//  Created by 11111 on 2017/7/20.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "teModel.h"

@implementation teModel

-(void)arrInsertFunc{
    NSMutableArray *teArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 8; i ++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [teArr addObject:num];
    }
    
//    [teArr removeObjectAtIndex:10];
}

@end
