//
//  ViewController.m
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//
//  Updated and improved 24/11/15, 6/12/15
//  updated 1/10/16 jah for ios 10.0.2
//

#import "ViewController.h"
#import "mySingleton.h" //for global variables

#define kEmail         @"emailAddress"
#define kTester        @"testerName"
#define kVersion0      @"version0"
#define kVersion1      @"version1"
#define kVersion2      @"version2"
#define kVersion3      @"version3"
#define kEnergyButton  @"eresults"
#define kAnim          @"kanim"


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
//
}
@end

@implementation ViewController

#pragma mark Inits

//@synthesize webview, versionNumberLab, tabBar, essweblink, mmuweblink ;
@synthesize versionNumberLab, essweblink, mmuweblink ;

// ************************************************
// ************************************************

// ************************************************
// licemnse text is in the Acknowledgements.license file in the settings bundle directory.  Change the text accordingly before build.  The Build phases has a run script section.  The Python script reads the .license file, formats it and writes a new Acknowledgement.plist file.  This is a better approach to printing larger text blocks in the settings App
// ************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    //for plist version group
    NSString * version0; //version number
    NSString * version1; //copyright info
    NSString * version2; //author info
    NSString * version3; //web site info
    NSString * tester; //web site info
    NSString * email; //web site info

    // for web page link
    //NSURL *url = [NSURL URLWithString:@"http://www.ess.mmu.ac.uk/"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[webview loadRequest:request];
    //read the user defaults from the iPhone/iPad bundle
    // if any are set to nil (no value on first run), put a temporary one in
    
    NSString        * pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString        * settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString        * defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary    * defaultPrefs          = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults  * defaults              = [NSUserDefaults standardUserDefaults];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //*************************************************************
    //version, set anyway *****************************************
    //*************************************************************
    
    version0 =  @"Version 2.3.9 - 7.2.17";     // version   *** keep short
    version1 =  @"MMU (C) 2017";                // copyright *** limited line space
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
    //set up the plist params

    
    //bool test2;
    //test2 = [defaults boolForKey:kEnergyButton];
    
    [defaults synchronize];
//if any settings not already set, as in new installation, put the defaults in.
    
    [self registerDefaultsFromSettingsBundle];
    
    //tester name
    tester     = [defaults objectForKey:kTester];
    if([tester isEqualToString: @ "" ]){
        tester =  @"Me";
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.testerName] forKey:kTester];
    }
    //email name
    email     = [defaults objectForKey:kEmail];
    if([email isEqualToString: @ "" ]){
        email =  @"@mmu.ac.uk";
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.email] forKey:kEmail];
    }
    singleton.testerName = tester;
    singleton.email      = email;
    
    [defaults synchronize];//make sure all are updated
    
    versionNumberLab.text   = version0;
    singleton.versionNumber = version0;
}

- (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}

- (IBAction)esswebjump:(id)sender{
    //jump to mmu page
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ess.mmu.ac.uk"]];
}

- (IBAction)mmuwebjump:(id)sender{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mmu.ac.uk"]];
}
@end
