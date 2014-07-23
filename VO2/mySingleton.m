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
@synthesize addedToResults,
            dataCompleted,

            subWt,
            subHt,
            labTemp,
            labPressure_mmHg,
            labHumidity,
            labLocation,
            sampTime,
            veatps,
            vestpd,
            feco2,
            feo2,
            corrFactor,
            vo2,
            vco2,
            vo2kg,
            labO2,
            rer,
            testerName,
            testDate,
            testTime,
            resultStrings,
            subjectName;

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
        corrFactor         = @"1";
        vo2                = @"0";
        vco2               = @"0";
        vo2kg              = @"0";
        labO2              = @"20.93";
        rer                = @"nil";
        testerName         = @"";
        testDate           = @"";
        testTime           = @"";
        resultStrings      = @"";
        subjectName        = @"subject";
        resultStrings      = @"";
    }
    return self;
}
@end

