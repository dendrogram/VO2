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
    //NSString * subWt;
    //NSString * subHt;
    //NSString * labTemp;
    //NSString * labPressure_mmHg;
    //NSString * labHumidity;
    NSString * labLocation;
    //NSString * sampTime;
    //NSString * veatps;
    //NSString * vebtps;
    //NSString * vestpd;
    //NSString * feco2;
    //NSString * feo2;
    //NSString * corrFactor;
    //NSString * vo2;
    //NSString * vco2;
    //NSString * vo2kg;
    //NSString * labO2; // percent O2 in air, obviously low if hypoxic, 20.93 approx normal stp
    //NSString * labCO2;
    //NSString * rer;
    
    //energy outputs
    //NSString * BMI;
    //NSString * energyExpenKJ;
    //NSString * energyExpenKCal;
    //NSString * CHOUsage_g_min;
    //NSString * CHOUsage_kj_min;
    //NSString * CHOUsage_kCal_min;
    //NSString * fatUsage_g_min;
    //NSString * fatUsage_kj_min;
    //NSString * fatUsage_kCal_min;
    //NSString * percentFat;
    //NSString * percentCHO;
    
    long double subWt;
    long double subHt;
    long double labTemp;
    long double labPressure_mmHg;
    long double labHumidity;
    long double sampTime;
    long double veatps;
    long double vebtps;
    long double vestpd;
    long double VISTPD;
    long double feco2;
    long double feo2;
    long double corrFactor;
    long double vo2;
    long double vco2;
    long double vo2kg;
    long double labO2; // percent
    long double labCO2;
    long double rer;
    long double BMI;
    long double energyExpenKJ;
    long double energyExpenKCal;
    long double CHOUsage_g_min;
    long double CHOUsage_kj_min;
    long double CHOUsage_kCal_min;
    long double fatUsage_g_min;
    long double fatUsage_kj_min;
    long double fatUsage_kCal_min;
    long double percentFat;
    long double percentCHO;
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

//doubles
@property (nonatomic) long double subWt;
@property (nonatomic) long double subHt;
@property (nonatomic) long double labTemp;
@property (nonatomic) long double labPressure_mmHg;
@property (nonatomic) long double labHumidity;
@property (nonatomic) long double sampTime;
@property (nonatomic) long double veatps;
@property (nonatomic) long double vebtps;
@property (nonatomic) long double vestpd;
@property (nonatomic) long double VISTPD;
@property (nonatomic) long double feco2;
@property (nonatomic) long double feo2;
@property (nonatomic) long double corrFactor;
@property (nonatomic) long double vo2;
@property (nonatomic) long double vco2;
@property (nonatomic) long double vo2kg;
@property (nonatomic) long double labO2;
@property (nonatomic) long double labCO2;
@property (nonatomic) long double rer;
@property (nonatomic) long double BMI;
@property (nonatomic) long double energyExpenKJ;
@property (nonatomic) long double energyExpenKCal;
@property (nonatomic) long double CHOUsage_g_min;
@property (nonatomic) long double CHOUsage_kj_min;
@property (nonatomic) long double CHOUsage_kCal_min;
@property (nonatomic) long double fatUsage_g_min;
@property (nonatomic) long double fatUsage_kj_min;
@property (nonatomic) long double fatUsage_kCal_min;
@property (nonatomic) long double percentFat;
@property (nonatomic) long double percentCHO;

//Strings
@property (nonatomic, retain) NSString * email;
//@property (nonatomic, retain) NSString * subWt;
//@property (nonatomic, retain) NSString * subHt;
//@property (nonatomic, retain) NSString * labTemp;
//@property (nonatomic, retain) NSString * labPressure_mmHg;
//@property (nonatomic, retain) NSString * labHumidity;
@property (nonatomic, retain) NSString * labLocation;
//@property (nonatomic, retain) NSString * sampTime;
//@property (nonatomic, retain) NSString * veatps;
//@property (nonatomic, retain) NSString * vebtps;
//@property (nonatomic, retain) NSString * vestpd;
//@property (nonatomic, retain) NSString * feco2;
//@property (nonatomic, retain) NSString * feo2;
//@property (nonatomic, retain) NSString * corrFactor;
//@property (nonatomic, retain) NSString * vo2;
//@property (nonatomic, retain) NSString * vco2;
//@property (nonatomic, retain) NSString * vo2kg;
//@property (nonatomic, retain) NSString * labO2;
//@property (nonatomic, retain) NSString * labCO2;
//@property (nonatomic, retain) NSString * rer;
@property (nonatomic, retain) NSString * resultStrings;
@property (nonatomic, retain) NSString * subjectName;
@property (nonatomic, retain) NSString * oldSubjectName;
@property (nonatomic, retain) NSString * testerName;
@property (nonatomic, retain) NSString * testDate;
@property (nonatomic, retain) NSString * testTime;
@property (nonatomic, retain) NSString * versionNumber;

//Flags BOOL
@property (nonatomic) BOOL addedToResults;
@property (nonatomic) BOOL dataCompleted;

//Images and Colours

//set up singleton shared

+(mySingleton *)sharedSingleton;

@end

