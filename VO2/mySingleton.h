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
    // int counter;
    //BOOL    boxShow;
    //UIColor *lineColour;
    //CGRect  picturePos;
    //UIImage        * imageForDisplay;
    //NSMutableArray * cardReactionTimeResult;
    //NSString       * resultsStrings;
    
    BOOL     addedToResults;
    BOOL     dataCompleted;
    
    float    sing_subWt;
    float    sing_subHt;
    float    sing_labTemp;
    float    sing_labPressure_mmHg;
    float    sing_labHumidity;
    float    sing_sampTime;
    float    sing_veatps;
    float    sing_vestpd;
    float    sing_feco2;
    float    sing_feo2;
    float    sing_corrFactor;
    float    sing_vo2;
    float    sing_vco2;
    float    sing_vo2kg;
    float    sing_rer;

    NSString * sing_testerName;
    NSString * sing_testDate;
    NSString * sing_testTime;
    NSString * sing_resultStrings;
    NSString * sing_subjectName;
}
//eg defs pt2
//@property (nonatomic) int  counter;
//@property (nonatomic) BOOL boxShow;
//@property (nonatomic,retain) UIColor *lineColour;
//@property (nonatomic) CGRect picturePos;
//@property (nonatomic) UIImage *imageForDisplay;
//@property (nonatomic, retain) NSMutableArray *cardReactionTimeResult;
//@property (nonatomic, retain) NSString *resultStrings;

//Integers

//floats
@property (nonatomic) float  sing_subWt;
@property (nonatomic) float  sing_subHt;
@property (nonatomic) float  sing_labTemp;
@property (nonatomic) float  sing_labPressure_mmHg;
@property (nonatomic) float  sing_labHumidity;
@property (nonatomic) float  sing_sampTime;
@property (nonatomic) float  sing_veatps;
@property (nonatomic) float  sing_vestpd;
@property (nonatomic) float  sing_feco2;
@property (nonatomic) float  sing_feo2;
@property (nonatomic) float  sing_corrFactor;
@property (nonatomic) float  sing_vo2;
@property (nonatomic) float  sing_vco2;
@property (nonatomic) float  sing_vo2kg;
@property (nonatomic) float  sing_rer;

//Strings
@property (nonatomic, retain) NSString * sing_resultStrings;
@property (nonatomic, retain) NSString * sing_subjectName;
@property (nonatomic, retain) NSString * sing_testerName;
@property (nonatomic, retain) NSString * sing_testDate;
@property (nonatomic, retain) NSString * sing_testTime;

//Flags BOOL
@property (nonatomic) BOOL addedToResults;
@property (nonatomic) BOOL dataCompleted;

//Images and Colours

//set up singleton shared

+(mySingleton *)sharedSingleton;

@end

