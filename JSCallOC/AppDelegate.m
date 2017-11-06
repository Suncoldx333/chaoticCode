//
//  AppDelegate.m
//  JSCallOC
//
//  Created by wangdan on 15/11/17.
//  Copyright © 2015年 wangdan. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "MayIHelpYou-Swift.h"
#import <Bugly/Bugly.h>
#import <KMCGeigerCounter/KMCGeigerCounter.h>
#import <WeexSDK/WeexSDK.h>

#import "WeexVC.h"
#import "WeexEventModule.h"
#import "WeexImageLoader.h"
#import "WeexComponent.h"

@interface AppDelegate ()

@property (nonatomic,readwrite,strong) NSManagedObjectModel *manageObjectModel;
@property (nonatomic,readwrite,strong) NSPersistentStoreCoordinator *persistent;
@property (nonatomic,readwrite,strong) NSManagedObjectContext *context;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Bugly startWithAppId:@"6f75bca7da"];
    [self configureWeex];
    ViewController *controller = [[ViewController alloc] init];
    CustomNavController *nav = [[CustomNavController alloc] initWithRootViewController:controller];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    
    return YES;
}


#pragma mark -AboutCoreData
-(void)configureWeex{
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    [WXSDKEngine initSDKEnvironment];
    [WXSDKEngine registerModule:@"eventmodule" withClass:[WeexEventModule class]];
    [WXSDKEngine registerHandler:[WeexImageLoader new] withProtocol:@protocol(WXImgLoaderProtocol)];
    [WXSDKEngine registerComponent:@"eventc" withClass:[WeexComponent class]];
    [WXLog setLogLevel:WXLogLevelDebug];
}

-(NSManagedObjectModel *)manageObjectModel{
    if (!_manageObjectModel) {
        NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        _manageObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    }
    return _manageObjectModel;
}

-(NSPersistentStoreCoordinator *)persistent{
    if (!_persistent) {
        _persistent = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.manageObjectModel];
        NSURL *sqliteUrl = [[self documentDcrectoryUrl] URLByAppendingPathComponent:@"Model.sqlite"];
        NSError *error;
        [_persistent addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:sqliteUrl
                                        options:nil
                                          error:&error];

    }
    return _persistent;
}

-(nullable NSURL *)documentDcrectoryUrl{
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

-(NSManagedObjectContext *)context{
    if (!_context) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = self.persistent;
    }
    return _context;
}

@end
