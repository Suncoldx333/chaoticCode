//
//  MD5Encryption.h
//  SWCampus
//
//  Created by WH on 16/8/26.
//  Copyright © 2016年 SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface MD5Encryption : NSObject

+ (NSString *)getMd5String:(NSString *)srcString;

@end
