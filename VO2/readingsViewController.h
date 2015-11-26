//
//  readingsViewController.h
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface readingsViewController : UIViewController <UITextFieldDelegate>

{
    float labPressure_mmHg;
    float labPressure_mBar;
    float labTempC;
    float labTempF;
    float VEATPS;
    
    UITextField * labLocationTxt;
    UITextField * labPressureTxt;
    UITextField * labTempTxt;
    UITextField * labHumidityTxt;
    UITextField * sampTimeTxt;
    UITextField * VEATPSTxt;
    UITextField * FEO2Txt;
    UITextField * FECO2Txt;
    UITextField * labO2Txt;
    UITextField * labCO2Txt;
    UISwitch    * pressureChange;
    UISwitch    * tempChange;
    UIButton    * resetO2;
    UIButton    * resetCO2;
}

//text field inputs
//readings screen
@property (nonatomic, strong) IBOutlet UITextField * labLocationTxt;
@property (nonatomic, strong) IBOutlet UITextField * labPressureTxt;
@property (nonatomic, strong) IBOutlet UITextField * labTempTxt;
@property (nonatomic, strong) IBOutlet UITextField * labHumidityTxt;
@property (nonatomic, strong) IBOutlet UITextField * VEATPSTxt;
@property (nonatomic, strong) IBOutlet UITextField * sampTimeTxt;
@property (nonatomic, strong) IBOutlet UITextField * FEO2Txt;
@property (nonatomic, strong) IBOutlet UITextField * FECO2Txt;
@property (nonatomic, strong) IBOutlet UITextField * labO2Txt;
@property (nonatomic, strong) IBOutlet UITextField * labCO2Txt;
@property (nonatomic, strong) IBOutlet UISwitch    * pressureChange;
@property (nonatomic, strong) IBOutlet UISwitch    * tempChange;
@property (nonatomic, strong) IBOutlet UILabel     * degf;
@property (nonatomic, strong) IBOutlet UILabel     * degc;
@property (nonatomic, strong) IBOutlet UILabel     * press;
@property (nonatomic, strong) IBOutlet UIButton    * resetO2;
@property (nonatomic, strong) IBOutlet UIButton    * resetCO2;

-(IBAction)resetO2btn:(id)sender;
-(IBAction)resetCO2btn:(id)sender;
-(void)resetGassesCheckBtnHidden;
@end

