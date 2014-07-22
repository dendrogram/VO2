//
//  ViewController.h
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

{
    // for file manager
    NSFileManager * fileMgr;
    NSString      * homeDir;
    NSString      * filename;
    NSString      * filepath;
    
    // for calculations and functions
    NSDate        * startDateVar;
    NSDate        * testDateVar;

    float subWt;
    float subHt;
    float labPressure_mmHg;
    float labPressure_mBar;
    float labTempC;
    float labTempF;
    float labHumidity;
    float VEATPS;
    float VESTPD;
    float VO2;
    float VCO2;
    float RER;
    float sampTime;
    float FECO2;
    float FEO2;
    float corrFactor;
    float VO2Kg;
}
@property (strong, nonatomic) IBOutlet UIWebView *webview;

//file ops stuff
@property(nonatomic,retain) NSFileManager * fileMgr;
@property(nonatomic,retain) NSString      * homeDir;
@property(nonatomic,retain) NSString      * filename;
@property(nonatomic,retain) NSString      * filepath;

-(NSString *) GetDocumentDirectory;
-(NSString *) setFilename;
-(void) WriteToStringFile:(NSMutableString *)textToWrite;

//dates
@property (nonatomic, copy) NSDate * startDateVar;
@property (nonatomic, copy) NSDate * testDateVar;

//email stuff
@property (nonatomic, strong) IBOutlet UITextField * subjectNameTxt;
@property (nonatomic, strong) IBOutlet UITextField * testerNameTxt;

//text field inputs
@property (nonatomic, strong) IBOutlet UITextField * startDateTxt;
@property (nonatomic, strong) IBOutlet UITextField * testDateTxt;
@property (nonatomic, strong) IBOutlet UITextField * labLocationTxt;
@property (nonatomic, strong) IBOutlet UITextField * labPressureTxt;
@property (nonatomic, strong) IBOutlet UITextField * labTempTxt;
@property (nonatomic, strong) IBOutlet UITextField * labHumidityTxt;
@property (nonatomic, strong) IBOutlet UITextField * corFactorTxt;
@property (nonatomic, strong) IBOutlet UITextField * sampTimeTxt;
@property (nonatomic, strong) IBOutlet UITextField * FEO2Txt;
@property (nonatomic, strong) IBOutlet UITextField * FECO2Txt;
@property (nonatomic, strong) IBOutlet UITextField * subWtTxt;
@property (nonatomic, strong) IBOutlet UITextField * subHtTxt;



@property (nonatomic, strong) IBOutlet UILabel * degc;
@property (nonatomic, strong) IBOutlet UILabel * press;

@property (nonatomic,strong) IBOutlet UISwitch * pressureChange;
@property (nonatomic,strong) IBOutlet UISwitch * tempChange;

// for calculations and functions
-(IBAction)setDateNow:(id)sender;
-(IBAction)setTimeNow:(id)sender;

-(void)calculateGasses:(id)sender;

@end
