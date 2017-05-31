//
//  AniViewCon.m
//  JSCallOC
//
//  Created by 11111 on 2017/5/26.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "AniViewCon.h"
#import "UIViewController+Tracking.h"

@interface AniViewCon ()

@end

@implementation AniViewCon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initUI{
    self.view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
}

@end
