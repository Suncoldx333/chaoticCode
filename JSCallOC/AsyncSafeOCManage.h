//
//  AsyncSafeOCManage.h
//  JSCallOC
//
//  Created by 11111 on 2017/8/25.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncSafeOCManage : NSObject

@property (nonatomic,strong) NSMutableArray<NSString *> *dataArr;

-(void)traverseArr;
-(void)deleteArr;

@end
