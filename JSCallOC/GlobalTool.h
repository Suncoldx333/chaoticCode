//
//  GlobalTool.h
//  JSCallOC
//
//  Created by 11111 on 2017/4/11.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define hexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface GlobalTool : NSObject

+(void)storeLogWithDocumentFolder;

/**
 生成包含Emoji的数组

 @return 包含Emoji的数组
 */
+(NSArray<NSString *> *)createEmojis;

@end
