//
//  ViewController.h
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate, UITextFieldDelegate>

{
    // for file manager
    NSFileManager * fileMgr;
    NSString      * homeDir;
    NSString      * filename;
    NSString      * filepath;
    
    // for calculations and functions
    NSDate        * startDate;
    NSDate        * testDate;

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
@property (nonatomic, copy) NSDate * startDate;
@property (nonatomic, copy) NSDate * testDate;

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

@property (nonatomic, strong) IBOutlet UILabel * VESTPDlbl;
@property (nonatomic, strong) IBOutlet UILabel * VEATPSlbl;
@property (nonatomic, strong) IBOutlet UILabel * RERlbl;
@property (nonatomic, strong) IBOutlet UILabel * VO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * VCO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * datelbl;
@property (nonatomic, strong) IBOutlet UILabel * lablbl;
@property (nonatomic, strong) IBOutlet UILabel * testerlbl;
@property (nonatomic, strong) IBOutlet UILabel * subjectlbl;
@property (nonatomic, strong) IBOutlet UILabel * templbl;
@property (nonatomic, strong) IBOutlet UILabel * pressurelbl;
@property (nonatomic, strong) IBOutlet UILabel * humiditylbl;
@property (nonatomic, strong) IBOutlet UILabel * samptimelbl;
@property (nonatomic, strong) IBOutlet UILabel * VO2Kglbl;
@property (nonatomic, strong) IBOutlet UILabel * subHtlbl;
@property (nonatomic, strong) IBOutlet UILabel * subWtlbl;
@property (nonatomic, strong) IBOutlet UILabel * corrFaclbl;
@property (nonatomic, strong) IBOutlet UILabel * FEO2bl;
@property (nonatomic, strong) IBOutlet UILabel * FECO2lbl;

@property (nonatomic, strong) IBOutlet UILabel * degc;
@property (nonatomic, strong) IBOutlet UILabel * press;

@property (nonatomic,strong) IBOutlet UISwitch * pressureChange;
@property (nonatomic,strong) IBOutlet UISwitch * tempChange;

// for calculations and functions
-(IBAction)setDateNow:(id)sender;
-(IBAction)setTimeNow:(id)sender;

// button press to send the mail
-(IBAction)sendEmail:(id)sender;

-(void)calculateGasses:(id)sender;

@end
