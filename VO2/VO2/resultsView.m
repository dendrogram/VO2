//
//  resultsView.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "resultsView.h"
#import "mySingleton.h" //for global variables
//#import "subjectViewController.m"
//#import "resultsView.m"

@interface resultsView()
{

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
        FEO2lbl,
        FECO2lbl,
        labO2lbl,
        testDate;

@synthesize startDate,
            fileMgr,
            homeDir,
            filename,
            filepath;

-(NSString *) setFilename{
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSString *extn = @"csv";
    filename = [NSString stringWithFormat:@"%@.%@", singleton.subjectName, extn];
    return filename;
}

//find the home directory for Document
-(NSString *)GetDocumentDirectory{
    fileMgr = [NSFileManager defaultManager];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    return docsDir;
}

/*Create a new file*/
-(void)WriteToStringFile:(NSMutableString *)textToWrite{
    filepath = [[NSString alloc] init];
    //NSError *err;
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    //check if file exists
    //int fileCounter = 0;
    //BOOL fileExists = TRUE;
    /*if([NSFileManager defaultManager] fileExistsAtPath:filepath) {
     //exists, error, add 1 to filename and repeat
     BOOL fileExists = TRUE;
     }
     else
     {
     //not exists, write
     BOOL fileExists = FALSE;
     }
     //needs more work *****************************
     BOOL ok;
     ok = [textToWrite writeToFile:filepath atomically:YES encoding:NSASCIIStringEncoding error:&err];
     if (!ok) {
     NSLog(@"Error writing file at %@\n%@",
     filepath, [err localizedFailureReason]);
     }*/
}

- (void)saveText
{
    statusMessageLab.text=@"Saving\nData\nFile.";
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSFileManager   * filemgr;
    NSData          * databuffer;
    NSString        * dataFile;
    NSString        * docsDir;
    NSArray         * dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    NSString * fileNameS = [NSString stringWithFormat:@"%@.csv", subjectlbl.text];
    dataFile = [docsDir stringByAppendingPathComponent:fileNameS];
    
    databuffer = [singleton.resultStrings dataUsingEncoding: NSASCIIStringEncoding];
    [filemgr createFileAtPath: dataFile
                     contents: databuffer attributes:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    //read the singleton values and put into the labels
    subjectlbl.text     =   singleton.subjectName;
    testerlbl.text      =   singleton.testerName;
    datelbl.text        =   singleton.testDate;
    timelbl.text        =   singleton.testTime;
    lablbl.text         =   singleton.labLocation;
    subWtlbl.text       =   singleton.subWt;
    subHtlbl.text       =   singleton.subHt;
    templbl.text        =   singleton.labTemp;
    pressurelbl.text    =   singleton.labPressure_mmHg;
    humiditylbl.text    =   singleton.labHumidity;
    samptimelbl.text    =   singleton.sampTime;
    VEATPSlbl.text      =   singleton.veatps;
    VESTPDlbl.text      =   singleton.vestpd;
    FEO2lbl.text        =   singleton.feo2;
    FECO2lbl.text       =   singleton.feco2;
    corrFaclbl.text     =   singleton.corrFactor;
    VO2lbl.text         =   singleton.vo2;
    VCO2lbl.text        =   singleton.vco2;
    VO2Kglbl.text       =   singleton.vo2kg;
    RERlbl.text         =   singleton.rer;
    labO2lbl.text       =   singleton.labO2;
}

// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++
// to edit to suit VO2
// all below to edit - when done delete this line
-(void)calculateStats{
    statusMessageLab.text=@"Calculating\nStats\nPlease\nWait...";
    mySingleton *singleton = [mySingleton sharedSingleton];
    // NSLog(@"Starting Stats");
    
    NSString *myNumbStr = [[NSString alloc] init];
    
    //set counter to cards for singleton global var
    singleton.counter = 1;
    
    [singleton.cardReactionTimeResult removeAllObjects];
    
//set inits zeros her for vars
    
    //totalDelay=0;

//do the calcs here
    
    //put titles and basic params up first
    [singleton.cardReactionTimeResult addObject:@"MMU Cheshire, Exercise and Sport Science, VO2 Application Results"];
    
    //mmu copyright message 2014 JAH
    [singleton.cardReactionTimeResult addObject:@"(c) 2014 MMU written by Jonathan A. Howell for ESS VO2 App"];
    [singleton.cardReactionTimeResult addObject:singleton.versionNumber];
    
    //blank line
    [singleton.cardReactionTimeResult addObject:@" "];
    
    //title line - results one row per data entry
    [singleton.cardReactionTimeResult addObject:@"Card No., Card, Result, Reaction (mS)"];
    
    //results, one per line upto number of cards
    for (int y=1; y<singleton.counter+1; y++) {
        //myNumbStr = [NSString stringWithFormat:@"      %d,          %d,        %d,          %d", y, r1[y],r2[y], ((int)(cardReactionTime[y]+roundUpFactor))];
        [singleton.cardReactionTimeResult addObject: myNumbStr];
    }
    //blank line
    [singleton.cardReactionTimeResult addObject:@" " ];
    
    //end of data message
    [singleton.cardReactionTimeResult addObject:@"End of test data. " ];
    //blank line
    [singleton.cardReactionTimeResult addObject:@" " ];
    //mmu copyright message 2013 JAH
    [singleton.cardReactionTimeResult addObject:@"MMU (c) 2014 VO2 App Jonathan A. Howell SAS Technical Services. " ];
    
    //blank line
    [singleton.cardReactionTimeResult addObject:@" "];
    
    //example for future
    
    // NSString* strRR = [NSString stringWithFormat:@"%@ %@ %@", str1, str2, str3];
    // NSLog(@"Concat: %@.", strRR);
    
    //for (int r=0; r < (singleton.counter+37); r++) {
        //nb if you change the number of line output, alter the 37 to less or more as needed else CRASH -bounds error
        
        // NSLog(@"%@", [singleton.cardReactionTimeResult objectAtIndex: r]);
    //}
    
    //make a text file from the array of results
    NSMutableString *element = [[NSMutableString alloc] init];
    NSMutableString *printString = [NSMutableString stringWithString:@""];
    for(int i=0; i< (singleton.counter+37); i++)
    {
        element = [singleton.cardReactionTimeResult objectAtIndex: i];
        [printString appendString:[NSString stringWithFormat:@"\n%@", element]];
    }
    [printString appendString:@""];
    
    // NSLog(@"string to write pt1:%@",printString);
    //CREATE FILE to save in Documents Directory
    //nb Have to set info.plist environment variable to allow iTunes sharing if want to tx to iTunes etc this dir.
    
    //UIViewController *files = [[UIViewController alloc] init];
    
    singleton.resultStrings = printString;
    
    resultsView.text = singleton.resultStrings;
    //[self saveText];
    [self WriteToStringFile:[printString mutableCopy]];
    
    statusMessageLab.text=@"Waiting\nfor\nNext\nInstruction.";
}
// all above to edit - when done delete this line
// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++

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
