//
//  resultsView.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "resultsView.h"
#import "mySingleton.h" //for global variables
//#include "math.h"

@interface resultsView()
{

}
@end

@implementation resultsView
@synthesize
//results Labels
        RERlbl,
        VESTPDlbl,
//        VEATPSlbl,
        VO2lbl,
        VCO2lbl,
        datelbl,
        timelbl,
//        lablbl,
//        testerlbl,
        subjectlbl,
//        templbl,
//        pressurelbl,
//        humiditylbl,
//        samptimelbl,
        VO2Kglbl,
//        subHtlbl,
//        subWtlbl,
        corrFaclbl,
//        FEO2lbl,
//        FECO2lbl,
//        labO2lbl,
        testDate;

@synthesize
        startDate,
        fileMgr,
        homeDir,
        filename,
        filepath,
        emaillbl
        ;

-(NSString *) setFilename{
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSString *extn = @"csv";
    filename = [NSString stringWithFormat:@"%@.%@", singleton.oldSubjectName, extn];
    return filename;
}

//find the home directory for Document
-(NSString *)GetDocumentDirectory{
    fileMgr  = [NSFileManager defaultManager];
    NSString * docsDir;
    NSArray  * dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir  = dirPaths[0];
    return docsDir;
}

/*Create a new file*/
-(void)WriteToStringFile:(NSMutableString *)textToWrite{
    mySingleton *singleton = [mySingleton sharedSingleton];
    //int trynumber = 0;
    filepath = [[NSString alloc] init];
    NSError *err;
    
    //get sub name and add date
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
// not needed as all file names have date added to end of name
    //check if file exists

    //BOOL fileExists = TRUE;
    //if([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        //exists, error, add +1 to filename and repeat
        //BOOL fileExists = TRUE;


        //singleton.subjectName = [singleton.oldSubjectName stringByAppendingString: [NSString stringWithFormat:@"_%@_%i",[self getCurrentDateTimeAsNSString], trynumber]];
        //[self WriteToStringFile:textToWrite];
    //    }
    //else
    //    {
     //not exists, write
     //BOOL fileExists = FALSE;
    
        singleton.subjectName = [singleton.oldSubjectName stringByAppendingString: [NSString stringWithFormat:@"_%@",[self getCurrentDateTimeAsNSString]]];
    
        //}
//

     BOOL ok;
     ok = [textToWrite writeToFile:filepath atomically:YES encoding:NSASCIIStringEncoding error:&err];
     if (!ok) {
         (statusMessageLab.text=filepath, [err localizedFailureReason]);
         //NSLog(@"Error writing file at %@\n%@", filepath, [err localizedFailureReason]);
     }
}


-(NSString*)getCurrentDateTimeAsNSString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"ddMMyyHHmmss"];
    NSDate *now = [NSDate date];
    NSString *retStr = [format stringFromDate:now];

    return retStr;
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
    setTranslatesAutoresizingMaskIntoConstraints:NO;
    [self refreshSettings];
}

-(void)viewDidAppear:(BOOL)animated{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    // set up link to singleton
    if([datelbl.text isEqualToString: @""]){
        //if blank put in today date
        [self setDateNow:self];
    }
    if([timelbl.text isEqualToString: @""]){
        //if blank put in now time
        [self setTimeNow:self];
    }
    singleton.testDate       = [NSString stringWithFormat:@"%@",  datelbl.text];
    singleton.testTime       = [NSString stringWithFormat:@"%@",  timelbl.text];
    [self refreshSettings];
    [self calculateStats];
}
-(void)setDateNow:(id)sender{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    datelbl.text=dateString;
}

-(void)setTimeNow:(id)sender{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [dateFormatter stringFromDate: currentTime];
    timelbl.text=timeString;
}

-(void)refreshSettings{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    mySingleton *singleton = [mySingleton sharedSingleton];
    singleton.email = [defaults objectForKey:kEmail];
    singleton.testerName = [defaults objectForKey:kTester];
}

-(void)calculateStats{
    statusMessageLab.text=@"Calculating\nStats\nPlease\nWait...";
    
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    // NSLog(@"Starting Stats");
    
    NSString *myNumbStr = [[NSString alloc] init];
    
    //set counter to cards for singleton global var
    singleton.counter = 1;

    // clear any old rsults from  results array
    [singleton.cardReactionTimeResult removeAllObjects];
    
//set inits zeros her for vars
    
    //read the singleton values and put into the labels
    subjectlbl.text     =   singleton.oldSubjectName;
    //    testerlbl.text      =   singleton.testerName;
    datelbl.text        =   singleton.testDate;
    timelbl.text        =   singleton.testTime;
    //  lablbl.text         =   singleton.labLocation;
    //  subWtlbl.text       =   singleton.subWt;
    //  subHtlbl.text       =   singleton.subHt;
    //  templbl.text        =   singleton.labTemp;
    //  pressurelbl.text    =   singleton.labPressure_mmHg;
    //  humiditylbl.text    =   singleton.labHumidity;
    //  samptimelbl.text    =   singleton.sampTime;
    //  FEO2lbl.text        =   singleton.feo2;
    //  FECO2lbl.text       =   singleton.feco2;
    corrFaclbl.text     =   singleton.corrFactor;
    //  labO2lbl.text       =   singleton.labO2;
    //  VEATPSlbl.text      =   singleton.veatps;
    
    VESTPDlbl.text      =   @"0.00";
    corrFaclbl.text     =   @"0.00";
    VO2lbl.text         =   @"0.00";
    VCO2lbl.text        =   @"0.00";
    VO2Kglbl.text       =   @"0.00";
    RERlbl.text         =   @"0.00";
    
    labTempC         = [singleton.labTemp     floatValue];
    FECO2            = [singleton.feco2       floatValue];
    FEO2             = [singleton.feo2        floatValue];
    labPressure_mmHg = [singleton.labPressure_mmHg floatValue];
    VEATPS           = [singleton.veatps      floatValue];
    subWt            = [singleton.subWt       floatValue];
    subHt            = [singleton.subHt       floatValue];
    sampTime         = [singleton.sampTime    floatValue];
    labO2            = [singleton.labO2       floatValue];
    labHumidity      = [singleton.labHumidity floatValue];

    //totalDelay=0;

//do the calcs from here:
    
    //lab o2 N2 calcs
    //N2 (if adjust formula, cahnge same in calcViewController
    
    float N2;

    float O2;
    
    N2   = 100 - ([singleton.feo2 floatValue] + [singleton.feco2 floatValue]) ;

    O2   = labO2;

    //vestpd
    //old
    //VESTPD = ( 60 * ( VEATPS * ( 273.0000 / (273.0000 + labTempC )) * (( labPressure_mmHg - (( 1.0010 * labTempC ) - 4.1900 )) / 760 ))) / sampTime;
    //new

    VEBTPS=((VEATPS/sampTime) * 60) * (310 / (273 + labTempC)) * ((labPressure_mmHg - (exp(20.8455 - (5270 / (273 + labTempC))))) / (labPressure_mmHg - 47.08));
    //corrFactor
    //old
    //corrFactor = (273/(273+labTempC))*((labPressure_mmHg - ((1.001 * labTempC) - 4.19)) / 760);
    corrFactor   = VEBTPS;
    singleton.corrFactor = [NSString stringWithFormat:@"%.2f",corrFactor];
    
    VESTPD = VEBTPS * (((0.880645161290323) * labPressure_mmHg - 47.08) / 760);
    
    singleton.vestpd = [NSString stringWithFormat:@"%.2f", VESTPD];
    
    //vo2
    //old
    //VO2    = VESTPD * ((N2 * 0.265) -  FEO2) /100;
    //new
    VO2 = (VESTPD * (labO2 / 100) * ((1 - ((FEO2 / 100) + (FECO2 / 100))) / (1 - ((labO2 / 100) + (labCO2 / 100))))) - (VESTPD * (FEO2 / 100));
    
    singleton.vo2    = [NSString stringWithFormat:@"%.2f", VO2];
    
    //vco2
    //old
    //VCO2   = VESTPD * ( FECO2 - 0.04 )/100;
    //new
    VCO2 = (VESTPD * (FECO2 / 100)) - (VESTPD * (labCO2 / 100) * ((1 - ((FEO2 / 100) + (FECO2 / 100))) / (1 - ((labO2 / 100) + (labCO2 / 100)))));
    
    singleton.vco2   = [NSString stringWithFormat:@"%.2f", VCO2];
    
    //vo2kg
    VO2Kg  = ( VO2 * 1000.00 ) / subWt ;

    singleton.vo2kg  = [NSString stringWithFormat:@"%.2f", VO2Kg];
    
    //rer
    RER    = ( VCO2 / VO2 );
    singleton.rer    = [NSString stringWithFormat:@"%.2f", RER];
    
    //************** energy
    //**
    //** Calc other energy values and results here for mySingleton --> Energy page
    //**
    energyExpenKJ       = (15.88 * VO2) + (4.87 * VCO2);
    energyExpenKCal     = energyExpenKJ * 0.239005736;

    CHOUsage_g_min      = (4.12 * VCO2) - (2.91 * VO2);
    CHOUsage_kj_min     = CHOUsage_g_min * 17.22;
    CHOUsage_kCal_min   = CHOUsage_kj_min * 0.239005736;

    fatUsage_g_min      = (1.689 * VO2) - (1.689 * VCO2);
    fatUsage_kj_min     = fatUsage_g_min * 39.06;
    fatUsage_kCal_min   = fatUsage_kj_min * 0.239005736;

    percentFat          = fatUsage_kj_min / (energyExpenKJ / 100);
    percentCHO          = CHOUsage_kj_min / (energyExpenKJ / 100);

    BMI                 = subWt / subHt;
    //save the energy results to mySingleton

    singleton.BMI               = [NSString stringWithFormat:@"%.4f", BMI];
    singleton.energyExpenKJ     = [NSString stringWithFormat:@"%.4f", energyExpenKJ];
    singleton.energyExpenKCal   = [NSString stringWithFormat:@"%.4f", energyExpenKCal];
    singleton.CHOUsage_g_min    = [NSString stringWithFormat:@"%.4f", CHOUsage_g_min];
    singleton.CHOUsage_kj_min   = [NSString stringWithFormat:@"%.4f", CHOUsage_kj_min];
    singleton.CHOUsage_kCal_min = [NSString stringWithFormat:@"%.4f", CHOUsage_kCal_min];
    singleton.fatUsage_g_min    = [NSString stringWithFormat:@"%.4f", fatUsage_g_min];
    singleton.fatUsage_kj_min   = [NSString stringWithFormat:@"%.4f", fatUsage_kj_min];
    singleton.fatUsage_kCal_min = [NSString stringWithFormat:@"%.4f", fatUsage_kCal_min];
    singleton.percentFat        = [NSString stringWithFormat:@"%.4f", percentFat];
    singleton.percentCHO        = [NSString stringWithFormat:@"%.4f", percentCHO];
    //************** energy
    
    //VEATPSlbl.text      =   singleton.veatps;
    VESTPDlbl.text      =   singleton.vestpd;
    corrFaclbl.text     =   singleton.corrFactor;
    VO2lbl.text         =   singleton.vo2;
    VCO2lbl.text        =   singleton.vco2;
    VO2Kglbl.text       =   singleton.vo2kg;
    RERlbl.text         =   singleton.rer;
    emaillbl.text       =   singleton.email;
    
    //Format for file and email outputs
    //put titles and basic params up first
    [singleton.cardReactionTimeResult addObject:@"MMU Cheshire, Exercise and Sport Science, VO2 Application Results"];
    singleton.counter = singleton.counter+1;
    //mmu copyright message 2014 JAH
    [singleton.cardReactionTimeResult addObject:@"(c) 2014 MMU written by Jonathan A. Howell for ESS VO2 App"];
    //[singleton.cardReactionTimeResult addObject:singleton.versionNumber];
    singleton.counter = singleton.counter+1;
    //blank line
    [singleton.cardReactionTimeResult addObject:@" "];
    singleton.counter = singleton.counter+1;
    //title line - results one row per data entry
    [singleton.cardReactionTimeResult addObject:@"TestNo., Tester, Subject, Test Date, Test Time, Lab Loc'n, Lab Temp 'C, Lab Press mmHg, Lab Hum %, Sub Ht, Sub Wt, Samp Time s,FEO2 L, FECO2 L, Lab O2 %, VEATPS, VESTPD, Corr Fac, VO2, VCO2, VO2kg, RER"];
    singleton.counter = singleton.counter+1;
    // +++++++++++++++++++++++++++
    //loop if rows of results
    //results, one per line upto number of rows
    //for (int y=1; y<singleton.counter+1; y++) {
        //uncomment when formatted
    
        myNumbStr = [NSString stringWithFormat:@"%i,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@" ,
                     counter,
                     singleton.testerName,
                     subjectlbl.text,
                     datelbl.text,
                     timelbl.text,
                     singleton.labLocation,
                     singleton.labTemp,
                     singleton.labPressure_mmHg,
                     singleton.labHumidity,
                     singleton.subHt,
                     singleton.subWt,
                     singleton.sampTime,
                     FEO2,
                     FECO2,
                     labO2,
                     labCO2,
                     VEATPS,
                     VESTPD,
                     corrFactor,
                     VO2,
                     VCO2,
                     VO2Kg,
                     RER,
                     //energy outputs
                     singleton.BMI,
                     singleton.energyExpenKJ,
                     singleton.energyExpenKCal,
                     singleton.CHOUsage_g_min,
                     singleton.CHOUsage_kj_min,
                     singleton.CHOUsage_kCal_min,
                     singleton.fatUsage_g_min,
                     singleton.fatUsage_kj_min,
                     singleton.fatUsage_kCal_min,
                     singleton.percentFat,
                     singleton.percentCHO
                     ]
    ;
    
        [singleton.cardReactionTimeResult addObject: myNumbStr];
    singleton.counter = singleton.counter+1;
    //}
    // +++++++++++++++++++++++++++
    
    //blank line
    [singleton.cardReactionTimeResult addObject:@" " ];
    singleton.counter = singleton.counter+1;
    
    //end of data message
    [singleton.cardReactionTimeResult addObject:@"End of test data. " ];
    singleton.counter = singleton.counter+1;
    //blank line
    [singleton.cardReactionTimeResult addObject:@" " ];
    singleton.counter = singleton.counter+1;
    //mmu copyright message
    [singleton.cardReactionTimeResult addObject:@"MMU (c) 2014 VO2 App Jonathan A. Howell SAS Technical Services. " ];
    singleton.counter = singleton.counter+1;
    //blank line
    [singleton.cardReactionTimeResult addObject:@"."];
    [singleton.cardReactionTimeResult addObject:@".."];
    [singleton.cardReactionTimeResult addObject:@"..."];
    singleton.counter = singleton.counter+1;
    //example for future
    
    // NSString* strRR = [NSString stringWithFormat:@"%@ %@ %@", str1, str2, str3];
    // NSLog(@"Concat: %@.", strRR);
    
    //for (int r=0; r < (singleton.counter+37); r++) {
        //nb if you change the number of line output, alter the 37 to less or more as needed else CRASH -bounds error
        
        // NSLog(@"%@", [singleton.cardReactionTimeResult objectAtIndex: r]);
    //}
    
    //make a text file from the array of results
    NSMutableString *element = [[NSMutableString alloc] init];
    NSMutableString *printString = [NSMutableString stringWithString:@"\n"];
    //
    //array of rows put into one string for text output
    //add back if multi output

    [printString appendString:@"\n"];
    for(int i=0; i< (singleton.counter); i++)
    {
        element = [singleton.cardReactionTimeResult objectAtIndex: i];
        [printString appendString:[NSString stringWithFormat:@"\n%@", element]];
    }
    [printString appendString:@"\n"];
    
    
    // NSLog(@"string to write pt1:%@",printString);
    //CREATE FILE to save in Documents Directory
    //nb Have to set info.plist environment variable to allow iTunes sharing if want to tx to iTunes etc this dir.
    
    //UIViewController *files = [[UIViewController alloc] init];
    
    singleton.resultStrings = printString;
    
    // send to screen... need to link to emailVC so don't do code here in results VC
    //resultsView.text = singleton.resultStrings;
    
    //[self saveText];

    [self WriteToStringFile:[printString mutableCopy]];
    
    statusMessageLab.text=@"Waiting\nfor\nNext\nInstruction.";
}
// all above to edit - when done delete this line
// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++

//mail from button press
-(IBAction)sendEmail:(id)sender {
    //
    // this particular function for email not used at present, using alternate form below...
    //
    statusMessageLab.text=@"E-Mail\nResults\nLoading...";
    mySingleton *singleton = [mySingleton sharedSingleton];
    [self refreshSettings];
    
    MFMailComposeViewController * mailComposer = [[MFMailComposeViewController alloc] init];

    [mailComposer setMailComposeDelegate:self];

    if ([MFMailComposeViewController canSendMail]){

        //[mailComposer setToRecipients:[NSArray arrayWithObjects:@"" ,Nil]];
        [mailComposer setToRecipients:[NSArray arrayWithObject:emaillbl.text]];
        [mailComposer setSubject:@"Results from VO2 App"];
        //[mailComposer setMessageBody:@"Dear VO2 App User: " isHTML:YES];
        
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

//if file name is passed, use...
//- (IBAction)showEmail:(NSString*)file {

- (IBAction)showEmail:(id)sender {
mySingleton *singleton = [mySingleton sharedSingleton];
    NSString *emailTitle = [NSString stringWithFormat:@"VO2 App Data for: %@",singleton.oldSubjectName];
    NSString *messageBody = [NSString stringWithFormat:@"The test data for the subject:%@ taken at the date: %@ and time: %@, is attached as a text/csv file.  \n\nThe file is comma separated variable, csv extension.  \n\nThe data can be read by MS-Excel, then analysed by your own functions. \n\nSent by VO2 App.",singleton.oldSubjectName,singleton.testDate,singleton.testTime];
    //NSArray  *toRecipents = [NSArray arrayWithObject:@"j.a.howell@mmu.ac.uk"];
    NSArray  *toRecipents = [NSArray arrayWithObject:singleton.email];

    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
     mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];

    filepath = [[NSString alloc] init];

    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];

// Get the resource path and read the file using NSData

    NSData *fileData = [NSData dataWithContentsOfFile:filepath];

    // Determine the MIME type
    NSString *mimeType; /*
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"csv"]) { */
        mimeType = @"text/csv";
        /*
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]){
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    } */

    // Add attachment
    [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];

    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}


@end
