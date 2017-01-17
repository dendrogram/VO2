//
//  subjectViewController.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//
//  updated 1/10/16 jah for ios 10.0.2
//

#import "subjectViewController.h"
#import "mySingleton.h" //for global variables

//for settings plist storage of tester and their emal address
#define kEmail      @"emailAddress"
#define kTester     @"testerName"
#define kAnim       @"kanim"

@interface subjectViewController ()
{
    
}
@end

@implementation subjectViewController

#pragma mark Inits

@synthesize
//subject
    startDateTxt,
    testDateTxt,
    subjectNameTxt,
    emailTxt,
    testerNameTxt,
    subHtTxt,
    subWtTxt;
    //keyboardAnim,
    //keyboardAnimSpeed,
    //keyboardAnimDelay;

- (void)viewDidLoad
{
    [super viewDidLoad];

//set the delegates or text did start/end will not work
    //set up the plist params
    NSString *pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString *settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    keyboardAnim     = [defaults boolForKey:kAnim];
        
    startDateTxt.delegate   = self;
    testDateTxt.delegate    = self;
    emailTxt.delegate       = self;
    subjectNameTxt.delegate = self;
    testerNameTxt.delegate  = self;
    subHtTxt.delegate       = self;
    subWtTxt.delegate       = self;
}

-(void)viewDidAppear:(BOOL)animated{
// set up link to singleton
    mySingleton *singleton  = [mySingleton sharedSingleton];
    
    subjectNameTxt.text     =   singleton.oldSubjectName ;
    testerNameTxt.text      =   singleton.testerName  ;
    emailTxt.text           =   singleton.email       ;
    subWtTxt.text           =   singleton.subWt       ;
    subHtTxt.text           =   singleton.subHt       ;
    testDateTxt.text        =   singleton.testDate    ;
    startDateTxt.text       =   singleton.testTime    ;
    
    //set up the plist params
    NSString *pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString *settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //for plist
    //tester name
    testerNameTxt.text     = [defaults objectForKey:kTester];
    if([testerNameTxt.text isEqualToString: @ "" ]){
        testerNameTxt.text =  @"Me";
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.testerName] forKey:kTester];
    }
    //email name
    emailTxt.text     = [defaults objectForKey:kEmail];
    if([emailTxt.text isEqualToString: @ "" ]){
        emailTxt.text =  @"me@mymailaddress.com";
        [defaults setObject:[NSString stringWithFormat:@"%@", singleton.email] forKey:kEmail];
    }
    [defaults synchronize];//make sure all are updated
    
    //bool test1 = [defaults boolForKey:kAnim];
    
    //bool test2;
    //test2 = [defaults boolForKey:kAnim];

        keyboardAnimSpeed   =  1.0;
        keyboardAnimDelay   =  0.5;
    
    keyboardAnim     = [defaults boolForKey:kAnim];
    
    //NSLog(@"keyAnimobje=%i", keyboardAnim);
    //NSLog(@"keyAnimbooloriginal=%i", test1);
    //NSLog(@"keyAnimnew set=%i", test2);
    
    singleton.testerName = testerNameTxt.text;
    singleton.email      = emailTxt.text;
    
    
    
    singleton.email=emailTxt.text;
    singleton.testerName=testerNameTxt.text;
    
    if([testDateTxt.text isEqualToString: @""]){
        //if blank put in today date
        [self setDateNow:self];
        singleton.testDate       = [NSString stringWithFormat:@"%@",  testDateTxt.text];
    }
    if([startDateTxt.text isEqualToString: @""]){
        //if blank put in now time
        [self setTimeNow:self];
        singleton.testTime       = [NSString stringWithFormat:@"%@",  startDateTxt.text];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
// set up link to singleton
    mySingleton *singleton   = [mySingleton sharedSingleton];
    
    singleton.oldSubjectName = [NSString stringWithFormat:@"%@",  subjectNameTxt.text];
    singleton.subjectName    = [NSString stringWithFormat:@"%@",  subjectNameTxt.text];
    singleton.testerName     = [NSString stringWithFormat:@"%@",  testerNameTxt.text];
    singleton.email          = [NSString stringWithFormat:@"%@",  emailTxt.text];
    singleton.subWt          = [NSString stringWithFormat:@"%@",  subWtTxt.text];
    singleton.subHt          = [NSString stringWithFormat:@"%@",  subHtTxt.text];
    singleton.testDate       = [NSString stringWithFormat:@"%@",  testDateTxt.text];
    singleton.testTime       = [NSString stringWithFormat:@"%@",  startDateTxt.text];

    //set up the plist params
    NSString * pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString * settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString * defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary * defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults * defaults        = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //save the updated names to plist
    [defaults setObject:[NSString stringWithFormat:@"%@",singleton.testerName] forKey: kTester ];
    [defaults setObject:[NSString stringWithFormat:@"%@",singleton.email]      forKey: kEmail  ];
    
    [defaults synchronize];//make sure all are updated
    
    if([testDateTxt.text isEqualToString: @""]){
        //if blank put in today date
        [self setDateNow:self];
        singleton.testDate       = [NSString stringWithFormat:@"%@",  testDateTxt.text];
    }
    if([startDateTxt.text isEqualToString: @""]){
        //if blank put in now time
        [self setTimeNow:self];
        singleton.testTime       = [NSString stringWithFormat:@"%@",  startDateTxt.text];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //used to clear keyboard if screen touched
    // NSLog(@"Touches began with this event");
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //***** change all to suit inputs *****
    //the number refers to the scrolling of the text input field to avoid the keyboard when it appears, then it is moved back afterwards to the 0 origin
    
    //no effrect as this App is being ported to iPhone only, even though displaying on an iPad, compromise value
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
    int yy;
    if ( IDIOM == IPAD ) {
        /* do something specifically for iPad. */
        yy=135;
    } else {
        /* do something specifically for iPhone or iPod touch. */
        yy=135;
    }
    
    //page1
    // change the color of the text box when you touch it
    if(textField==self->testerNameTxt){
        testerNameTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-yy;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->testDateTxt){
        testDateTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-yy;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->startDateTxt){
        startDateTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-yy;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subjectNameTxt){
        subjectNameTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-yy;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subWtTxt){
        subWtTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-yy;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subHtTxt){
        subHtTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-yy;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->emailTxt){
        emailTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-yy;
        [self keyBoardAppeared:oft];
    }
}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    
    mySingleton *singleton   = [mySingleton sharedSingleton];
    
//move the screen back to the original place
    [self keyBoardDisappeared:0];
    
    startDateTxt.backgroundColor   = [UIColor whiteColor];
    testDateTxt.backgroundColor    = [UIColor whiteColor];
    subjectNameTxt.backgroundColor = [UIColor whiteColor];
    testerNameTxt.backgroundColor  = [UIColor whiteColor];
    subHtTxt.backgroundColor       = [UIColor whiteColor];
    subWtTxt.backgroundColor       = [UIColor whiteColor];
    emailTxt.backgroundColor       = [UIColor whiteColor];
//
    subHtTxt.textColor       = [UIColor blackColor];
    subWtTxt.textColor       = [UIColor blackColor];
    
    //colour change if out of range and insert range max/min value
    //set backgrounds to yellow/red if had to correct
    
    if ([testerNameTxt.text isEqualToString:@""]||[testerNameTxt.text isEqualToString:@"Me"]) {
        testerNameTxt.backgroundColor = [UIColor yellowColor];
        testerNameTxt.text=@"Me";
    }
    if ([subjectNameTxt.text isEqualToString:@""]||[subjectNameTxt.text isEqualToString:@"- Test Subject - No Name -"]||[subjectNameTxt.text isEqualToString:@"Me"]) {
        subjectNameTxt.backgroundColor = [UIColor yellowColor];
        subjectNameTxt.text=@"- Test Subject - No Name -";
    }
    if ([emailTxt.text isEqualToString:@""]||[emailTxt.text isEqualToString:@"- No Email Address -"]) {
        emailTxt.backgroundColor = [UIColor yellowColor];
        emailTxt.text=@"- No Email Address -";
    }
    
    if ([subHtTxt.text floatValue] <= 0.10||[subHtTxt.text isEqual:@""]||[subHtTxt.text isEqual:NULL]) {
        subHtTxt.textColor = [UIColor redColor];
        subHtTxt.text = @"0.10";
        subHtTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([subHtTxt.text floatValue] >= 3.00) {
        subHtTxt.textColor = [UIColor redColor];
        subHtTxt.text = @"3.00";
        subHtTxt.backgroundColor = [UIColor yellowColor];
    }
    if ([subWtTxt.text floatValue] <= 1.00||[subWtTxt.text isEqual:@""]||[subWtTxt.text isEqual:NULL]) {
        subWtTxt.textColor = [UIColor redColor];
        subWtTxt.text = @"1.00";
        subWtTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([subWtTxt.text floatValue] >= 300.00) {
        subWtTxt.textColor = [UIColor redColor];
        subWtTxt.text = @"300.00";
        subWtTxt.backgroundColor = [UIColor yellowColor];
    }
    
    //maybe do some date and time format testing here?
    BOOL validDate = YES;
    BOOL validTime = YES;

    long add,year,month,day,second,minute,hour;
    
    add = 10 - [startDateTxt.text length];
    if (add > 0) {
        NSString *pad = [[NSString string] stringByPaddingToLength:add withString:@" " startingAtIndex:0];
         startDateTxt.text = [startDateTxt.text stringByAppendingString:pad];
    }
    add = 10 - [testDateTxt.text length];
    if (add > 0) {
        NSString *pad = [[NSString string] stringByPaddingToLength:add withString:@" " startingAtIndex:0];
        testDateTxt.text = [testDateTxt.text stringByAppendingString:pad];//pad with spaces after, to ensure index of string is valid
        //ntestDateTxt = [pad stringByAppendingString:testDateTxt.text];//pad with spaces before
    }
    //NSLog(@">date<>date<= >%@<>%@<",startDateTxt.text, nstartDateTxt);
    //NSLog(@">time<>time<= >%@<>%@<",testDateTxt.text, ntestDateTxt);
    //3,2=month, 0,2=day, 6,4=year
    
//check date, day:month:year is within range and valid
    
    year = [[testDateTxt.text substringWithRange:NSMakeRange(6, 4)] intValue];
    //NSLog(@"str, dd mm yy = %@, ... %i, %i %i",testDateTxt.text, day, month, year);
    if (year < 2000 || year > 2020) {
        validDate = NO;
    }
    month = [[testDateTxt.text substringWithRange:NSMakeRange(3, 2)] intValue];
    if (month < 1|| month > 12) {
        validDate = NO;
    }
    day = [[testDateTxt.text substringWithRange:NSMakeRange(0, 2)] intValue];
    if (day < 1 || day > 31) {
        validDate = NO;
    }
//check time, hour:min:sec is within range and valid
    hour = [[startDateTxt.text substringWithRange:NSMakeRange(0, 2)] intValue];
    if (hour < 0 || hour > 23) {
        validTime = NO;
    }
    minute = [[startDateTxt.text substringWithRange:NSMakeRange(3, 2)] intValue];
    if (minute < 0 || minute > 59) {
        validTime = NO;
    }
    second = [[startDateTxt.text substringWithRange:NSMakeRange(6, 2)] intValue];
    if (second < 0 || second > 59) {
        validDate = NO;
    }
    if (hour+minute+second<=0) {
        startDateTxt.text=@"00:00:00";
        startDateTxt.backgroundColor   = [UIColor yellowColor];
    }
    
    //**********
    if (validDate == NO){
        [self setDateNow:self];
        testDateTxt.backgroundColor    = [UIColor yellowColor];
        singleton.testDate = [NSString stringWithFormat:@"%@",  testDateTxt.text];
    }
    if (validTime == NO){
        [self setTimeNow:self];
        startDateTxt.backgroundColor   = [UIColor yellowColor];
        singleton.testTime = [NSString stringWithFormat:@"%@",  startDateTxt.text];
    }
    //
    //***********
}

-(void) keyBoardAppeared :(int)oft
{
    //move screen up or down as needed to avoid text field entry
    CGRect frame = self.view.frame;
    
    //move frame without anim if toggle in settings indicates yes
    if (keyboardAnim == YES){
    
    //oft= the y of the text field?  make some code to find it
    [UIView animateWithDuration:keyboardAnimSpeed
                          delay:keyboardAnimDelay
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, -oft, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    }else{
        //just move it
        self.view.frame = CGRectMake(frame.origin.x, -oft, frame.size.width, frame.size.height);}
}

-(void) keyBoardDisappeared :(int)oft
{
    //move the screen back to original position
    CGRect frame = self.view.frame;
    //oft= the y of the text field?  make some code to find it
    if (keyboardAnim == YES){
    [UIView animateWithDuration:keyboardAnimSpeed
                          delay:keyboardAnimDelay
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, oft, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    }else{
        //just move it
        self.view.frame = CGRectMake(frame.origin.x, -oft, frame.size.width, frame.size.height);}
}
@end
