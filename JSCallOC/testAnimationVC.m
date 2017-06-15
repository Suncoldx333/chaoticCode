//
//  testAnimationVC.m
//  JSCallOC
//
//  Created by WangZhaoyun on 2017/6/15.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "testAnimationVC.h"
#import "MayIHelpYou-Swift.h"

@interface testAnimationVC ()

@end

@implementation testAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    testAniView *aniView = [[testAniView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    [self.view addSubview:aniView];
}

@end
