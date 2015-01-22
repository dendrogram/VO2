//
//  AppDelegate.m
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //start the main App with a message
    
    //sleep(2);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"VO2 Oxygen Uptake and Energy Expenditure"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"Continue"
                                              otherButtonTitles:nil];
    
    UILabel *txtField = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 300)];
    
    //[txtField setFont:[UIFont fontWithName:@"Serifa-Roman" size:(16.0f)]];
    
    txtField.numberOfLines = 12;
    txtField.textColor = [UIColor darkGrayColor];
    txtField.backgroundColor = [UIColor clearColor];
    txtField.textAlignment = NSTextAlignmentCenter;
    
    txtField.text = @"To see details on how to \nuse this Application\n and adjust its settings, \nplease read the notes in \nthe 'Information' section.\n\nThis Application is NOT \nfor clinical use.";
    
    [alertView setValue:txtField forKeyPath:@"accessoryView"]; //for ios 7 and above
    
    [alertView show];
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
    setTranslatesAutoresizingMaskIntoConstraints:NO;
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
