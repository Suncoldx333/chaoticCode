//
//  BDDiffVC.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BDDiffVC.h"
#import "BDDiffView.h"

@interface BDDiffVC ()<BDDiffViewDelegate>

@end

@implementation BDDiffVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
}

-(void)tapEventFunc{
    NSLog(@"delegate");
}

@end
