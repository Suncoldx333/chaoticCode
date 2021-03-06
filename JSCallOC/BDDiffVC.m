//
//  BDDiffVC.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BDDiffVC.h"
#import "BDDiffView.h"

typedef enum : NSUInteger {
    holo = 1,
    sorry = 2,
    shit = 3,
} Clause;

@interface BDDiffVC ()<BDDiffViewDelegate>

@end

@implementation BDDiffVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    
    NSString *willChangeStr = @"12#23#34#45#56#67#78";
    NSArray *changedArr = [willChangeStr componentsSeparatedByString:@"#"];
    NSString *reChangeStr = [changedArr componentsJoinedByString:@"~"];
    NSLog(@"reStr = %@",reChangeStr);
    
    NSInteger hello = 12;
    
    switch (hello) {
        case 23:
            NSLog(@"now switch 12");
            break;
            
        case 12:
            NSLog(@"now switch 23");
            break;
            
        default:
            NSLog(@"break");
            break;
    }
    
    if (hello == 12) {
        NSLog(@"now if 12");
    }else if (hello == 23){
        NSLog(@"now if 23");
    }else{
        NSLog(@"now if default");
    }
}

-(void)initUI{
    
    self.view.backgroundColor = hexColor(0xffffff);
    
    BDDiffView *view = [[BDDiffView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    view.delegate = self;
    __weak typeof(self) weakSelf = self;
    view.testBlock = ^{
        [weakSelf tapEventFunc];
    };
    [self.view addSubview:view];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth / 2, 300)];
    bgView.backgroundColor = hexColor(0xe6e6e6);
    [self.view addSubview:bgView];
    
    UIView *sub = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / 4, 0, ScreenWidth / 2, 100)];
    sub.backgroundColor = hexColor(0x404040);
    [bgView addSubview:sub];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEventFunc)];
    [sub addGestureRecognizer:tap];
    
}

-(void)tapEventFunc{
    NSLog(@"delegate");
}

@end
