//
//  PDAppDelegate.m
//  PerfectDiet
//
//  Created by Liu Zenan on 15/10/13.
//  Copyright (c) 2013 NUS. All rights reserved.
//

#import "PDAppDelegate.h"
#import "PDSplashViewController.h"
#import <Parse/Parse.h>
#import <ProgressHUD/ProgressHUD.h>
#import "PDPFActivity.h"
#import "PDUser.h"
#import "PDActivityType.h"

@implementation PDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [PDUser registerSubclass];
    [PDActivityType registerSubclass];
    [PDPFActivity registerSubclass];
    [Parse setApplicationId:@"oJctCPN8uHayUuR48fTJXe1F9Qtp9k8Pa9gLHaKb"
                  clientKey:@"CsMXy8RdGLhjMzroaIo8pfokE8OGZHJhBRbfJVAe"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebook];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
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

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];

    // Do any additional setup after loading the view.
    if (!([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])) // Check if user is linked to Facebook
    {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
        UINavigationController *sv = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"SplashView"];
        [self.window.rootViewController presentViewController:sv animated:NO completion:nil];
        
    }
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
