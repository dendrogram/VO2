//
//  resultsView.h
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

#define kEmail  @"emailAddress"
#define kTester @"testerName"

@interface resultsView : UIViewController <MFMailComposeViewControllerDelegate>
{
    IBOutlet UILabel     * statusMessageLab;
    //text views for text displays ie results or help screens
    
// for file manager
    NSFileManager * fileMgr;
    NSString      * homeDir;
    NSString      * filename;
    NSString      * filepath;

// for calculations and functions
    NSDate        * startDate;
    NSDate        * testDate;


    UILabel * VESTPDlbl;
    UILabel * VEBTPSlbl;
    UILabel * VEATPSlbl;
    UILabel * RERlbl;
    UILabel * VO2lbl;
    UILabel * VCO2lbl;
    UILabel * datelbl;
    UILabel * timelbl;
    UILabel * emaillbl;
    //UILabel * lablbl;
    //UILabel * testerlbl;
    UILabel * subjectlbl;
    //UILabel * templbl;
    //UILabel * pressurelbl;
    //UILabel * humiditylbl;
    //UILabel * samptimelbl;
    UILabel * VO2Kglbl;
    //UILabel * subHtlbl;
    //UILabel * subWtlbl;
    UILabel * VISTPDlbl;
    //UILabel * FEO2lbl;
    //UILabel * FECO2lbl;
    //UILabel * labO2lbl;
    
    long double subWt;
    long double subHt;
    long double labPressure_mmHg;
    long double labPressure_mBar;
    long double labTempC;
    long double labTempF;
    long double labHumidity;
    long double VEATPS;
    long double VEBTPS;
    long double VESTPD;
    long double VISTPD;
    long double VO2;
    long double VCO2;
    long double RER;
    long double sampTime;
    long double FECO2;
    long double FEO2;
    long double corrFactor;
    long double VO2Kg;
    long double labO2;
    long double labCO2;
    
    //energy floats follow
    long double BMI;
    long double energyExpenKJ;
    long double energyExpenKCal;
    long double CHOUsage_g_min;
    long double CHOUsage_kj_min;
    long double CHOUsage_kCal_min;
    long double fatUsage_g_min;
    long double fatUsage_kj_min;
    long double fatUsage_kCal_min;
    long double percentFat;
    long double percentCHO;
    
    int counter;
}

//file ops stuff
@property(nonatomic,retain) NSFileManager * fileMgr;
@property(nonatomic,retain) NSString      * homeDir;
@property(nonatomic,retain) NSString      * filename;
@property(nonatomic,retain) NSString      * filepath;

//dates
@property (nonatomic, copy) NSDate * startDate;
@property (nonatomic, copy) NSDate * testDate;

//var label outlets
@property (nonatomic, strong) IBOutlet UILabel * VESTPDlbl;
@property (nonatomic, strong) IBOutlet UILabel * VISTPDlbl;
@property (nonatomic, strong) IBOutlet UILabel * VEBTPSlbl;
@property (nonatomic, strong) IBOutlet UILabel * VEATPSlbl;
@property (nonatomic, strong) IBOutlet UILabel * RERlbl;
@property (nonatomic, strong) IBOutlet UILabel * VO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * VCO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * datelbl;
@property (nonatomic, strong) IBOutlet UILabel * timelbl;
@property (nonatomic, strong) IBOutlet UILabel * emaillbl;
//@property (nonatomic, strong) IBOutlet UILabel * lablbl;
//@property (nonatomic, strong) IBOutlet UILabel * testerlbl;
@property (nonatomic, strong) IBOutlet UILabel * subjectlbl;
//@property (nonatomic, strong) IBOutlet UILabel * templbl;
//@property (nonatomic, strong) IBOutlet UILabel * pressurelbl;
//@property (nonatomic, strong) IBOutlet UILabel * humiditylbl;
//@property (nonatomic, strong) IBOutlet UILabel * samptimelbl;
@property (nonatomic, strong) IBOutlet UILabel * VO2Kglbl;
//@property (nonatomic, strong) IBOutlet UILabel * subHtlbl;
//@property (nonatomic, strong) IBOutlet UILabel * subWtlbl;
//@property (nonatomic, strong) IBOutlet UILabel * FEO2lbl;
//@property (nonatomic, strong) IBOutlet UILabel * FECO2lbl;
//@property (nonatomic, strong) IBOutlet UILabel * labO2lbl;

// button press to send the mail
-(IBAction)sendEmail:(id)sender;
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *) error;
-(NSString *) GetDocumentDirectory;
-(NSString *) setFilename;
-(void) WriteToStringFile:(NSMutableString *)textToWrite;
-(void)calculateStats;

@end