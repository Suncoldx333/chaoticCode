//
//  ViewController.h
//  JSCallOC
//
//  Created by wangdan on 15/11/17.
//  Copyright © 2015年 wangdan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import <objc/runtime.h>
#import "UIViewController+testSubFunc.h"
#import "teOperation.h"

@interface ViewController : UIViewController<CAAnimationDelegate>

-(void)testParent;

@property (nonatomic,strong) UIView *testView;
@property (nonatomic,strong) NSString *teStronStr;
@property (nonatomic,copy) NSBlockOperation *blovk;
@property (nonatomic,copy) NSBlockOperation *blovk2;
@property (nonatomic,copy) teOperation *teOpera;

@end

