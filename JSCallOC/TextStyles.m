//
//  TextStyles.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/21.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "TextStyles.h"
#import <UIKit/UIKit.h>

@implementation TextStyles

+ (NSDictionary *)nameStyle{
    return @{
             NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0],
             NSForegroundColorAttributeName: [UIColor blackColor],
             NSBackgroundColorAttributeName: [UIColor blueColor]
             };
}

-(void)whichWillBeFirst{
    NSLog(@"original First!!!");
}

@end
