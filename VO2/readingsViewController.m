//
//  readingsViewController.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "readingsViewController.h"
#import "mySingleton.h" //for global variables
#define kAnim       @"kanim"

@interface readingsViewController ()
{
    
}

@end

@implementation readingsViewController

#pragma mark Inits

@synthesize
keyboardAnim,
keyboardAnimSpeed,
keyboardAnimDelay,
//lab
        labLocationTxt,
        labTempTxt,
        labPressureTxt,
        labHumidityTxt,

//sample gas
        sampTimeTxt,
        VEATPSTxt,
        FECO2Txt,
        FEO2Txt,
        labO2Txt,
        labCO2Txt,

//switches
        pressureChange,
        tempChange,

//labels for units
        press,
        degc, //label units 'c
        degf, // 'f
        resetO2,
        resetCO2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        mySingleton *singleton      = [mySingleton sharedSingleton];
    

    //temp check

    degc.hidden=NO;
    degf.hidden=YES;
    press.text=@"mmHg";
    
    [pressureChange setOn:YES];
    [tempChange setOn:YES];
    
    //as defaults are used, hide the reset button
    resetO2.hidden=YES;
    resetCO2.hidden=YES;
    
    //look for switch changs on pressure and temperature
    [self.pressureChange addTarget:self
                            action:@selector(pressureChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tempChange addTarget:self
                            action:@selector(tempChanged:) forControlEvents:UIControlEventValueChanged];
    
    //set the delegates or text did start/end will not work
    labLocationTxt.delegate = self;
    labTempTxt.delegate     = self;
    labPressureTxt.delegate = self;
    labHumidityTxt.delegate = self;
    VEATPSTxt.delegate      = self;
    sampTimeTxt.delegate    = self;
    FECO2Txt.delegate       = self;
    FEO2Txt.delegate        = self;
    labO2Txt.delegate       = self;
    labCO2Txt.delegate      = self;
    
    // set up link to singleton
    
    FEO2Txt.text                =   singleton.feo2              ;
    FECO2Txt.text               =   singleton.feco2             ;
    labO2Txt.text               =   singleton.labO2             ;
    labCO2Txt.text              =   singleton.labCO2            ;
    VEATPSTxt.text              =   singleton.veatps            ;
    labLocationTxt.text         =   singleton.labLocation       ;
    labTempTxt.text             =   singleton.labTemp           ;
    labHumidityTxt.text         =   singleton.labHumidity       ;
    labPressureTxt.text         =   singleton.labPressure_mmHg  ;
    sampTimeTxt.text            =   singleton.sampTime          ;
}

-(void)viewDidAppear:(BOOL)animated{
    //set up the plist params
    NSString *pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString *settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    keyboardAnim     = [defaults objectForKey:kAnim]; //set the animation speed off or 1/2 second
    if(keyboardAnim == NO ){
        keyboardAnimSpeed   =  1.0;
        keyboardAnimDelay   =  0.5;
    }else{keyboardAnimSpeed =  0.0;
        keyboardAnimDelay   =  0.0;
    }
    // set up link to singleton
    mySingleton *singleton      = [mySingleton sharedSingleton];
    
    FEO2Txt.text                =   singleton.feo2              ;
    FECO2Txt.text               =   singleton.feco2             ;
    labO2Txt.text               =   singleton.labO2             ;
    labCO2Txt.text              =   singleton.labCO2            ;
    VEATPSTxt.text              =   singleton.veatps            ;
    labLocationTxt.text         =   singleton.labLocation       ;
    labTempTxt.text             =   singleton.labTemp           ;
    labHumidityTxt.text         =   singleton.labHumidity       ;
    labPressureTxt.text         =   singleton.labPressure_mmHg  ;
    sampTimeTxt.text            =   singleton.sampTime          ;
    
    degc.hidden=NO;
    degf.hidden=YES;
    press.text=@"mmHg";
    [pressureChange setOn:YES];
    [tempChange setOn:YES];
    
    [self resetGassesCheckBtnHidden];
    
    [self FEO2CO2check];
}

-(void)resetGassesCheckBtnHidden{
    resetO2.hidden = NO;
    //O2 reset visible?
    if([labO2Txt.text  isEqual: @"20.93"]){
        labO2Txt.text=@"20.93";
        resetO2.hidden=YES;
    }
    //CO2 reset visible?
    resetCO2.hidden = NO;
    if([labCO2Txt.text  isEqual: @"0.04"]){
        labCO2Txt.text=@"0.04";
        resetCO2.hidden=YES;
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    // set up link to singleton
    mySingleton *singleton      = [mySingleton sharedSingleton];
    

    singleton.feo2              = [NSString stringWithFormat:@"%@", FEO2Txt.text];
    singleton.feco2             = [NSString stringWithFormat:@"%@", FECO2Txt.text];
    singleton.labO2             = [NSString stringWithFormat:@"%@", labO2Txt.text];
    singleton.labCO2            = [NSString stringWithFormat:@"%@", labCO2Txt.text];
    singleton.veatps            = [NSString stringWithFormat:@"%@", VEATPSTxt.text];
    singleton.labLocation       = [NSString stringWithFormat:@"%@", labLocationTxt.text];
    singleton.labTemp           = [NSString stringWithFormat:@"%@", labTempTxt.text];
    singleton.labHumidity       = [NSString stringWithFormat:@"%@", labHumidityTxt.text];
    singleton.labPressure_mmHg  = [NSString stringWithFormat:@"%@", labPressureTxt.text];
    singleton.sampTime          = [NSString stringWithFormat:@"%@", sampTimeTxt.text];
}

-(IBAction)resetO2btn:(id)sender{
    labO2Txt.text = @"20.93";
    resetO2.hidden=YES;
}

-(IBAction)resetCO2btn:(id)sender{
    labCO2Txt.text = @"0.04";
    resetCO2.hidden=YES;
}

//Pressure switch changed, so recalculate and update textfield
- (void)pressureChanged:(UISwitch *)switchState
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    if ([switchState isOn]) {
        press.text=@"mmHg";
        labPressure_mmHg = 0.75218 * [labPressureTxt.text floatValue];
        labPressure_mBar = labPressure_mmHg / 0.75218;
        labPressureTxt.text = [NSString stringWithFormat:@"%.1f",labPressure_mmHg];
        
        singleton.labPressure_mmHg=[NSString stringWithFormat:@"%.1f",labPressure_mmHg];//only save mmHg
        singleton.ismmHg=YES;
    
    } else {
        press.text=@"mBar";
        labPressure_mBar = [labPressureTxt.text floatValue] / 0.75218;
        labPressure_mmHg = 0.75218 * labPressure_mBar;
        labPressureTxt.text = [NSString stringWithFormat:@"%.1f",labPressure_mBar];
        
        singleton.labPressure_mmHg=[NSString stringWithFormat:@"%.1f",labPressure_mmHg];//only save mmHg
        singleton.ismmHg=NO;
    }
}

//Temperature switch changed, so recalculate and update textfield
- (void)tempChanged:(UISwitch *)switchState
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    if ([switchState isOn]) {
        degc.hidden=NO;
        degf.hidden=YES;
        labTempC = 5 * ([labTempTxt.text floatValue] - 32) / 9;
        labTempF = (9 * labTempC / 5 ) + 32;
        labTempTxt.text = [NSString stringWithFormat:@"%.1f",labTempC];
        
        singleton.labTemp=[NSString stringWithFormat:@"%.1f",labTempC];//ONLY SAVE 'C
        singleton.isDegC=YES;
        
    } else {
        degc.hidden=YES;
        degf.hidden=NO;
        labTempF = (9 * [labTempTxt.text floatValue] / 5 ) + 32;
        labTempC = 5 * (labTempF - 32) / 9;
        labTempTxt.text = [NSString stringWithFormat:@"%.1f",labTempF];
        
        singleton.labTemp=[NSString stringWithFormat:@"%.1f",labTempC];//ONLY SAVE 'C
        singleton.isDegC=NO;
    }
}

//Fahrenheit to Celsius:
//Celsius = (5 ÷ 9) × (Fahrenheit - 32)
//Celsius to Fahrenheit:
//Fahrenheit = (9 ÷ 5) × Celsius + 32
//--------------------------------

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //used to clear keyboard if screen touched
    // NSLog(@"Touches began with this event");
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

//one block for each input var to colour the boxes and test the validity

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if(textField==self->labLocationTxt){
        labLocationTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labPressureTxt){
        labPressureTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labTempTxt){
        labTempTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labHumidityTxt){
        labHumidityTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->sampTimeTxt){
        sampTimeTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->FECO2Txt){
        FECO2Txt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->FEO2Txt){
        FEO2Txt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->VEATPSTxt){
        VEATPSTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labO2Txt){
        labO2Txt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labCO2Txt){
        labCO2Txt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-165;
        [self keyBoardAppeared:oft];
    }
}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    
    //move the screen back to the original place
    [self keyBoardDisappeared:0];
    
    //convert strings to floats, check and write back strings.
    
    labLocationTxt.backgroundColor = [UIColor whiteColor];
    labTempTxt.backgroundColor     = [UIColor whiteColor];
    labPressureTxt.backgroundColor = [UIColor whiteColor];
    labHumidityTxt.backgroundColor = [UIColor whiteColor];
    VEATPSTxt.backgroundColor      = [UIColor whiteColor];
    sampTimeTxt.backgroundColor    = [UIColor whiteColor];
    FECO2Txt.backgroundColor       = [UIColor whiteColor];
    FEO2Txt.backgroundColor        = [UIColor whiteColor];
    labO2Txt.backgroundColor       = [UIColor whiteColor];
    labCO2Txt.backgroundColor      = [UIColor whiteColor];
    //
    labPressureTxt.textColor       = [UIColor blackColor];
    labLocationTxt.textColor       = [UIColor blackColor];
    labTempTxt.textColor           = [UIColor blackColor];
    labPressureTxt.textColor       = [UIColor blackColor];
    labHumidityTxt.textColor       = [UIColor blackColor];
    VEATPSTxt.textColor            = [UIColor blackColor];
    sampTimeTxt.textColor          = [UIColor blackColor];
    FECO2Txt.textColor             = [UIColor blackColor];
    FEO2Txt.textColor              = [UIColor blackColor];
    labO2Txt.textColor             = [UIColor blackColor];
    labCO2Txt.textColor            = [UIColor blackColor];

    //check if reset buttons need to be shown
    [self resetGassesCheckBtnHidden];
    

  //colour change if out of range and insert range max/min value
  //set backgrounds to yellow/red if had to correct

    if ([labTempTxt.text floatValue] < -40.0||[labTempTxt.text isEqual:@""]||[labTempTxt.text isEqual:NULL]) {
        labTempTxt.textColor = [UIColor redColor];
        labTempC = -40.0;
        labTempTxt.text = @"-40.0";
        labTempTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([labTempTxt.text floatValue] > 60.0) {
        labTempTxt.textColor = [UIColor redColor];
        labTempC = 60.0;
        labTempTxt.text = @"60.0";
        labTempTxt.backgroundColor = [UIColor yellowColor];
    }

    if ([labPressureTxt.text floatValue] < 200.0||[labPressureTxt.text isEqual:@""]||[labPressureTxt.text isEqual:NULL]) {
        labPressureTxt.textColor = [UIColor redColor];
        labPressure_mmHg = 200.0;
        labPressureTxt.text = @"200.0";
        labPressureTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([labPressureTxt.text floatValue] >1200.0) {
        labPressureTxt.textColor = [UIColor redColor];
        labPressure_mmHg = 1200.0;
        labPressureTxt.text = @"1200.0";
        labPressureTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([labO2Txt.text floatValue] > 30.0) {
        labO2Txt.textColor = [UIColor redColor];
        labO2Txt.text = @"30.0";
        labO2Txt.backgroundColor = [UIColor yellowColor];
    }
    if ([labO2Txt.text floatValue] < 0||[labO2Txt.text isEqual:@""]||[labO2Txt.text isEqual:NULL]) {
        labO2Txt.textColor = [UIColor redColor];
        labO2Txt.text = @"0.0";
        labO2Txt.backgroundColor = [UIColor yellowColor];
    }
    if ([labCO2Txt.text floatValue] > 20) {
        labCO2Txt.textColor = [UIColor redColor];
        labCO2Txt.text = @"20.0";
        labCO2Txt.backgroundColor = [UIColor yellowColor];
    }
    if ([labCO2Txt.text floatValue] < 0||[labCO2Txt.text isEqual:@""]||[labCO2Txt.text isEqual:NULL]) {
        labCO2Txt.textColor=[UIColor redColor];
        labCO2Txt.text = @"0.0";
        labCO2Txt.backgroundColor = [UIColor yellowColor];
    }
    if ([sampTimeTxt.text floatValue] < 0||[sampTimeTxt.text isEqual:@""]||[sampTimeTxt.text isEqual:NULL]) {
        sampTimeTxt.textColor=[UIColor redColor];
        sampTimeTxt.text = @"0.0";
        sampTimeTxt.backgroundColor = [UIColor yellowColor];
    }
    if ([sampTimeTxt.text floatValue] >10000.0) {
        sampTimeTxt.textColor=[UIColor redColor];
        sampTimeTxt.text = @"10000.0";
        sampTimeTxt.backgroundColor = [UIColor yellowColor];
    }
    if ([labHumidityTxt.text floatValue] < 0||[labHumidityTxt.text isEqual:@""]||[labHumidityTxt.text isEqual:NULL]) {
        labHumidityTxt.textColor = [UIColor redColor];
        labHumidityTxt.text = @"0";
        labHumidityTxt.backgroundColor = [UIColor yellowColor];
    }
    if ([labHumidityTxt.text floatValue] > 100) {
        labHumidityTxt.textColor = [UIColor redColor];
        labHumidityTxt.text = @"100";
        labHumidityTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([VEATPSTxt.text floatValue] < 0.500) {
        VEATPSTxt.textColor = [UIColor redColor];
        VEATPS = 0.500;
        VEATPSTxt.text = @"0.500";
        VEATPSTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([VEATPSTxt.text floatValue ] > 150.000) {
        VEATPSTxt.textColor = [UIColor redColor];
        VEATPS = 150.000;
        VEATPSTxt.text = @"150.000";
        VEATPSTxt.backgroundColor = [UIColor yellowColor];
    }
    
    [self FEO2CO2check];
}

-(void)FEO2CO2check{
    if ([FEO2Txt.text floatValue] <= 0.000||[FEO2Txt.text isEqual:@""]||[FEO2Txt.text isEqual:NULL]) {
        FEO2Txt.textColor = [UIColor redColor];
        FEO2Txt.text = @"0.000";
        FEO2Txt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([FEO2Txt.text floatValue ] > 100.00) {
        FEO2Txt.textColor = [UIColor redColor];
        FEO2Txt.text = @"100.00";
        FEO2Txt.backgroundColor = [UIColor yellowColor];
    }
    if ([FECO2Txt.text floatValue] <= 0.000||[FECO2Txt.text isEqual:@""]||[FECO2Txt.text isEqual:NULL]) {
        FECO2Txt.textColor = [UIColor redColor];
        FECO2Txt.text = @"0.000";
        FECO2Txt.backgroundColor = [UIColor yellowColor];
    }
    
    if ([FECO2Txt.text floatValue ] > 100.00) {
        FECO2Txt.textColor = [UIColor redColor];
        FECO2Txt.text = @"100.00";
        FECO2Txt.backgroundColor = [UIColor yellowColor];
    }
}
-(void) keyBoardAppeared :(int)oft
{
    //move screen up or down as needed to avoid text field entry
    CGRect frame = self.view.frame;
    
    //move frame without anim if toggle in settings indicates yes
    if (keyboardAnim == NO){
        
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
    if (keyboardAnim == NO){
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