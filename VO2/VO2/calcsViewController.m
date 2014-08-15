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
    
    long double N2  = 0.0000f;
    long double HyN2= 0.0000f;
    long double O2  = 0.0000f;
    
    N2   = 100.0000f - (singleton.feo2 + singleton.feco2) ;
    HyN2 = N2 + (20.930000f - singleton.labO2);
    O2   = 100.0000f - HyN2;

    line1.text=[NSString stringWithFormat:@"N2E = 100 - %.2Lf - %.2Lf %%",singleton.feo2, singleton.feco2];
    line2.text=[NSString stringWithFormat:@"Therefore:- N2E = %.2Lf %%", N2];
    line3.text=[NSString stringWithFormat:@"For Lab O2i = %.2Lf %%", singleton.labO2];
    line4.text=[NSString stringWithFormat:@"N2E = %.2Lf : O2 = %.2Lf", HyN2,O2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
