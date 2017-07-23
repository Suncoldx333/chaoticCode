//
//  CataTestView.m
//  JSCallOC
//
//  Created by WangZhaoyun on 2017/7/16.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "CataTestView.h"

@implementation CataTestView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor grayColor];
}

@end
