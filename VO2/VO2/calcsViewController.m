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
            FECO2lbl,
            FEO2lbl,
            labO2lbl,
            hypoxic02,
            n2lbl;

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
    
    float N2=0;
    float HyN2=0;
    
    FEO2lbl.text                =   singleton.feo2              ;
    FECO2lbl.text               =   singleton.feco2             ;
    labO2lbl.text               =   singleton.labO2             ;
    
    N2 = 100 - ([FEO2lbl.text floatValue] + [FECO2lbl.text floatValue]) ;
    HyN2 = N2 + (20.93 - [labO2lbl.text floatValue]);
            
    n2lbl.text=[NSString stringWithFormat:@"%.2F", N2];
    hypoxic02.text=[NSString stringWithFormat:@"%.2F", HyN2];
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
