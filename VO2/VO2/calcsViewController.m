//
//  calcsViewController.m
//  VO2
//
//  Created by Jon Howell on 23/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "calcsViewController.h"
#import "mySingleton.h"

@interface calcsViewController ()

@end

@implementation calcsViewController{
    
}
@synthesize
            line1,
            line2,
            line3,
            line4,
            line5;

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
    setTranslatesAutoresizingMaskIntoConstraints:NO;
}

-(void)viewDidAppear:(BOOL)animated{
    // set up link to singleton
    mySingleton *singleton      = [mySingleton sharedSingleton];
    
    double N2  = 0;
    double HyN2= 0;
    double O2  = 0;
    
    N2   = 100 - (singleton.feo2 + singleton.feco2) ;
    HyN2 = N2 + (20.93 - singleton.labO2);
    O2   = 100 - HyN2;

    line1.text=[NSString stringWithFormat:@"N2E = 100 - %.2f - %.2f %%",singleton.feo2, singleton.feco2];
    line2.text=[NSString stringWithFormat:@"Therfore:- N2E = %.2f %%", N2];
    line3.text=[NSString stringWithFormat:@"For Lab O2i = %.2f %%", singleton.labO2];
    line4.text=[NSString stringWithFormat:@"N2E = %.2f : O2 = %.2f", HyN2,O2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
