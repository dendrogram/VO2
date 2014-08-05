//
//  TesterNameViewController.m
//  VO2
//
//  Created by Jon Howell on 04/08/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//
//

#import "TesterNameViewController.h"
#import "mySingleton.h" //for global variables

@interface TesterNameViewController ()

@end

@implementation TesterNameViewController

@synthesize testerEmailtxt,
            testerNametxt
            ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //delegates for text filed entries
        testerEmailtxt.delegate    = self;
        testerNametxt.delegate     = self;
}

-(void)viewDidAppear:(BOOL)animated{
    //initalise file nsuserdefails plist
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //Read current values and display in text field
    testerNametxt.text = [defaults objectForKey:kTester];
    testerEmailtxt.text= [defaults objectForKey:kEmail];
}

-(void)viewDidDisappear:(BOOL)animated{
    //write the new values to the singleton and the settings user defaults plist
    //update singleton global values
    mySingleton *singleton = [mySingleton sharedSingleton];
    singleton.testerName = testerNametxt.text;
    singleton.email      = testerEmailtxt.text;
    //update settings plist
    [self refreshSettings];
}

-(void)refreshSettings{
    //initalise file nsuserdefails plist
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //singleton start
    mySingleton *singleton = [mySingleton sharedSingleton];
    //post the values of the text fields to the settings file

    [defaults setObject:singleton.email forKey:kEmail];
    [defaults setObject:singleton.testerName forKey:kTester];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    if(textField==self->testerNametxt){
        testerNametxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->testerEmailtxt){
        testerEmailtxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }

}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    //move the screen back to the original place
    [self keyBoardDisappeared:0];
    testerEmailtxt.backgroundColor   = [UIColor whiteColor];
    testerNametxt.backgroundColor    = [UIColor whiteColor];
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
