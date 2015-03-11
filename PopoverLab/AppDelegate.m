//
//  AppDelegate.m
//  PopoverLab
//
//  Created by Rafael Gonzalves on 3/5/15.
//  Copyright (c) 2015 Rafael Gonzalves. All rights reserved.
//

#import "AppDelegate.h"
#import "LabViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LabViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)applicationWillResignActive:(UIApplication *)application {
}
-(void)applicationDidEnterBackground:(UIApplication *)application {
}
-(void)applicationWillEnterForeground:(UIApplication *)application {
}
-(void)applicationDidBecomeActive:(UIApplication *)application {
}
-(void)applicationWillTerminate:(UIApplication *)application {
}

@end
