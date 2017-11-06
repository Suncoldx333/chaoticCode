//
//  WeexVC.m
//  JSCallOC
//
//  Created by 11111 on 2017/10/16.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "WeexVC.h"
#import <WeexSDK/WXSDKInstance.h>
#import "WeexComponent.h"

@interface WeexVC (){
    BOOL resume;
}

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, assign) CGFloat weexHeight;

@end

@implementation WeexVC

#pragma mark - View lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    _weexHeight = ScreenHeight - 64 - 64;

    [self render];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc{
    [_instance destroyInstance];
}

#pragma mark -InitBaseUI
-(void)initUI{
    self.view.backgroundColor = hexColor(0xffffff);
}

#pragma mark - configure
-(void)render{
    [_instance destroyInstance];
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = CGRectMake(0, 64, 375, _weexHeight);
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, weakSelf.weexView);
    };
    
    _instance.renderFinish = ^(UIView *view) {
        NSLog(@"render finish");
        
        [weakSelf deliverImageUrl];
    };
    
    NSString *urlStr = [NSString stringWithFormat:@"file://%@/index.js",[NSBundle mainBundle].bundlePath];
    
    [_instance renderWithURL:[NSURL URLWithString:urlStr] options:@{@"bundleUrl":urlStr} data:nil];
}

-(void)deliverImageUrl{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) 4000.000 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:@"http://swapp-test-images.oss-cn-hangzhou.aliyuncs.com/dynamic-img/20170805/80bcdf48c6d46797ca21cbedc5726cde.jpg",@"imageUrl", nil];
        [_instance fireGlobalEvent:@"OpenTranslate" params:info];
    });
    
}

@end
