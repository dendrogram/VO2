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
    
    int offset;
    int counter;
    int lineWidth;
    int scalingFactor;
    UIColor *lineColour;
    BOOL boxShow;
    BOOL hypot;
    BOOL floatAngle;
    int  crossType;
    CGRect picturePos;
    
    UIImage *imageForDisplay;
    NSMutableArray * cardReactionTimeResult;
    
    NSString *resultsStrings;
    NSString *subjectName;
}

@property (nonatomic) int  offset;
@property (nonatomic) int  counter;
@property (nonatomic) int  lineWidth;
@property (nonatomic,retain) UIColor *lineColour;
@property (nonatomic) int  scalingFactor;
@property (nonatomic) BOOL boxShow;
@property (nonatomic) BOOL hypot;
@property (nonatomic) BOOL floatAngle;
@property (nonatomic) int  crossType;
@property (nonatomic) CGRect picturePos;
@property (nonatomic) UIImage *imageForDisplay;
@property (nonatomic, retain) NSMutableArray *cardReactionTimeResult;
@property (nonatomic, retain) NSString *resultStrings;
@property (nonatomic, retain) NSString *subjectName;

//Flags BOOL

//Strings

//set up singleton shared

+(mySingleton *)sharedSingleton;

@end

