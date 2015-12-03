//
//  EnergyView.h
//  VO2
//
//  Created by Jon Howell on 03/12/2015.
//  Copyright © 2015 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
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
    Float64 subWt;
    Float64 subHt;
    Float64 subBMI;
    Float64 VO2;
    Float64 VCO2;
    Float64 RER;
    Float64 corrFactor;
    Float64 VO2Kg;
    
    int counter;
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

// button press to send the mail

- (void) calculateStats;

@end
