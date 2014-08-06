//
//  EnergyViewController.m
//  VO2
//
//  Created by Jon Howell on 06/08/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "EnergyViewController.h"
#import "mySingleton.h"

@interface EnergyViewController ()

@end

@implementation EnergyViewController

@synthesize date,
    time,
    subject,
    height,
    mass,
    bmi,
    expkj,
    expcal,
    chog,
    chokj,
    chocal,
    fatg,
    fatkj,
    fatcal,
    perfat,
    percho
;

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
}


-(void)viewDidAppear:(BOOL)animated{
    //populate the cells from the mySingleton
    // set up link to singleton
    mySingleton *singleton      = [mySingleton sharedSingleton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
