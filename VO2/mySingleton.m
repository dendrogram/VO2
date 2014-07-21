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
@synthesize  addedToResults;
@synthesize  dataCompleted;
@synthesize  sing_subWt;
@synthesize  sing_subHt;
@synthesize  sing_labTemp;
@synthesize  sing_labPressure_mmHg;
@synthesize  sing_labHumidity;
@synthesize  sing_sampTime;
@synthesize  sing_veatps;
@synthesize  sing_vestpd;
@synthesize  sing_feco2;
@synthesize  sing_feo2;
@synthesize  sing_corrFactor;
@synthesize  sing_vo2;
@synthesize  sing_vco2;
@synthesize  sing_vo2kg;
@synthesize  sing_rer;
@synthesize  sing_testerName;
@synthesize  sing_testDate;
@synthesize  sing_testTime;
@synthesize  sing_resultStrings;
@synthesize  sing_subjectName;

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
        
        sing_resultStrings = @"";
    }
    return self;
}
@end

