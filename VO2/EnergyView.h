//
//  EnergyView.h
//  VO2
//
//  Created by Jon Howell on 03/12/2015.
//  Copyright © 2015 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  updated 1/10/16 jah for ios 10.0.2
//
//

#import <UIKit/UIKit.h>

@interface EnergyView : UIViewController
{
    UILabel  * RERlbl;
    UILabel  * VO2lbl;
    UILabel  * VCO2lbl;
    UILabel  * datelbl;
    UILabel  * timelbl;
    UILabel  * lablbl;
    UILabel  * testerlbl;
    UILabel  * subjectlbl;
    UILabel  * VO2Kglbl;
    UILabel  * subHtlbl;
    UILabel  * subWtlbl;
    UILabel  * subBMIlbl;
    UILabel  * corrFaclbl;
    UILabel  * energyExpendlbl;
    UILabel  * chousegmlbl;
    UILabel  * chousekjmlbl;
    UILabel  * fatusegmlbl;
    UILabel  * fatusekjmlbl;
    UILabel  * pfatlbl;
    UILabel  * pcholbl;
    
    UISegmentedControl * vo2level;
    UISegmentedControl * fatlevel;
    
    Float64 choug;
    Float64 choukj;
    Float64 fatug;
    Float64 fatukj;
    Float64 pfat;
    Float64 pcho;
    Float64 energyExpend;
    
    Float64 subWt;
    Float64 subHt;
    Float64 subBMI;
    Float64 VO2;
    Float64 VCO2;
    Float64 RER;
    Float64 corrFactor;
    Float64 VO2Kg;
    
    int dpd;
    NSString * dpds;
}

//dates
@property (nonatomic, copy) NSDate * startDate;
@property (nonatomic, copy) NSDate * testDate;

//var label outlets

@property (nonatomic, strong) IBOutlet UILabel * RERlbl;
@property (nonatomic, strong) IBOutlet UILabel * VO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * VCO2lbl;

@property (nonatomic, strong) IBOutlet UILabel * datelbl;
@property (nonatomic, strong) IBOutlet UILabel * timelbl;
@property (nonatomic, strong) IBOutlet UILabel * lablbl;
@property (nonatomic, strong) IBOutlet UILabel * testerlbl;
@property (nonatomic, strong) IBOutlet UILabel * subjectlbl;

@property (nonatomic, strong) IBOutlet UILabel * VO2Kglbl;
@property (nonatomic, strong) IBOutlet UILabel * subHtlbl;
@property (nonatomic, strong) IBOutlet UILabel * subWtlbl;
@property (nonatomic, strong) IBOutlet UILabel * subBMIlbl;
@property (nonatomic, strong) IBOutlet UILabel * corrFaclbl;

@property (nonatomic, strong) IBOutlet UILabel * energyExpendlbl;
@property (nonatomic, strong) IBOutlet UILabel * chousegmlbl;
@property (nonatomic, strong) IBOutlet UILabel * chousekjmlbl;
@property (nonatomic, strong) IBOutlet UILabel * fatusegmlbl;
@property (nonatomic, strong) IBOutlet UILabel * fatusekjmlbl;
@property (nonatomic, strong) IBOutlet UILabel * pfatlbl;
@property (nonatomic, strong) IBOutlet UILabel * pcholbl;

@property (nonatomic, strong) IBOutlet UISegmentedControl * vo2level;
@property (nonatomic, strong) IBOutlet UISegmentedControl * fatlevel;
// button press to send the mail

- (void)    calculateStats;
- (IBAction)indexChangedCHO:(UISegmentedControl *)sender;
- (IBAction)indexChangedFAT:(UISegmentedControl *)sender;
- (void) decimapPlaces;
@end
