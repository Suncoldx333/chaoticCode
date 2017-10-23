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
WX_EXPORT_METHOD_SYNC(@selector(getStringWidthby:))
WX_EXPORT_METHOD_SYNC(@selector(makescreenwidth))

-(float)getStringWidthby:(NSDictionary *)att{
//    UILabel *calLabel = [[UILabel alloc] init];
//    calLabel.font = [UIFont systemFontOfSize:[att[@"font"] floatValue]];
//    calLabel.text = att[@"string"];
//    [calLabel sizeToFit];
//    CGFloat newWidth = calLabel.frame.size.width;
    return 300;
}
-(CGFloat)makescreenwidth{
    NSLog(@"ask for width");
    return 200 * 2;
}

@end
