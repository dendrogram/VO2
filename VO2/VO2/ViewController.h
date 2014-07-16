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
    float labTemp;
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
}

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
@property (nonatomic, strong) IBOutlet UITextField * labLocationTxt;


// for calculations and functions


// button press to send the mail
-(IBAction)sendEmail:(id)sender;

-(void)calculateGasses:(id)sender;


@end
