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
    NSString * rer;

    NSString * testerName;
    NSString * testDate;
    NSString * testTime;
    NSString * resultStrings;
    NSString * subjectName;
    NSString * oldSubjectName;
    NSString * versionNumber;
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
@property (nonatomic, retain) NSString * rer;
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

