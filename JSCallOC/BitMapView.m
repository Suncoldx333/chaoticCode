//
//  BitMapView.m
//  JSCallOC
//
//  Created by 11111 on 2017/7/28.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BitMapView.h"

@implementation BitMapView{
    CGRect imageRect;
    CGPoint imagePoint;
    
    UILabel *timeLag;
}

@synthesize image;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"countDownBg"];
        [self initData]; //这种写法是错误的，VIEW不应该存在数据处理
    }
    return self;
}

-(void)initData{
    imageRect = CGRectMake(0, 0, 100, 100);
    imagePoint = CGPointMake(0, 0);
    
    self.backgroundColor = [UIColor grayColor];
    
    timeLag = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 100, 20)];
    timeLag.backgroundColor = [UIColor whiteColor];
    timeLag.textColor = [UIColor blackColor];
    [self addSubview:timeLag];
}

-(void)drawRect:(CGRect)rect{
    if (CGRectEqualToRect(rect, imageRect)) {
        uint64_t start = clock();
        [image drawAtPoint:imagePoint];
        uint64_t drawTime = clock() - start;
        
        NSString *lag = [[NSString alloc] initWithFormat:@"%llu",drawTime];
        timeLag.text = lag;
    }
}

@end
