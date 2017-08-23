//
//  BDDiffView.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BDDiffView.h"

@implementation BDDiffView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [hexColor(0x00c18b) colorWithAlphaComponent:0.2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [self addGestureRecognizer:tap];
    
}

-(void)tapEvent:(UITapGestureRecognizer *)sender{
    
    CGFloat x = [sender locationInView:self].x;
    if (x < ScreenWidth / 2) {
        self.testBlock();
    }else{
        [self.delegate tapEventFunc];
    }
    
}

@end
