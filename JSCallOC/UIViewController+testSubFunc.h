//
//  UIViewController+testSubFunc.h
//  JSCallOC
//
//  Created by 11111 on 2017/5/8.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (testSubFunc)<UITableViewDelegate,UITableViewDataSource>

-(void)showWhereFuncIs;
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

@end
