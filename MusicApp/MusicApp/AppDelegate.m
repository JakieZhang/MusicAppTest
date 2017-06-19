//
//  AppDelegate.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/16.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "AppDelegate.h"
#import "DynamicTableViewController.h"
#import "MusicPageController.h"
#import "MineViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    WMPageController *pageController = [[WMPageController alloc]initWithViewControllerClasses:@[[MineViewController class],[MusicPageController class],[DynamicTableViewController class]] andTheirTitles:@[@"我的",@"音乐",@"动态"]];
    pageController.menuHeight = 44;
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 15;
    pageController.showOnNavigationBar = YES;
    pageController.menuBGColor = [UIColor clearColor];
    pageController.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:pageController];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
