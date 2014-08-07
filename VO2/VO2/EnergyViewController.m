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
    [self refreshFields];
}

-(void)viewDidAppear:(BOOL)animated{
    [self refreshFields];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshFields{
    // populate the cells from the mySingleton
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    date.text       = singleton.testDate;
    time.text       = singleton.testTime;
    subject.text    = singleton.oldSubjectName;
    height.text     = [NSString stringWithFormat:@"%.2f", singleton.subHt];
    mass.text       = [NSString stringWithFormat:@"%.2f", singleton.subWt];
    bmi.text        = [NSString stringWithFormat:@"%.3f", singleton.BMI];
    expkj.text      = [NSString stringWithFormat:@"%.3f", singleton.energyExpenKJ];
    expcal.text     = [NSString stringWithFormat:@"%.3f", singleton.energyExpenKCal];
    chog.text       = [NSString stringWithFormat:@"%.3f", singleton.CHOUsage_g_min];
    chokj.text      = [NSString stringWithFormat:@"%.3f", singleton.CHOUsage_kj_min];
    chocal.text     = [NSString stringWithFormat:@"%.3f", singleton.CHOUsage_kCal_min];
    fatg.text       = [NSString stringWithFormat:@"%.3f", singleton.fatUsage_g_min];
    fatkj.text      = [NSString stringWithFormat:@"%.3f", singleton.fatUsage_kj_min];
    fatcal.text     = [NSString stringWithFormat:@"%.3f", singleton.fatUsage_kCal_min];
    perfat.text     = [NSString stringWithFormat:@"%.3f", singleton.percentFat];
    percho.text     = [NSString stringWithFormat:@"%.3f", singleton.percentCHO];
}
@end
