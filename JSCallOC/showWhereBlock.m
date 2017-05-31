//
//  showWhereBlock.m
//  JSCallOC
//
//  Created by 11111 on 2017/5/8.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "showWhereBlock.h"

@implementation showWhereBlock

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        void (^myBlockLocation)() = ^(){
            NSLog(@"hello block");
        };
        myBlockLocation();
    }
    return self;
}

@end
