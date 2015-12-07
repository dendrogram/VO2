//
//  resultsView.h
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//
//   7/12/15

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface resultsView : UIViewController <MFMailComposeViewControllerDelegate>
{
    IBOutlet UILabel     * statusMessageLab;
    //text views for text displays ie results or help screens
    //although assigned, not used at present... too fast to be useful
    
// for file manager
    NSFileManager * fileMgr;
    NSString      * homeDir;
    NSString      * filename;
    NSString      * filepath;

// for calculations and functions
    NSDate        * startDate;
    NSDate        * testDate;
    
    UILabel * VESTPDlbl;
    UILabel * VEATPSlbl;
    UILabel * VEBTPSlbl;
    UILabel * RERlbl;
    UILabel * VO2lbl;
    UILabel * VCO2lbl;
    UILabel * N2lbl;
    UILabel * datelbl;
    UILabel * timelbl;
    UILabel * lablbl;
    UILabel * testerlbl;
    UILabel * subjectlbl;
    UILabel * templbl;
    UILabel * pressurelbl;
    UILabel * humiditylbl;
    UILabel * samptimelbl;
    UILabel * VO2Kglbl;
    UILabel * subHtlbl;
    UILabel * subWtlbl;
    UILabel * subBMIlbl;
    UILabel * corrFaclbl;
    UILabel * FEO2lbl;
    UILabel * FECO2lbl;
    UILabel * labO2lbl;
    UILabel * labCO2lbl;
    
    UIButton * emailBtn;
    UIButton * energyBtn;
    
    Float64 subWt;
    Float64 subHt;
    Float64 subBMI;
    Float64 labPressure_mmHg;
    Float64 labPressure_mBar;
    Float64 labTempC;
    Float64 labTempF;
    Float64 labHumidity;
    Float64 VEATPS;
    Float64 VESTPD;
    Float64 VEBTPS;
    Float64 VO2;
    Float64 VCO2;
    Float64 N2;
    Float64 RER;
    Float64 sampTime;
    Float64 FECO2;
    Float64 FEO2;
    Float64 corrFactor1;
    Float64 corrFactor;
    Float64 VO2Kg;
    Float64 labO2;
    Float64 labCO2;
    
    //energies
    Float64 choug;
    Float64 choukj;
    Float64 fatug;
    Float64 fatukj;
    Float64 pfat;
    Float64 pcho;
    Float64 energyExpend;
    
    int counter;
    int dpd; //decimal places displayed in results output (text only)
    NSString * dpds;
    BOOL energyButtonVisible;
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
@property (nonatomic, strong) IBOutlet UILabel * VEATPSlbl;
@property (nonatomic, strong) IBOutlet UILabel * VEBTPSlbl;
@property (nonatomic, strong) IBOutlet UILabel * RERlbl;
@property (nonatomic, strong) IBOutlet UILabel * VO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * VCO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * N2lbl;
@property (nonatomic, strong) IBOutlet UILabel * datelbl;
@property (nonatomic, strong) IBOutlet UILabel * timelbl;
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
@property (nonatomic, strong) IBOutlet UILabel * subBMIlbl;
@property (nonatomic, strong) IBOutlet UILabel * corrFaclbl;
@property (nonatomic, strong) IBOutlet UILabel * FEO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * FECO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * labO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * labCO2lbl;
@property (nonatomic, strong) IBOutlet UIButton * emailBtn;
@property (nonatomic, strong) IBOutlet UIButton * energyBtn;
//@property (nonatomic) BOOL energyButtonVisible;

// button press to send the mail
-(IBAction)sendEmail:(id)sender;
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *) error;
-(NSString *) GetDocumentDirectory;
-(NSString *) setFilename;
-(void) WriteToStringFile:(NSMutableString *)textToWrite;
-(void) calculateStats;
-(void) decimapPlaces;

@end