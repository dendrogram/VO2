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

//set the delegates or text did start/end will not work
    
    startDateTxt.delegate   = self;
    testDateTxt.delegate    = self;
    subjectNameTxt.delegate = self;
    testerNameTxt.delegate  = self;
    subHtTxt.delegate       = self;
    subWtTxt.delegate       = self;
}

-(IBAction)setDateNow:(id)sender{
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    testDateTxt.text=dateString;
    [self updateResults:self];
    NSLog(@"date: %@", dateString);

}
-(IBAction)setTimeNow:(id)sender{
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    startDateTxt.text=resultString;
    [self updateResults:self];
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
    [self updateResults:self];
}

-(void)updateResults:(id)sender{
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    singleton.subjectName  = [NSString stringWithFormat:@"%@",  subjectNameTxt.text];
    singleton.testerName   = [NSString stringWithFormat:@"%@",  testerNameTxt.text];
    singleton.subWt        = [NSString stringWithFormat:@"%@",  subWtTxt.text];
    singleton.subHt        = [NSString stringWithFormat:@"%@",  subHtTxt.text];
    singleton.testDate     = [NSString stringWithFormat:@"%@",  testDateTxt.text];
    singleton.testTime     = [NSString stringWithFormat:@"%@",  startDateTxt.text];
    singleton.feo2         = [NSString stringWithFormat:@"%@",  subjectNameTxt.text];
    singleton.feco2        = [NSString stringWithFormat:@"%@",  testerNameTxt.text];
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
[self updateResults:self];
}
@end