//
//  AppDelegate.m
//  BWObjectRouterDemo
//
//  Created by Bruno Wernimont on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "BWObjectRouter.h"

#import "User.h"
#import "Post.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    User *user = [[User alloc] init];
    user.userID = [NSNumber numberWithInt:1];
    
    Post *post = [[Post alloc] init];
    post.user = user;
    post.postID = [NSNumber numberWithInt:222];
    
    [[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users" forMethod:BWObjectRouterMethodINDEX];
    [[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users/:userID" forMethod:BWObjectRouterMethodAllExceptPOST];
    [[BWObjectRouter shared] routeObjectClass:[User class] toResourcePath:@"/users/" forMethod:BWObjectRouterMethodPOST];
    
    [[BWObjectRouter shared] routeObjectClass:[Post class] toResourcePath:@"/users/:userID/posts" forMethod:BWObjectRouterMethodINDEX];
    [[BWObjectRouter shared] routeObjectClass:[Post class] toResourcePath:@"/users/:user.userID/posts/:postID" forMethod:BWObjectRouterMethodAllExceptPOST];
    
    NSString *path = nil;
    
    path = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodINDEX withObjectClass:[User class]];
    // /users
    NSLog(@"path = %@", path);
    
    path = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodPUT withObject:user];
    // /users/1
    NSLog(@"path = %@", path);
    
    path = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodINDEX withObjectClass:[Post class] valueObject:user];
    // /users/1/posts
    NSLog(@"path = %@", path);
    
    path = [[BWObjectRouter shared] resourcePathForMethod:BWObjectRouterMethodGET withObject:post];
    // /users/1/posts/222
    NSLog(@"path = %@", path);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
