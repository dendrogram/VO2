//
//  EnergyView.m
//  VO2
//
//  Created by Jon Howell on 03/12/2015.
//  Copyright © 2015 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  updated 1/10/16 jah for ios 10.0.2
//
//

#import "EnergyView.h"
#import "mySingleton.h" //for global variables
#define kDecimalPlaces @"decimalPlaces"

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
//segmented controls
vo2level,
fatlevel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set up the plist params
    NSString *pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString *settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dpd  = [[defaults objectForKey: kDecimalPlaces]doubleValue];
    
    //UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    UIFont *font = [UIFont boldSystemFontOfSize:8.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [vo2level setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [fatlevel setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)viewDidAppear:(BOOL)animated{
    //set up the plist params
    NSString *pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString *settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dpd  = [[defaults objectForKey: kDecimalPlaces]doubleValue];
    
    [self decimapPlaces];
    [self calculateStats];
}

-(void)viewDidDisappear:(BOOL)animated{

}

-(void)decimapPlaces{
    switch (dpd) {
        case 1:
            dpds=@"%.1f";
            break;
        case 2:
            dpds=@"%.2f";
            break;
        case 3:
            dpds=@"%.3f";
            break;
        case 4:
            dpds=@"%.4f";
            break;
        case 5:
            dpds=@"%.5f";
            break;
        case 6:
            dpds=@"%.6f";
            break;
        default:
            dpds=@"%.4f";
            break;
    }
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

    corrFaclbl.text     =   [NSString stringWithFormat:dpds,[singleton.corrFactor floatValue]];
    VO2lbl.text         =   [NSString stringWithFormat:dpds,[singleton.vo2 floatValue]];
    VCO2lbl.text        =   [NSString stringWithFormat:dpds,[singleton.vco2 floatValue]];
 
    VO2Kglbl.text       =   [NSString stringWithFormat:dpds,[singleton.vo2kg floatValue]];
    RERlbl.text         =   [NSString stringWithFormat:dpds,[singleton.rer floatValue]];
    
    energyExpend = ([singleton.vo2 floatValue]*15.88)+([singleton.vco2 floatValue] * 4.87);
    energyExpendlbl.text =  [NSString stringWithFormat:dpds, energyExpend];
    singleton.energyExpend=energyExpendlbl.text;
    
    //choug
    //NSLog(@"dpd=%i",dpd);
    //NSLog(@"DPDS=%@",dpds);
    
    choug = ([singleton.vco2 floatValue] * singleton.cho412) - ([singleton.vo2 floatValue] * singleton.cho291);
    chousegmlbl.text = [NSString stringWithFormat:dpds, choug];
    singleton.chug=chousegmlbl.text;
    
    choukj = (choug * 17.22);
    chousekjmlbl.text = [NSString stringWithFormat:dpds, choukj];
    singleton.chukj=chousekjmlbl.text;
    
    //fatg
    fatug = ([singleton.vo2 floatValue] * singleton.fata)-([singleton.vco2 floatValue] * singleton.fatb);
    fatusegmlbl.text = [NSString stringWithFormat:dpds, fatug];
    singleton.fatg=fatusegmlbl.text;
    
    fatukj = (fatug * 39.06);
    fatusekjmlbl.text = [NSString stringWithFormat:dpds, fatukj];
    singleton.fatkj=fatusekjmlbl.text;
    
    //% fat %cho
    pfat = fatukj / (energyExpend / 100.0);
    pfatlbl.text = [NSString stringWithFormat:dpds, pfat];
    singleton.pfat=pfatlbl.text;
    
    pcho = choukj / (energyExpend / 100.0);
    pcholbl.text = [NSString stringWithFormat:dpds, pcho];
    singleton.pcho=pcholbl.text;
    
    if ([VCO2lbl.text  floatValue] <= 0.0||[VCO2lbl.text isEqual:@""]||[VCO2lbl.text isEqual:NULL]||isnan([VCO2lbl.text floatValue])) {
        //red if negative
        VCO2lbl.backgroundColor = [UIColor redColor];
    }
    if ([VO2lbl.text  floatValue] <= 0.0||[VO2lbl.text isEqual:@""]||[VO2lbl.text isEqual:NULL]||isnan([VO2lbl.text floatValue])) {
        //red if negative
        VO2lbl.backgroundColor = [UIColor redColor];
    }
    if ([VO2Kglbl.text  floatValue] <= 0.0||[VO2Kglbl.text isEqual:@""]||[VO2Kglbl.text isEqual:NULL]||isnan([VO2Kglbl.text floatValue])) {
        //red if negative
        VO2Kglbl.backgroundColor = [UIColor redColor];
    }
    if ([RERlbl.text  floatValue] <= 0.0||[RERlbl.text isEqual:@""]||[RERlbl.text isEqual:NULL]||isnan([RERlbl.text floatValue])) {
        //red if negative
        RERlbl.backgroundColor = [UIColor redColor];
    }
    if ([subBMIlbl.text  floatValue] < 12.0) {
        //red if too low
        subBMIlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subBMIlbl.text  floatValue] > 50.0) {
        //red if too high
        subBMIlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subWtlbl.text  floatValue] <30) {
        //orange low
        subWtlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subWtlbl.text  floatValue] >130) {
        //orange high
        subWtlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subHtlbl.text  floatValue] <=1.0) {
        //orange low
        subHtlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subHtlbl.text  floatValue] >=1.9) {
        //orange high
        subHtlbl.backgroundColor = [UIColor orangeColor];
    }
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
        default://Egan values from GasCalc Excel
        //vo2max
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
        default:
            //Egan vo2max
            singleton.fata=1.689;
            singleton.fatb=1.689;
        break;
    }
    [self calculateStats];
}
@end
