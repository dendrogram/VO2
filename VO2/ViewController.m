//
//  ViewController.m
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//
//  Updated and improved 24/11/15

#import "ViewController.h"
#import "mySingleton.h" //for global variables

#define kEmail      @"emailAddress"
#define kTester     @"testerName"
#define kVersion0   @"version0"
#define kVersion1   @"version1"
#define kVersion2   @"version2"
#define kVersion3   @"version3"

// use the following line in any method that needs the singleton
// mySingleton *singleton = [mySingleton sharedSingleton];
// then call like this example
// singleton.btnNotPressed = YES; //YES;

// todo list
//
//--------------------------
//

@interface ViewController ()
{

}
@end

@implementation ViewController

#pragma mark Inits

@synthesize webview, tabBar;

// ************************************************
// ************************************************

int v1=2;   // version: v1.v2.v3. v2=18/11/15
int v2=2;   // 24/7/14 jah, v2.1=19/11/15, v2.2=25/11/15
int v3=0;   //

// ************************************************
// ************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    //display the version number in the opening vc
        NSString *versionNo = [NSString stringWithFormat:@"V.%i.%i.%i",v1,v2,v3];
    //for plist version group
    NSString * version0; //version number
    NSString * version1; //copyright info
    NSString * version2; //author info
    NSString * version3; //web site info
    NSString * tester; //web site info
    NSString * email; //web site info
    
    versionNumberLab.text=versionNo;
    // for web page link
    //NSURL *url = [NSURL URLWithString:@"http://www.ess.mmu.ac.uk/"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[webview loadRequest:request];
    //read the user defaults from the iPhone/iPad bundle
    // if any are set to nil (no value on first run), put a temporary one in
    
    NSString *pathStr = [[NSBundle mainBundle] bundlePath];
    NSString *settingsBundlePath = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *defaultPrefsFile   = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *defaultPrefs   = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults     = [NSUserDefaults standardUserDefaults];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //*************************************************************
    //version, set anyway *****************************************
    //*************************************************************
    version0 =  @"v2.2.0.25.11.15";             // version   *** keep short
    version1 =  @"MMU (c) 2015";                // copyright *** limited line space
    version2 =  @"j.a.howell@mmu.ac.uk";        // author    *** to display on device
    version3 =  @"http://www.ess.mmu.ac.uk";    // web site  *** settings screen
    //*************************************************************
    [defaults setObject:version0 forKey:kVersion0];   //***
    [defaults setObject:version1 forKey:kVersion1];   //***
    [defaults setObject:version2 forKey:kVersion2];   //***
    [defaults setObject:version3 forKey:kVersion3];   //***
    //*************************************************************
    //version set end *********************************************
    //*************************************************************

    //for plist
    //tester name
    tester     = [defaults objectForKey:kTester];
    if([tester isEqualToString: @ "" ]){
        tester =  @"Me";
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.testerName] forKey:kTester];
    }
    //email name
    email     = [defaults objectForKey:kEmail];
    if([email isEqualToString: @ "" ]){
        email =  @"me@mymailaddress.com";
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.email] forKey:kEmail];
    }
    singleton.testerName = tester;
    singleton.email      = email;
    
    [defaults synchronize];//make sure all are updated
}

@end
