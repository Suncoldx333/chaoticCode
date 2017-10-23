//
//  WeexImageLoader.m
//  JSCallOC
//
//  Created by 11111 on 2017/10/19.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "WeexImageLoader.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation WeexImageLoader

-(id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url
                                         imageFrame:(CGRect)imageFrame
                                           userInfo:(NSDictionary *)options
                                          completed:(void (^)(UIImage *, NSError *, BOOL))completedBlock{
    NSURL *newURL = [NSURL URLWithString:url];
    return (id<WXImageOperationProtocol>)[[SDWebImageManager sharedManager] loadImageWithURL:newURL
                                                                                     options:0
                                                                                    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                                                                                        
                                                                                    }
                                                                                   completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                                                                                       if (completedBlock) {
                                                                                           completedBlock(image,error,finished);
                                                                                       }
                                                                                   }];

}

@end
