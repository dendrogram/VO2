//
//  subjectViewController.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "subjectViewController.h"
#import "mySingleton.h" //for global variables

@interface subjectViewController ()

{
    
}
@end

@implementation subjectViewController

#pragma mark Inits
//************
//****  inits
//************

@synthesize
    startDateTxt,
    testDateTxt,

//subject
    subjectNameTxt,
    testerNameTxt,
    subHtTxt,
    subWtTxt;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//set the delegates or text did start/end will not work
    
    startDateTxt.delegate = self;
    testDateTxt.delegate = self;
    //subject
    subjectNameTxt.delegate = self;
    testerNameTxt.delegate = self;
    subHtTxt.delegate = self;
    subWtTxt.delegate = self;
}

-(IBAction)setDateNow:(id)sender{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    testDateTxt.text=dateString;
    NSLog(@"date: %@", dateString);
}
-(IBAction)setTimeNow:(id)sender{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    startDateTxt.text=resultString;
    NSLog(@"time: %@", resultString);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //used to clear keyboard if screen touched
    // NSLog(@"Touches began with this event");
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //***** change all to suit inputs *****
    //the number refers to the scrolling of the text input field to avoid the keyboard when it appears, then it is moved back afterwards to the 0 origin
    
    //page1
    // change the color of the text box when you touch it
    if(textField==self->testerNameTxt){
        testerNameTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->testDateTxt){
        testDateTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->startDateTxt){
        startDateTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subjectNameTxt){
        subjectNameTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subWtTxt){
        subWtTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subHtTxt){
        subHtTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    //move the screen back to the original place
    [self keyBoardDisappeared:0];
    
    startDateTxt.backgroundColor   = [UIColor whiteColor];
    testDateTxt.backgroundColor    = [UIColor whiteColor];
    subjectNameTxt.backgroundColor = [UIColor whiteColor];
    testerNameTxt.backgroundColor  = [UIColor whiteColor];
    subHtTxt.backgroundColor       = [UIColor whiteColor];
    subWtTxt.backgroundColor       = [UIColor whiteColor];
    // set up link to singleton
    
    singleton.subjectName  = subjectNameTxt.text;
    singleton.testerName   = testerNameTxt.text;
    singleton.subWt        = subWtTxt.text;
    singleton.subHt        = subHtTxt.text;
    singleton.testDate     = testDateTxt.text;
    singleton.testTime     = startDateTxt.text;
    singleton.feo2         = subjectNameTxt.text;
    singleton.feco2        = testerNameTxt.text;
}

-(void) keyBoardAppeared :(int)oft
{
    CGRect frame = self.view.frame;
    //oft= the y of the text field?  make some code to find it
    NSLog(@"oring y = %i",oft);
    [UIView animateWithDuration:1.0
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, -oft, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void) keyBoardDisappeared :(int)oft
{
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    CGRect frame = self.view.frame;
    //oft= the y of the text field?  make some code to find it
    
    [UIView animateWithDuration:1.0
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, oft, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
    singleton.subjectName  = subjectNameTxt.text;
    singleton.testerName   = testerNameTxt.text;
    singleton.testDate     = testDateTxt.text;
    singleton.testTime     = startDateTxt.text;
    singleton.subWt        = subWtTxt.text;
    singleton.subHt        = subHtTxt.text;
    singleton.feo2         = subjectNameTxt.text;
    singleton.feco2        = testerNameTxt.text;
}
@end