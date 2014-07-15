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
    int     crossType;

    BOOL    boxShow;
    BOOL    hypot;
    BOOL    floatAngle;

    UIColor *lineColour;
    CGRect  picturePos;
    
    UIImage        * imageForDisplay;
    NSMutableArray * cardReactionTimeResult;
    
    NSString       * resultsStrings;
    NSString       * subjectName;
}
//Integers
@property (nonatomic) int  offset;
@property (nonatomic) int  counter;
@property (nonatomic) int  lineWidth;
@property (nonatomic) int  scalingFactor;
@property (nonatomic) int  crossType;

//Flags BOOL
@property (nonatomic) BOOL boxShow;
@property (nonatomic) BOOL hypot;
@property (nonatomic) BOOL floatAngle;
//Images and Colours
@property (nonatomic,retain) UIColor *lineColour;
@property (nonatomic) CGRect picturePos;

@property (nonatomic) UIImage *imageForDisplay;

//Strings
@property (nonatomic, retain) NSMutableArray *cardReactionTimeResult;
@property (nonatomic, retain) NSString *resultStrings;
@property (nonatomic, retain) NSString *subjectName;

//set up singleton shared

+(mySingleton *)sharedSingleton;

@end

