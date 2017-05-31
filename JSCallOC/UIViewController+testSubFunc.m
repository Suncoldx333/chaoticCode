//
//  UIViewController+testSubFunc.m
//  JSCallOC
//
//  Created by 11111 on 2017/5/8.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "UIViewController+testSubFunc.h"

@implementation UIViewController (testSubFunc)

-(void)showWhereFuncIs{
    NSLog(@"hereIsCata");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

@end
