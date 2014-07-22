//
//  resultsView.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "resultsView.h"
#import "mySingleton.h" //for global variables

@interface resultsView()
{
    
//labels for email messages
IBOutlet UILabel     * statusMessageLab;
    
}
@end

@implementation resultsView
@synthesize
//results Labels
RERlbl,
VESTPDlbl,
VEATPSlbl,
VO2lbl,
VCO2lbl,
datelbl,
timelbl,
lablbl,
testerlbl,
subjectlbl,
templbl,
pressurelbl,
humiditylbl,
samptimelbl,
VO2Kglbl,
subHtlbl,
subWtlbl,
corrFaclbl,
FEO2bl,
FECO2lbl;



- (void)viewDidLoad
{
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //read the singleton values and put into the labels
    subjectlbl.text=singleton.subjectName;
    testerlbl.text=singleton.testerName;
    datelbl.text=singleton.testDate;
    timelbl.text=singleton.testTime;
    lablbl.text=singleton.labLocation;
    subWtlbl.text=singleton.subWt;
    subHtlbl.text=singleton.subHt;
    templbl.text=singleton.labTemp;
    pressurelbl.text=singleton.labPressure_mmHg;
    humiditylbl.text=singleton.labHumidity;
    samptimelbl.text=singleton.sampTime;
    VEATPSlbl.text=singleton.veatps;
    VESTPDlbl.text=singleton.vestpd;
    FEO2bl.text=singleton.feo2;
    FECO2lbl.text=singleton.feco2;
    corrFaclbl.text=singleton.corrFactor;
    VO2lbl.text=singleton.vo2;
    VCO2lbl.text=singleton.vco2;
    VO2Kglbl.text=singleton.vo2kg;
    RERlbl.text=singleton.rer;
}

//mail from button press
-(IBAction)sendEmail:(id)sender {
    statusMessageLab.text=@"E-Mail\nResults\nLoading...";
    mySingleton *singleton = [mySingleton sharedSingleton];
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    [mailComposer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail]){
        [mailComposer setToRecipients:[NSArray arrayWithObjects:@"" ,Nil]];
        [mailComposer setSubject:@"Restults from VO2 App"];
        //[mailComposer setMessageBody:@"Dear Tachistoscope User: " isHTML:YES];
        
        [mailComposer setMessageBody: singleton.resultStrings isHTML:NO];
        [mailComposer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:mailComposer animated:YES completion:^{/*email*/}];
    }else{
        
    } //end of if else to check if mail is able to be sent, send message if not
    statusMessageLab.text=@"Select\nNext\nTask";
} // end of mail function

//set out mail controller warnings screen
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *) error {
    statusMessageLab.text=@"Mail\nController";
    if (error) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil,nil];
        [alertview show];
        //[alert release];
        [self dismissViewControllerAnimated:YES completion:^{/*error*/}];
        statusMessageLab.text=@"An mail\nError\nOccurred.";
    }
    else{
        [self dismissViewControllerAnimated:YES completion:^{/*ok*/}];
        statusMessageLab.text=@"E-Mail Sent\nOK.";
    }
    statusMessageLab.text=@"Select\nNext\nTask";
}
@end
