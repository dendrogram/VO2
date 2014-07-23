//
//  readingsViewController.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "readingsViewController.h"
#import "mySingleton.h" //for global variables

@interface readingsViewController ()

@end

@implementation readingsViewController

#pragma mark Inits

@synthesize
//lab
labLocationTxt,
labTempTxt,
labPressureTxt,
labHumidityTxt,

//calc
corFactorTxt,

//sample gas
sampTimeTxt,
FECO2Txt,
FEO2Txt,

//switches
pressureChange,
tempChange,

//labels for units
press,
degc
;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //look for switch changs on pressure and temperature
    [self.pressureChange addTarget:self
                            action:@selector(pressureChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tempChange addTarget:self
                        action:@selector(tempChanged:) forControlEvents:UIControlEventValueChanged];
    
    //set the delegates or text did start/end will not work
    //lab
    labLocationTxt.delegate = self;
    labTempTxt.delegate     = self;
    labPressureTxt.delegate = self;
    labHumidityTxt.delegate = self;
    //calc
    corFactorTxt.delegate   = self;
    //sample gas
    sampTimeTxt.delegate    = self;
    FECO2Txt.delegate       = self;
    FEO2Txt.delegate        = self;  
}

-(void)viewDidAppear:(BOOL)animated{
    // set up link to singleton
    mySingleton *singleton      = [mySingleton sharedSingleton];
    
    FEO2Txt.text                =   singleton.feo2              ;
    FECO2Txt.text               =   singleton.feco2             ;
    corFactorTxt.text           =   singleton.corrFactor        ;
    labLocationTxt.text         =   singleton.labLocation       ;
    labTempTxt.text             =   singleton.labTemp           ;
    labHumidityTxt.text         =   singleton.labHumidity       ;
    labPressureTxt.text         =   singleton.labPressure_mmHg  ;
    sampTimeTxt.text            =   singleton.sampTime          ;
}

-(void)viewDidDisappear:(BOOL)animated{
    // set up link to singleton
    mySingleton *singleton      = [mySingleton sharedSingleton];
    singleton.feo2              = [NSString stringWithFormat:@"%@",FEO2Txt.text];
    singleton.feco2             = [NSString stringWithFormat:@"%@",FECO2Txt.text];
    singleton.corrFactor        = [NSString stringWithFormat:@"%@",corFactorTxt.text];
    singleton.labLocation       = [NSString stringWithFormat:@"%@",labLocationTxt.text];
    singleton.labTemp           = [NSString stringWithFormat:@"%@",labTempTxt.text];
    singleton.labHumidity       = [NSString stringWithFormat:@"%@",labHumidityTxt.text];
    singleton.labPressure_mmHg  = [NSString stringWithFormat:@"%@",labPressureTxt.text];
    singleton.sampTime          = [NSString stringWithFormat:@"%@",sampTimeTxt.text];
}

//Pressure switch changed, so recalculate and update textfield
- (void)pressureChanged:(UISwitch *)switchState
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    if ([switchState isOn]) {
        press.text=@"mmHg";
        labPressure_mmHg = 0.75218 * [labPressureTxt.text floatValue];
        labPressure_mBar = labPressure_mmHg / 0.75218;
        labPressureTxt.text = [NSString stringWithFormat:@"%.2f",labPressure_mmHg];
        
        singleton.labPressure_mmHg=[NSString stringWithFormat:@"%.2f",labPressure_mmHg];
    
    } else {
        press.text=@"mBar";
        labPressure_mBar = [labPressureTxt.text floatValue] / 0.75218;
        labPressure_mmHg = 0.75218 * labPressure_mBar;
        labPressureTxt.text = [NSString stringWithFormat:@"%.2f",labPressure_mBar];
        
        singleton.labPressure_mmHg=[NSString stringWithFormat:@"%.2f",labPressure_mmHg];
    }
}

//Temperature switch changed, so recalculate and update textfield
- (void)tempChanged:(UISwitch *)switchState
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    if ([switchState isOn]) {
        degc.text=@"'C";
        labTempC = 5 * ([labTempTxt.text floatValue] - 32) / 9;
        labTempF = (9 * labTempC / 5 ) + 32;
        labTempTxt.text = [NSString stringWithFormat:@"%.2f",labTempC];
        
        singleton.labTemp=[NSString stringWithFormat:@"%.2f",labTempC];
        
    } else {
        degc.text=@"'F";
        labTempF = (9 * [labTempTxt.text floatValue] / 5 ) + 32;
        labTempC = 5 * (labTempF - 32) / 9;
        labTempTxt.text = [NSString stringWithFormat:@"%.2f",labTempF];
        
        singleton.labTemp=[NSString stringWithFormat:@"%.2f",labTempC];
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
//******** Start of block *********

-(void)textFieldDidBeginEditing:(UITextField *)textField{
     if(textField==self->labLocationTxt){
        labLocationTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    //page2
    if(textField==self->labPressureTxt){
        labPressureTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labTempTxt){
        labTempTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labHumidityTxt){
        labHumidityTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->corFactorTxt){
        corFactorTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->sampTimeTxt){
        sampTimeTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->FECO2Txt){
        FECO2Txt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->FEO2Txt){
        FEO2Txt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    //move the screen back to the original place
    [self keyBoardDisappeared:0];
    
    labLocationTxt.backgroundColor = [UIColor whiteColor];
    labTempTxt.backgroundColor     = [UIColor whiteColor];
    labPressureTxt.backgroundColor = [UIColor whiteColor];
    labHumidityTxt.backgroundColor = [UIColor whiteColor];
    corFactorTxt.backgroundColor   = [UIColor whiteColor];
    sampTimeTxt.backgroundColor    = [UIColor whiteColor];
    FECO2Txt.backgroundColor       = [UIColor whiteColor];
    FEO2Txt.backgroundColor        = [UIColor whiteColor];
    
    //set backgrounds to yellow/red if had to correct
    labTempTxt.textColor=[UIColor blackColor];
    if (labTempC<-50) {
        labTempTxt.textColor=[UIColor redColor];
        labTempC=-50.0;
        labTempTxt.text=@"-50.00";
        labTempTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if (labTempC>60) {
        labTempTxt.textColor=[UIColor redColor];
        labTempC=60.0;
        labTempTxt.text=@"60.00";
        labTempTxt.backgroundColor = [UIColor yellowColor];
    }
    
    labPressureTxt.textColor=[UIColor blackColor];
    if (labPressure_mmHg<600) {
        labPressureTxt.textColor=[UIColor redColor];
        labPressure_mmHg=600;
        labPressureTxt.text=@"600.00";
        labPressureTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if (labPressure_mmHg>1000) {
        labPressureTxt.textColor=[UIColor redColor];
        labPressure_mmHg=1000;
        labPressureTxt.text=@"900.00";
        labPressureTxt.backgroundColor = [UIColor yellowColor];
    }
    
    corFactorTxt.textColor=[UIColor blackColor];
    if (corrFactor<0.000) {
        corFactorTxt.textColor=[UIColor redColor];
        corrFactor=0.000;
        corFactorTxt.text=@"0.000";
        corFactorTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if (corrFactor>1.000) {
        corFactorTxt.textColor=[UIColor redColor];
        corrFactor=1.000;
        corFactorTxt.text=@"1.000";
        corFactorTxt.backgroundColor = [UIColor yellowColor];
    }
    
    if(textField==self->labLocationTxt){
        singleton.labLocation=labLocationTxt.text;
    }
    //page2
    if(textField==self->labPressureTxt){
        //aways mmHg
        
        singleton.labPressure_mmHg=labPressureTxt.text;
    }
    if(textField==self->labTempTxt){
        //always 'C
        singleton.labTemp=labTempTxt.text;
    }
    if(textField==self->labHumidityTxt){
        singleton.labHumidity=labHumidityTxt.text;
    }
    if(textField==self->corFactorTxt){
        singleton.corrFactor=corFactorTxt.text;
    }
    if(textField==self->sampTimeTxt){
        singleton.sampTime=sampTimeTxt.text;
    }
    if(textField==self->FECO2Txt){
        singleton.feco2=FECO2Txt.text;
    }
    if(textField==self->FEO2Txt){
        singleton.feo2=FEO2Txt.text;
    }
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