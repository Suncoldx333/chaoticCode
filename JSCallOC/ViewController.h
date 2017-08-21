//
//  ViewController.h
//  JSCallOC
//
//  Created by wangdan on 15/11/17.
//  Copyright © 2015年 wangdan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <objc/runtime.h>
#import "UIViewController+testSubFunc.h"

@interface ViewController : UIViewController<CAAnimationDelegate>

-(void)testParent;

@property (nonatomic,strong) UIView *testView;
@property (nonatomic,strong) NSString *teStronStr;
@property (nonatomic,copy) NSBlockOperation *blovk;
@property (nonatomic,copy) NSBlockOperation *blovk2;

@end

