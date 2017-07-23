//
//  teView.m
//  JSCallOC
//
//  Created by 11111 on 2017/7/20.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "teView.h"

@implementation teView

@synthesize count;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    
    count = [NSString stringWithFormat:@"%d",arc4random()%10];
}

-(NSInteger)makeRandom{
    return 9;
}

@end
