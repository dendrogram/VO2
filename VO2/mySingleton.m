//
//  mySingleton.m
//  VO2
//
//  Created by Jon Howell on 15/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "mySingleton.h"

static mySingleton * sharedSingleton = nil;

@implementation mySingleton {
    
}

//note, some of these vars unused from other apps, left for reference and future use
// eg for all in .h
// @synthesize counter;

//Counters
@synthesize
            testDate,
            testTime,
            testerName,
            subjectName,
            oldSubjectName,
            subWt,
            subHt,
            email,

            labTemp,
            labPressure_mmHg,
            labHumidity,
            labLocation,
            sampTime,
            feco2,
            feo2,
            labO2,
            labCO2,

            veatps,
            vestpd,
            corrFactor,
            vo2,
            vco2,
            vo2kg,
            rer,
//energy
            BMI,
            energyExpenKJ,
            energyExpenKCal,
            CHOUsage_g_min,
            CHOUsage_kj_min,
            CHOUsage_kCal_min,
            fatUsage_g_min,
            fatUsage_kj_min,
            fatUsage_kCal_min,
            percentFat,
            percentCHO,

            addedToResults,
            dataCompleted,
            resultStrings,
            cardReactionTimeResult,
            counter,

            versionNumber
            ;

#pragma mark -
#pragma mark Singleton Methods

+ (mySingleton *) sharedSingleton {
    if(sharedSingleton==nil) {
        sharedSingleton = [[super allocWithZone:NULL]init];
    }
    return sharedSingleton;
}

+ (id)allocWithZone:(NSZone *) zone {
    return [self sharedSingleton];
}

- (id)copyWithZone:(NSZone *) zone {
    return self;
}

- (id) init {
    if(self = [super init]) {
        
        //initialise with values, eg
        //linewidth=1;
        //counter=0;
        //lineColour=[UIColor blueColor];
        //boxShow=YES;
        //subjectName=@"TempSubject";
        //picturePos=CGRectMake(10,50,1000,800);//approx, will be updated in a moment anyway
        //cardReactionTimeResult = [[NSMutableArray alloc]initWithObjects: nil];

        addedToResults     = NO;
        dataCompleted      = NO;
        subWt              = @"75";
        subHt              = @"1.75";
        labTemp            = @"20";
        labPressure_mmHg   = @"760";
        labHumidity        = @"35";
        labLocation        = @"hpl";
        sampTime           = @"60";
        veatps             = @"0";
        vestpd             = @"0";
        feco2              = @"0";
        feo2               = @"0";
        veatps             = @"30";
        corrFactor         = @"1";
        vo2                = @"0";
        vco2               = @"0";
        vo2kg              = @"0";
        labO2              = @"20.93";
        labCO2             = @"0.04";
        rer                = @"0";
        //energy
        BMI                = @"0";
        energyExpenKJ      = @"0";
        energyExpenKCal    = @"0";
        CHOUsage_g_min     = @"0";
        CHOUsage_kj_min    = @"0";
        CHOUsage_kCal_min  = @"0";
        fatUsage_g_min     = @"0";
        fatUsage_kj_min    = @"0";
        fatUsage_kCal_min  = @"0";
        percentFat         = @"0";
        percentCHO         = @"0";
        
        testerName         = @"Tester";
        testDate           = @"";
        testTime           = @"";
        resultStrings      = @"";
        subjectName        = @"A";
        oldSubjectName     = @"A";
        resultStrings      = @"";
        versionNumber      = @"";
        cardReactionTimeResult = [[NSMutableArray alloc]initWithObjects: nil]; //empty array
        counter            = 0;
    }
    return self;
}
@end

