//
//  MD5Encryption.m
//  SWCampus
//
//  Created by WH on 16/8/26.
//  Copyright © 2016年 SL. All rights reserved.
//

#import "MD5Encryption.h"

@implementation MD5Encryption

+ (NSString *)getMd5String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

@end
