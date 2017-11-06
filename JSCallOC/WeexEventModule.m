//
//  WeexEventModule.m
//  JSCallOC
//
//  Created by 11111 on 2017/10/16.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "WeexEventModule.h"
#import <WeexSDK/WXBaseViewController.h>
#import "WeexVC.h"

@implementation WeexEventModule

@synthesize weexInstance;
WX_EXPORT_METHOD_SYNC(@selector(makescreenwidth))
WX_EXPORT_METHOD_SYNC(@selector(makeNewImageUrl))
WX_EXPORT_METHOD_SYNC(@selector(getInstanceId:))

-(CGFloat)makescreenwidth{
    NSLog(@"ask for width");
    return 200 * 2;
}

-(NSString *)makeNewImageUrl{
    NSString *newImage = @"http://swapp-test-images.oss-cn-hangzhou.aliyuncs.com/dynamic-img/20170805/80bcdf48c6d46797ca21cbedc5726cde.jpg";
    return newImage;
}

-(void)getInstanceId:(WXModuleCallback)callback{
    callback(@{@"id" : weexInstance.instanceId});
}

@end
