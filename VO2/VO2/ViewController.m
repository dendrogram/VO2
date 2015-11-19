//
//  ViewController.m
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "ViewController.h"
#import "mySingleton.h" //for global variables

// use the following line in any method that needs the singleton
// mySingleton *singleton = [mySingleton sharedSingleton];
// then call like this example
// singleton.btnNotPressed = YES; //YES;

// todo list
//
//--------------------------

@interface ViewController ()
{

}
@end

@implementation ViewController

#pragma mark Inits

@synthesize webview;

// ************************************************
// ************************************************

int v1=2;   // version: v1.v2.v3. v2=18/11/15
int v2=1;   // 24/7/14 jah, v2.1=19/11/15
int v3=0;   //

// ************************************************
// ************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    //display the version number in the opening vc
        NSString *versionNo = [NSString stringWithFormat:@"V.%i.%i.%i",v1,v2,v3];
    
    versionNumberLab.text=versionNo;
    // for web page link
    NSURL *url = [NSURL URLWithString:@"http://www.ess.mmu.ac.uk/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
}

@end
