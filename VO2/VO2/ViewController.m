//
//  ViewController.m
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "ViewController.h"
#import "mySingleton.h" //for global variables

// use the following line in any method that needs the singleton
// mySingleton *singleton = [mySingleton sharedSingleton];
// then call like this example
// singleton.btnNotPressed = YES; //YES;

// todo list
//
//--------------------------

@interface ViewController ()
{
    //array result lines
    NSString * resultLine[50];
    
    //text fields for inputs

    IBOutlet UITextField * subjectCodeTxt;
    
    //text views for text displays ie results or help screens
    IBOutlet UITextView  * resultsView;
    IBOutlet UITextView  * resultsViewBorder;
    IBOutlet UITextView  * infoView;
    
    //image views for pictures -edit, not really needed
    IBOutlet UIImageView * logoImage;

    //labels for various input boxes or messages
    IBOutlet UILabel     * statusMessageLab;

}
@end

@implementation ViewController

#pragma mark Inits
//************
//****  inits
//************

@synthesize
//dates
            startDate,
            testDate,
            startDateTxt,
            testDateTxt,
//subject
            subjectNameTxt,
            testerNameTxt,
            subHtTxt,
            subWtTxt,
//file
            fileMgr,
            homeDir,
            filename,
            filepath,
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
//results
            RERlbl,
            VESTPDlbl,
            VEATPSlbl,
            VO2lbl,
            VCO2lbl,

            datelbl,
            lablbl,
            testerlbl,
            subjectlbl,
            templbl,
            pressurelbl,
            humiditylbl,
            samptimelbl
            ;
//end
            




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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSURL *url = [NSURL URLWithString:@"http://www.ess.mmu.ac.uk/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
    
    //set the delegates or text did start/end will not work
    
    startDateTxt.delegate = self;
    testDateTxt.delegate = self;
    //subject
    subjectNameTxt.delegate = self;
    testerNameTxt.delegate = self;
    subHtTxt.delegate = self;
    subWtTxt.delegate = self;
    //lab
    labLocationTxt.delegate = self;
    labTempTxt.delegate = self;
    labPressureTxt.delegate = self;
    labHumidityTxt.delegate = self;
    //calc
    corFactorTxt.delegate = self;
    //sample gas
    sampTimeTxt.delegate = self;
    FECO2Txt.delegate = self;
    FEO2Txt.delegate = self;

    //run calcs with defaults once
    [self calculateGasses:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//--------------------------------
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

- (void)saveText
{
    statusMessageLab.text=@"Saving\nData\nFile.";
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSFileManager *filemgr;
    NSData *databuffer;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    NSString *fileNameS = [NSString stringWithFormat:@"%@.csv", subjectCodeTxt.text];
    dataFile = [docsDir stringByAppendingPathComponent:fileNameS];
    
    databuffer = [singleton.resultStrings dataUsingEncoding: NSASCIIStringEncoding];
    [filemgr createFileAtPath: dataFile
                     contents: databuffer attributes:nil];
}

- (void)calculateGasses:(id)sender {
    //from text boxes
    labHumidity       = [labHumidityTxt.text floatValue];
    labTempC          = [labTempTxt.text floatValue];
    labTempF          = [labTempTxt.text floatValue];
    labPressure_mBar  = [labPressureTxt.text floatValue];
    labPressure_mmHg  = [labPressureTxt.text floatValue];
    subHt             = [subHtTxt.text floatValue];
    subWt             = [subWtTxt.text floatValue];

    //email address
    NSString * emailTxt = @"j.a.howell@mmu.ac.uk";

    //do the calculations
    //VEsptd

    VESTPD = (60 *(VEATPS * ( 273 / (273 + labTempC)) * ((labPressure_mmHg - ((1.001 * labTempC) - 4.19)) / 760))) / sampTime;
    VESTPDlbl.text = [[NSString stringWithFormat:@"%f00000", VESTPD]substringToIndex:4];

    
    //newStr = [str substringToIndex:8]; //chars to print
    
    //put the results in the labels
    //mm's
    //odWheelLbl.text = [[NSString stringWithFormat:@"%f00000",odWheelmm]substringToIndex:6];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //used to clear keyboard if screen touched
    // NSLog(@"Touches began with this event");
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

//one block for each input var to colour the boxes and test the validity
//******** Start of block *********


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //***** change all to suit inputs *****
    
    // change the color of the text box when you touch it
    if(textField==self->startDateTxt){
        startDateTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->testDateTxt){
        testDateTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->subjectNameTxt){
        subjectNameTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->testerNameTxt){
        testerNameTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->subHtTxt){
        subHtTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->subWtTxt){
        subWtTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->labLocationTxt){
        labLocationTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->labTempTxt){
        labTempTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->labHumidityTxt){
        labHumidityTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->corFactorTxt){
        corFactorTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->sampTimeTxt){
        sampTimeTxt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->FECO2Txt){
        FECO2Txt.backgroundColor = [UIColor greenColor];
    }
    if(textField==self->FEO2Txt){
        FEO2Txt.backgroundColor = [UIColor greenColor];
    }

}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    //***** change all to suit inputs *****

    //set int values to the text field inputs
    //from text boxes
    labHumidity       = [labHumidityTxt.text floatValue];
    labTempC          = [labTempTxt.text floatValue];
    labTempF          = [labTempTxt.text floatValue];
    labPressure_mBar  = [labPressureTxt.text floatValue];
    labPressure_mmHg  = [labPressureTxt.text floatValue];
    subHt             = [subHtTxt.text floatValue];
    subWt             = [subWtTxt.text floatValue];
    
    //set all backgrounds to white

        startDateTxt.backgroundColor   = [UIColor whiteColor];
        testDateTxt.backgroundColor    = [UIColor whiteColor];
        subjectNameTxt.backgroundColor = [UIColor whiteColor];
        testerNameTxt.backgroundColor  = [UIColor whiteColor];
        subHtTxt.backgroundColor       = [UIColor whiteColor];
        subWtTxt.backgroundColor       = [UIColor whiteColor];
        labLocationTxt.backgroundColor = [UIColor whiteColor];
        labTempTxt.backgroundColor     = [UIColor whiteColor];
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
        labTempTxt.text=@"-50.0";
        labTempTxt.backgroundColor = [UIColor yellowColor];
    }

    if (labTempC>60) {
        labTempTxt.textColor=[UIColor redColor];
        labTempC=60.0;
        labTempTxt.text=@"60.0";
        labTempTxt.backgroundColor = [UIColor yellowColor];
    }

    labPressureTxt.textColor=[UIColor blackColor];
    if (labPressure_mmHg<600) {
        labPressureTxt.textColor=[UIColor redColor];
        labPressure_mmHg=600;
        labPressureTxt.text=@"600.0";
        labPressureTxt.backgroundColor = [UIColor yellowColor];
    }

    if (labPressure_mmHg>900) {
        labPressureTxt.textColor=[UIColor redColor];
        labPressure_mmHg=900;
        labPressureTxt.text=@"900.0";
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
       //calculate results and display
    [self calculateGasses:self];
}

@end
