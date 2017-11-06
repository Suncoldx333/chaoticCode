//
//  WeexComponent.m
//  JSCallOC
//
//  Created by 11111 on 2017/10/24.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "WeexComponent.h"

@implementation WeexComponent

-(instancetype)initWithRef:(NSString *)ref
                      type:(NSString *)type
                    styles:(NSDictionary *)styles
                attributes:(NSDictionary *)attributes
                    events:(NSArray *)events
              weexInstance:(WXSDKInstance *)weexInstance{
    if (self = [super initWithRef:ref
                             type:type
                           styles:styles
                       attributes:attributes
                           events:events
                     weexInstance:weexInstance]) {
        
    }
    return self;
}

@end
