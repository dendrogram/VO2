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
// nothing here
}
@end

@implementation subjectViewController

#pragma mark Inits

@synthesize
//subject
    startDateTxt,
    testDateTxt,
    subjectNameTxt,
    testerNamelbl,
    testerEmaillbl,
    subHtTxt,
    subWtTxt;

- (void)viewDidLoad
{
    [super viewDidLoad];
    setTranslatesAutoresizingMaskIntoConstraints:NO;

//set the delegates or text did start/end will not work

    [self refreshSettings];
    
    startDateTxt.delegate   = self;
    testDateTxt.delegate    = self;
    subjectNameTxt.delegate = self;
    subHtTxt.delegate       = self;
    subWtTxt.delegate       = self;
}

-(void)viewDidAppear:(BOOL)animated{
// set up link to singleton
    mySingleton *singleton  = [mySingleton sharedSingleton];

    [self refreshSettings];
    
    subjectNameTxt.text     =   singleton.oldSubjectName ;
    testerNamelbl.text      =   singleton.testerName  ;
    subWtTxt.text           =   [NSString stringWithFormat:@"%.2Lf", singleton.subWt]       ;
    subHtTxt.text           =   [NSString stringWithFormat:@"%.2Lf", singleton.subHt]       ;
    testDateTxt.text        =   singleton.testDate    ;
    startDateTxt.text       =   singleton.testTime    ;
    
    if([testDateTxt.text isEqualToString: @""]){
        //if blank put in today date
        [self setDateNow:self];
    }
    if([startDateTxt.text isEqualToString: @""]){
        //if blank put in now time
        [self setTimeNow:self];
    }
    singleton.testDate       = [NSString stringWithFormat:@"%@",  testDateTxt.text];
    singleton.testTime       = [NSString stringWithFormat:@"%@",  startDateTxt.text];
}

-(void)viewDidDisappear:(BOOL)animated{
// set up link to singleton
    mySingleton *singleton   = [mySingleton sharedSingleton];
    singleton.oldSubjectName = [NSString stringWithFormat:@"%@",  subjectNameTxt.text];
    singleton.subjectName    = [NSString stringWithFormat:@"%@",  subjectNameTxt.text];
    singleton.subWt          = [subWtTxt.text doubleValue];
    singleton.subHt          = [subHtTxt.text doubleValue];

    
    if([testDateTxt.text isEqualToString: @""]){
        //if blank put in today date
        [self setDateNow:self];
    }
    if([startDateTxt.text isEqualToString: @""]){
        //if blank put in now time
        [self setTimeNow:self];
    }
    singleton.testDate       = [NSString stringWithFormat:@"%@",  testDateTxt.text];
    singleton.testTime       = [NSString stringWithFormat:@"%@",  startDateTxt.text];

    // add the warning if testernamelbl and testeremaillbl are not set in settings root plist
    // check for blank tester name

    [self checkEmailAndDisplayAlert];

    if([testerNamelbl.text isEqualToString:@""] || [testerEmaillbl.text isEqualToString:@""]||[self validateEmail : singleton.email]){
    // send to page to add them with warning
    // not ok, update
    [self setEmailTester:self];
    } else {
        //ok
    }

}

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}
// display an alert if email address is wrong:

- (void)checkEmailAndDisplayAlert {
        mySingleton *singleton  = [mySingleton sharedSingleton];
    if(![self validateEmail : singleton.email]) {
        // user entered invalid email address
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid email address." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];

    } else {
        // user entered valid email address
    }
}

-(IBAction)setDateNow:(id)sender{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    testDateTxt.text=dateString;
}

-(IBAction)setTimeNow:(id)sender{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [dateFormatter stringFromDate: currentTime];
    startDateTxt.text=timeString;
}

-(IBAction)setEmailTester:(id)sender{
   // jump to new screen to add details that are missing
    //do nothing yet
    [self performSegueWithIdentifier  : @"TesterNameViewControllerModal"
                                sender: self];
}

- (IBAction)returnToStepOne:(UIStoryboardSegue *)segue {
    NSLog(@"And now we are back.");
}

-(void)refreshSettings{
    NSUserDefaults * defaults  = [NSUserDefaults standardUserDefaults];
    mySingleton    * singleton = [mySingleton sharedSingleton];
    singleton.testerName       = [defaults objectForKey:kTester];
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

    if(textField==self->testDateTxt){
        testDateTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-200;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->startDateTxt){
        startDateTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-200;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subjectNameTxt){
        subjectNameTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-200;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subWtTxt){
        subWtTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-200;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subHtTxt){
        subHtTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-200;
        [self keyBoardAppeared:oft];
    }
}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    
//move the screen back to the original place
    [self keyBoardDisappeared:0];
    
    startDateTxt.backgroundColor   = [UIColor whiteColor];
    testDateTxt.backgroundColor    = [UIColor whiteColor];
    subjectNameTxt.backgroundColor = [UIColor whiteColor];
    subHtTxt.backgroundColor       = [UIColor whiteColor];
    subWtTxt.backgroundColor       = [UIColor whiteColor];
}

-(void) keyBoardAppeared :(int)oft
{
    //move screen up or down as needed to avoid text field entry
    CGRect frame = self.view.frame;
    //oft= the y of the text field?  make some code to find it
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
    //move the screen back to original position
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
}
@end