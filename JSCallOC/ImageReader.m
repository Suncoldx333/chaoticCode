//
//  ImageReader.m
//  JSCallOC
//
//  Created by 11111 on 2017/5/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "ImageReader.h"
#import <SBJson/SBJson5.h>

@implementation ImageReader

+ (instancetype)shareInstance{
    
    static ImageReader *reader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reader = [[ImageReader alloc] init];

    });
    return reader;
}

-(void)whereXCAssetsLocation{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *appPath = [[NSBundle mainBundle] bundlePath];
    [self findSubPath:appPath];
    
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    for (NSString *path in paths) {
        
        if ([fm fileExistsAtPath:path]) { //文件是否存在,当路径是以缩略形式时，无法打开
            
            BOOL isDir = NO;
            [fm fileExistsAtPath:path isDirectory:&isDir]; //是否是一个目录
            if (isDir) {
                
                NSArray<NSString *> *subPaths = [fm subpathsOfDirectoryAtPath:path error:nil];
                for (NSString *subPath in subPaths) {
                    NSLog(@"%@",subPath);
                }
            }else{
                NSLog(@"is not a Dir");
            }
        }
        
    }
    
}

-(void)runDataAna{
//    NSString *teStr = @"";
    
//    NSMutableDictionary *teDic = [[NSMutableDictionary alloc] init];
//    
//    NSMutableDictionary *hahDic = [[NSMutableDictionary alloc] init];
//    NSMutableArray *hahArr = [[NSMutableArray alloc] init];
//    NSMutableDictionary *hahDic1 = [[NSMutableDictionary alloc] init];
//    [hahDic1 setObject:@"inner" forKey:@"innerKey"];
//    [hahArr addObject:hahDic1];
//    [hahDic setObject:hahArr forKey:@"dickEY"];
//    
//    SBJSON *sb = [[SBJSON alloc] init];
//    teDic = [sb objectWithString:teStr error:nil];
//    
//    NSString *preGainTime;
//    NSString *preTotalTime;
//    
//    NSMutableArray *equalArr = [[NSMutableArray alloc] init];
//    NSMutableArray *unEqualArr = [[NSMutableArray alloc] init];
//    NSMutableArray *totalTimeArr = [[NSMutableArray alloc] init];
//    NSMutableArray *gainTimeDiffArr = [[NSMutableArray alloc] init];
//    NSMutableArray *totalTimeDiffArr = [[NSMutableArray alloc] init];
//    NSMutableArray *AccuracyArr = [[NSMutableArray alloc] init];
//    NSMutableArray *radiusArr = [[NSMutableArray alloc] init];
//    
//    NSMutableArray *typeAgreeArr = [[NSMutableArray alloc] init];
//    
//    NSMutableArray *pointTypeArr = [[NSMutableArray alloc] init];
//    
//    NSMutableArray *jsArr = [teDic objectForKey:@"allLocJson"];
//    for (NSInteger i = 0 ; i < jsArr.count; i++) {
//        NSMutableDictionary *jsDic = [jsArr objectAtIndex:i];
//        
//        NSString *totalTimeStr = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"totaltime"] doubleValue]];
//        NSString *typeStr = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"type"] doubleValue]];
//        NSString *accuracyStr = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"radius"] doubleValue]];
//        NSString *redisStr = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"radius"] doubleValue]];
//        [totalTimeArr addObject:totalTimeStr];
//        [pointTypeArr addObject:typeStr];
//        [AccuracyArr addObject:accuracyStr];
//        [radiusArr addObject:redisStr];
//        if (typeStr.intValue == 0) {
//            [typeAgreeArr addObject:accuracyStr];
//        }
//        
//        if (i == 0) {
//            preGainTime = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"gaintime"] doubleValue]];
//            preTotalTime = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"totaltime"] doubleValue]];
//        }else{
//            NSString *curGainTime = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"gaintime"] doubleValue]];
//            NSString *curTotalTime = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"totaltime"] doubleValue]];
//            
//            double gainTimeDiff = (curGainTime.doubleValue - preGainTime.doubleValue)/1000;
//            double totalTimeDiff = (curTotalTime.doubleValue - preTotalTime.doubleValue)/1;
//            
//            [gainTimeDiffArr addObject:[NSString stringWithFormat:@"%f",gainTimeDiff]];
//            [totalTimeDiffArr addObject:[NSString stringWithFormat:@"%f",totalTimeDiff]];
//            
//            preTotalTime = curTotalTime;
//            preGainTime = curGainTime;
//            
//            if (gainTimeDiff == totalTimeDiff) {
//                [equalArr addObject:[NSNumber numberWithInteger:i]];
//            }else{
//                [unEqualArr addObject:[NSNumber numberWithInteger:i]];
//            }
//            
//            
//        }
//    }
//    NSMutableArray *queadATA = [[NSMutableArray alloc] init];
//    
//    for (NSInteger i = 0; i < equalArr.count; i++) {
//        NSNumber *index = [equalArr objectAtIndex:i];
//        
//        if (index.integerValue > 0) {
//            [queadATA addObject:[jsArr objectAtIndex:index.integerValue - 1]];
//        }
//        
//        [queadATA addObject:[jsArr objectAtIndex:index.integerValue]];
//    }
}

-(void)findSubPath:(NSString *)mainPath{
    
    NSFileManager *fm = [NSFileManager defaultManager];

    if ([fm fileExistsAtPath:mainPath]) { //文件是否存在,当路径是以缩略形式时，无法打开
        
        BOOL isDir = NO;
        [fm fileExistsAtPath:mainPath isDirectory:&isDir]; //是否是一个目录
        if (isDir) {
            
            NSArray<NSString *> *subPaths = [fm subpathsOfDirectoryAtPath:mainPath error:nil];
            for (NSString *subPath in subPaths) {
                
                if ([subPath rangeOfString:@"Assets"].location != NSNotFound) {
                    NSString *assetsPath = [NSString stringWithFormat:@"%@/%@",mainPath,subPath];
                    
                    [self carFileAna:assetsPath];
                    
//                    BOOL assets = NO;
//                    [fm fileExistsAtPath:assetsPath isDirectory:&assets];
//                    assets == YES ? NSLog(@"isDir") : NSLog(@"notDir");
                }else if ([subPath rangeOfString:@"JSCallOC"].location != NSNotFound){
                    NSString *assetsPath = [NSString stringWithFormat:@"%@/%@",mainPath,subPath];
                    
                    BOOL assets = NO;
                    [fm fileExistsAtPath:assetsPath isDirectory:&assets];
                    assets == YES ? NSLog(@"isDir") : NSLog(@"notDir");
                }
                
                NSLog(@"%@",subPath);
            }
        }else{
            NSLog(@"is not a Dir");
        }
    }
}

-(void)carFileAna:(NSString *)path{
    
    
    
}

@end
