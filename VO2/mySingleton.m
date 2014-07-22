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
        subWt              = @"- none -";
        subHt              = @"- none -";
        labTemp            = @"- none -";
        labPressure_mmHg   = @"- none -";
        labHumidity        = @"- none -";
        labLocation        = @"- none -";
        sampTime           = @"- none -";
        veatps             = @"- none -";
        vestpd             = @"- none -";
        feco2              = @"- none -";
        feo2               = @"- none -";
        corrFactor         = @"- none -";
        vo2                = @"- none -";
        vco2               = @"- none -";
        vo2kg              = @"- none -";
        rer                = @"- none -";
        testerName         = @"- none -";
        testDate           = @"- none -";
        testTime           = @"- none -";
        resultStrings      = @"- none -";
        subjectName        = @"- none -";
       
        resultStrings      = @"- none -";
 
 
    }
    return self;
}
@end

