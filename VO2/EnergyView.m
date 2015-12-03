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
startDate;

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
    
    subBMIlbl.text      =  [NSString stringWithFormat:@"%.1f", subBMI];

    corrFaclbl.text     =   singleton.corrFactor;
    VO2lbl.text         =   singleton.vo2;
    VCO2lbl.text        =   singleton.vco2;
 
    VO2Kglbl.text       =   singleton.vo2kg;
    RERlbl.text         =   singleton.rer;
}

@end
