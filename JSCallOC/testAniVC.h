//
//  testAniVC.h
//  JSCallOC
//
//  Created by 11111 on 2017/6/12.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MayIHelpYou-Swift.h"

typedef NS_ENUM(NSInteger,SwitchType) {
    SwitchTypePath = 0,    //轨迹页面点击切换
    SwitchTypeData = 1,   //数据页面点击切换
};

typedef NS_ENUM(NSInteger,SwitchAnimationType) {
    ShowData = 0,   //展示数据动画
    HidePath = 1,   //隐藏轨迹动画
    ShowPath = 2,   //展示轨迹动画
    HideData = 3    //隐藏数据动画
};

@interface testAniVC : UIViewController

@property (nonatomic,strong) BaseRTPathView *RTPathView;
@property (nonatomic,strong) BaseRTDataView *RTDataView;

@end
