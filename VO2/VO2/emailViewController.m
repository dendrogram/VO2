//
//  emailViewController.m
//  VO2
//
//  Created by Jon Howell on 24/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "emailViewController.h"
#import "mySingleton.h" //for global variables

@interface emailViewController (
)

@end

@implementation emailViewController

@synthesize resultsView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    resultsView.text = @"New Results";
}

-(void)viewDidAppear:(BOOL)animated{
    mySingleton *singleton = [mySingleton sharedSingleton];
    resultsView.text = singleton.resultStrings;
    //NSLog(@"%@",singleton.resultStrings);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
