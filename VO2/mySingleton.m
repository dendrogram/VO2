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

//Counters
@synthesize counter;
@synthesize offset;
@synthesize lineWidth;
@synthesize lineColour;
@synthesize scalingFactor;
@synthesize crossType;
@synthesize picturePos;

@synthesize resultStrings;
@synthesize subjectName;

//image
@synthesize imageForDisplay;

//Flags BOOL
@synthesize boxShow;
@synthesize hypot;
@synthesize floatAngle;

//Array
@synthesize cardReactionTimeResult;

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
        //Arrays
        
        //Counters
        counter=0;
        offset=30;
        lineWidth=1;
        lineColour=[UIColor blueColor];
        scalingFactor=1;
        boxShow=YES;
        hypot=NO;
        floatAngle=NO;
        crossType=1;
        
        resultStrings = @"";
        subjectName=@"TempSubject";
        
        picturePos=CGRectMake(10,50,1000,800);//approx, will be updated in a moment anyway
        cardReactionTimeResult = [[NSMutableArray alloc]initWithObjects: nil];
    }
    return self;
}
@end

