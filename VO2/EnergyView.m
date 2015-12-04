//
//  EnergyView.m
//  VO2
//
//  Created by Jon Howell on 03/12/2015.
//  Copyright © 2015 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "EnergyView.h"
#import "mySingleton.h" //for global variables

//rgb colour setting for boxes
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface EnergyView ()
{

}
@end

@implementation EnergyView

@synthesize
//results Labels
RERlbl,
VO2lbl,
VCO2lbl,
datelbl,
timelbl,
lablbl,
testerlbl,
subjectlbl,
VO2Kglbl,
subHtlbl,
subWtlbl,
subBMIlbl,
corrFaclbl,
testDate,
startDate,
chousegmlbl,
chousekjmlbl,
fatusegmlbl,
fatusekjmlbl,
energyExpendlbl,
pcholbl,
pfatlbl,
vo2level;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [self calculateStats];
}

-(void)viewDidDisappear:(BOOL)animated{

}

-(void)calculateStats{
   
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    //read the singleton values and put into the labels
    subjectlbl.text     =   singleton.oldSubjectName;
    testerlbl.text      =   singleton.testerName;
    datelbl.text        =   singleton.testDate;
    timelbl.text        =   singleton.testTime;
    lablbl.text         =   singleton.labLocation;
    subWtlbl.text       =   singleton.subWt;
    subHtlbl.text       =   singleton.subHt;

    corrFaclbl.text     =   singleton.corrFactor;

    subWt            = [subWtlbl.text    floatValue];
    subHt            = [subHtlbl.text    floatValue];
    
    subBMI           = subWt / (subHt*subHt);
    
    subBMIlbl.text      =   [NSString stringWithFormat:@"%.1f", subBMI];

    corrFaclbl.text     =   [NSString stringWithFormat:@"%.4f",[singleton.corrFactor floatValue]];
    VO2lbl.text         =   [NSString stringWithFormat:@"%.4f",[singleton.vo2 floatValue]];
    VCO2lbl.text        =   [NSString stringWithFormat:@"%.4f",[singleton.vco2 floatValue]];
 
    VO2Kglbl.text       =   [NSString stringWithFormat:@"%.4f",[singleton.vo2kg floatValue]];
    RERlbl.text         =   [NSString stringWithFormat:@"%.4f",[singleton.rer floatValue]];
    
    energyExpend = ([singleton.vo2 floatValue]*15.88)+([singleton.vco2 floatValue] * 4.87);
    energyExpendlbl.text =  [NSString stringWithFormat:@"%.4f", energyExpend];
    
    //choug
    choug = ([singleton.vco2 floatValue] * singleton.cho412) - ([singleton.vo2 floatValue] * singleton.cho291);
    chousegmlbl.text = [NSString stringWithFormat:@"%.4f", choug];
    
    choukj = (choug * 17.22);
    chousekjmlbl.text = [NSString stringWithFormat:@"%.4f", choukj];
    
    //fatg
    fatug = ([singleton.vo2 floatValue] * singleton.fata)-([singleton.vco2 floatValue] * singleton.fatb);
    fatusegmlbl.text = [NSString stringWithFormat:@"%.4f", fatug];
    
    fatukj = (fatug * 39.06);
    fatusekjmlbl.text = [NSString stringWithFormat:@"%.4f", fatukj];
    
    //% fat %cho
    pfat = fatukj / (energyExpend / 100.0);
    pfatlbl.text = [NSString stringWithFormat:@"%.4f", pfat];
    
    pcho = choukj / (energyExpend / 100.0);
    pcholbl.text = [NSString stringWithFormat:@"%.4f", pcho];
}

-(IBAction)indexChangedCHO:(UISegmentedControl *)sender
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    switch (self.vo2level.selectedSegmentIndex)
    {
        case 0:
        //0-50% vo2 max
        singleton.cho412=4.344;
        singleton.cho291=2.370;
        break;
        case 1:
        //50-75%
        singleton.cho412=4.210;
        singleton.cho291=2.962;
        break;
        case 2:
        //75+%
        singleton.cho412=4.120;
        singleton.cho291=2.910;
        break;
        default:
        //0-50%
        singleton.cho412=4.120;
        singleton.cho291=2.910;
        break;
    }
    [self calculateStats];
}
-(IBAction)indexChangedFAT:(UISegmentedControl *)sender
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    switch (self.fatlevel.selectedSegmentIndex)
    {
        case 0:
        //Brouwer
        singleton.fata=1.718;
        singleton.fatb=1.718;
        break;
        case 1:
        //Frayn; Ferranninni
        singleton.fata=1.67;
        singleton.fatb=1.67;
        break;
        case 2:
        //Peronnet and Massicotte
        singleton.fata=1.695;
        singleton.fatb=1.701;
        break;
        case 3:
        //Egan Excel
        singleton.fata=1.689;
        singleton.fatb=1.689;
        break;
    }
    [self calculateStats];
}
@end
