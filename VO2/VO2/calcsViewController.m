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
}

-(void)viewDidAppear:(BOOL)animated{
    // set up link to singleton
    mySingleton *singleton      = [mySingleton sharedSingleton];
    
    float N2  = 0;
    float HyN2= 0;
    float O2  = 0;
    
    N2   = 100 - ([singleton.feo2 floatValue] + [singleton.feco2 floatValue]) ;
    HyN2 = N2 + (20.93 - [singleton.labO2 floatValue]);
    O2   = 100 - HyN2;

    line1.text=[NSString stringWithFormat:@"N2E = 100 - %@ - %@ %%",singleton.feo2,singleton.feco2];
    line2.text=[NSString stringWithFormat:@"Therfore:- N2E = %.2f %%", N2];
    line3.text=[NSString stringWithFormat:@"For Lab O2i = %@ %%", singleton.labO2];
    line4.text=[NSString stringWithFormat:@"N2E = %.2f : O2 = %.2f", HyN2,O2];
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
