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
    // populate the cells from the mySingleton
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];

    date.text       = singleton.testDate;
    time.text       = singleton.testTime;
    subject.text    = singleton.oldSubjectName;
    height.text     = singleton.subHt;
    mass.text       = singleton.subWt;
    bmi.text        = singleton.BMI;
    expkj.text      = singleton.energyExpenKJ;
    expcal.text     = singleton.energyExpenKCal;
    chog.text       = singleton.CHOUsage_g_min;
    chokj.text      = singleton.CHOUsage_kj_min;
    chocal.text     = singleton.CHOUsage_kCal_min;
    fatg.text       = singleton.fatUsage_g_min;
    fatkj.text      = singleton.fatUsage_kj_min;
    fatcal.text     = singleton.fatUsage_kCal_min;
    perfat.text     = singleton.percentFat;
    percho.text     = singleton.percentCHO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
