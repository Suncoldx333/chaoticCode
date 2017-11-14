//
//  testView.m
//  JSCallOC
//
//  Created by 11111 on 2017/11/7.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "testView.h"

@implementation testView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = hexColor(0x00c18b);
    UIView *tt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    tt.backgroundColor = hexColor(0xffffff);
    [self addSubview:tt];
}

@end
