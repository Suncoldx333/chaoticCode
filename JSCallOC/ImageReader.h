//
//  ImageReader.h
//  JSCallOC
//
//  Created by 11111 on 2017/5/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageReader : NSObject
+ (instancetype)shareInstance;
-(void)whereXCAssetsLocation;
-(void)runDataAna;

@end
