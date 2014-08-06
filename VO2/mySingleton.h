//
//  mySingleton.h
//  VO2
//
//  Created by Jon Howell on 15/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mySingleton : NSObject {
    // add all the objects that you want to be globally abailable here:
    //eg types defs

    //float   test;
    //BOOL    boxShow;
    //UIColor *lineColour;
    //CGRect  picturePos;
    //UIImage        * imageForDisplay;

    int counter;

    NSMutableArray * cardReactionTimeResult;
    NSString       * resultsStrings;
    
    BOOL     addedToResults;
    BOOL     dataCompleted;
    
    //subject and results
    NSString * testerName;
    NSString * testDate;
    NSString * testTime;
    NSString * resultStrings;
    NSString * subjectName;
    NSString * oldSubjectName;
    NSString * versionNumber;
    NSString * email;
    NSString * subWt;
    NSString * subHt;
    NSString * labTemp;
    NSString * labPressure_mmHg;
    NSString * labHumidity;
    NSString * labLocation;
    NSString * sampTime;
    NSString * veatps;
    NSString * svestpd;
    NSString * feco2;
    NSString * feo2;
    NSString * corrFactor;
    NSString * vo2;
    NSString * vco2;
    NSString * vo2kg;
    NSString * labO2; // percent O2 in air, obviously low if hypoxic, 20.93 approx normal stp
    NSString * labCO2;
    NSString * rer;
    
    //energy outputs
    NSString * BMI;
    NSString * energyExpenKJ;
    NSString * energyExpenKCal;
    NSString * CHOUsage_g_min;
    NSString * CHOUsage_kj_min;
    NSString * CHOUsage_kCal_min;
    NSString * fatUsage_g_min;
    NSString * fatUsage_kj_min;
    NSString * fatUsage_kCal_min;
    NSString * percentFat;
    NSString * percentCHO;
}

//eg defs pt2
@property (nonatomic) int  counter;
//@property (nonatomic) BOOL boxShow;
//@property (nonatomic,retain) UIColor *lineColour;
//@property (nonatomic) CGRect picturePos;
//@property (nonatomic) UIImage *imageForDisplay;
@property (nonatomic, retain) NSMutableArray * cardReactionTimeResult;
//@property (nonatomic, retain) NSString *resultStrings;

//Integers

//floats

//Strings
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * subWt;
@property (nonatomic, retain) NSString * subHt;
@property (nonatomic, retain) NSString * labTemp;
@property (nonatomic, retain) NSString * labPressure_mmHg;
@property (nonatomic, retain) NSString * labHumidity;
@property (nonatomic, retain) NSString * labLocation;
@property (nonatomic, retain) NSString * sampTime;
@property (nonatomic, retain) NSString * veatps;
@property (nonatomic, retain) NSString * vestpd;
@property (nonatomic, retain) NSString * feco2;
@property (nonatomic, retain) NSString * feo2;
@property (nonatomic, retain) NSString * corrFactor;
@property (nonatomic, retain) NSString * vo2;
@property (nonatomic, retain) NSString * vco2;
@property (nonatomic, retain) NSString * vo2kg;
@property (nonatomic, retain) NSString * labO2;
@property (nonatomic, retain) NSString * labCO2;
@property (nonatomic, retain) NSString * rer;
@property (nonatomic, retain) NSString * resultStrings;
@property (nonatomic, retain) NSString * subjectName;
@property (nonatomic, retain) NSString * oldSubjectName;
@property (nonatomic, retain) NSString * testerName;
@property (nonatomic, retain) NSString * testDate;
@property (nonatomic, retain) NSString * testTime;
@property (nonatomic, retain) NSString * versionNumber;

//energy
@property (nonatomic, retain)NSString * BMI;
@property (nonatomic, retain)NSString * energyExpenKJ;
@property (nonatomic, retain)NSString * energyExpenKCal;
@property (nonatomic, retain)NSString * CHOUsage_g_min;
@property (nonatomic, retain)NSString * CHOUsage_kj_min;
@property (nonatomic, retain)NSString * CHOUsage_kCal_min;
@property (nonatomic, retain)NSString * fatUsage_g_min;
@property (nonatomic, retain)NSString * fatUsage_kj_min;
@property (nonatomic, retain)NSString * fatUsage_kCal_min;
@property (nonatomic, retain)NSString * percentFat;
@property (nonatomic, retain)NSString * percentCHO;

//Flags BOOL
@property (nonatomic) BOOL addedToResults;
@property (nonatomic) BOOL dataCompleted;

//Images and Colours

//set up singleton shared

+(mySingleton *)sharedSingleton;

@end

