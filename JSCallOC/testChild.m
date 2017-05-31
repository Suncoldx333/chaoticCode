//
//  testChild.m
//  JSCallOC
//
//  Created by 11111 on 2017/3/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "testChild.h"

@interface testChild ()

@end

@implementation testChild

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testParent];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testParent{
    [super testParent];
}

@end
