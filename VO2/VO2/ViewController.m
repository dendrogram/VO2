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

//results Labels
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
            samptimelbl,
            VO2Kglbl,
            subHtlbl,
            subWtlbl,
            corrFaclbl,
            FEO2bl,
            FECO2lbl,
            press,
            degc,

//switches
            pressureChange,
            tempChange
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

    //look for switch changs on pressure and temperature
    [self.pressureChange addTarget:self
                      action:@selector(pressureChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tempChange addTarget:self
                            action:@selector(tempChanged:) forControlEvents:UIControlEventValueChanged];
    
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

//Pressure switch changed, so recalculate and update textfield
- (void)pressureChanged:(UISwitch *)switchState
{
    if ([switchState isOn]) {
        press.text=@"mmHg";
        labPressure_mmHg = 0.75218 * [labPressureTxt.text floatValue];
        labPressure_mBar = labPressure_mmHg / 0.75218;
        labPressureTxt.text = [NSString stringWithFormat:@"%.2f",labPressure_mmHg];
        NSLog( @"Pressure mmHg %f",labPressure_mmHg);
    } else {
        press.text=@"mBar";
        labPressure_mBar = [labPressureTxt.text floatValue] / 0.75218;
        labPressure_mmHg = 0.75218 * labPressure_mBar;
        labPressureTxt.text = [NSString stringWithFormat:@"%.2f",labPressure_mBar];
        NSLog( @"Pressure mBar %f",labPressure_mBar);
    }
}
//Pressure switch changed, so recalculate and update textfield
- (void)tempChanged:(UISwitch *)switchState
{
    if ([switchState isOn]) {
        degc.text=@"'C";
        labTempC = 5 * ([labTempTxt.text floatValue] - 32) / 9;
        labTempF = (9 * labTempC / 5 ) + 32;
        labTempTxt.text = [NSString stringWithFormat:@"%.2f",labTempC ];
        NSLog( @"temp %f 'C",labTempC);
    } else {
        degc.text=@"'F";
        labTempF = (9 * [labTempTxt.text floatValue] / 5 ) + 32;
        labTempC = 5 * (labTempF - 32) / 9;
        labTempTxt.text = [NSString stringWithFormat:@"%.2f",labTempF ];
        NSLog( @"temp %f 'F",labTempF);
    }
}
//Fahrenheit to Celsius:
//Celsius = (5 ÷ 9) × (Fahrenheit - 32)
//Celsius to Fahrenheit:
//Fahrenheit = (9 ÷ 5) × Celsius + 32
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

-(IBAction)setDateNow:(id)sender{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    testDateTxt.text=dateString;
    NSLog(@"date: %@", dateString);
}
-(IBAction)setTimeNow:(id)sender{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    startDateTxt.text=resultString;
    NSLog(@"time: %@", resultString);
}


- (void)calculateGasses:(id)sender {
    //from text boxes
    labHumidity       = [labHumidityTxt.text floatValue];
    labTempC          = [labTempTxt.text floatValue];
    //labTempF          = [labTempTxt.text floatValue];
    labPressure_mBar  = [labPressureTxt.text floatValue];
    //labPressure_mmHg  = [labPressureTxt.text floatValue];


    subHt             = [subHtTxt.text floatValue];
    subWt             = [subWtTxt.text floatValue];

    //email address
    NSString * emailTxt = @"j.a.howell@mmu.ac.uk";

    //do the calculations
    //VEsptd

    VESTPD = (60 *(VEATPS * ( 273 / (273 + labTempC)) * ((labPressure_mmHg - ((1.001 * labTempC) - 4.19)) / 760))) / sampTime;
    VESTPDlbl.text = [NSString stringWithFormat:@"%.2f", VESTPD];

    //VO2
    VO2 = 0.01 * (VESTPD * ((( 100 - (FEO2 + FECO2)) / 79.03 ) * 20.93) - (VESTPD * FEO2));
    VO2lbl.text = [NSString stringWithFormat:@"%.2f", VO2];

    //VCO2
    VCO2 = 0.01 * (VESTPD * FECO2);
    VCO2lbl.text = [NSString stringWithFormat:@"%.2f", VCO2];

    //VCO2Kg
    VO2Kg = (VO2 * 1000) / subWt;
    VO2Kglbl.text = [NSString stringWithFormat:@"%.2f", VO2Kg];

    
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
    //the number refers to the scrolling of the text input field to avoid the keyboard when it appears, then it is moved back afterwards to the 0 origin
    //page1
    // change the color of the text box when you touch it
    if(textField==self->testerNameTxt){
        testerNameTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->testDateTxt){
        testDateTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->startDateTxt){
        startDateTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labLocationTxt){
        labLocationTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->subjectNameTxt){
        subjectNameTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
        if(textField==self->subWtTxt){
        subWtTxt.backgroundColor = [UIColor greenColor];
            textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
            int oft=textField.frame.origin.y-250;
            [self keyBoardAppeared:oft];
    }
    if(textField==self->subHtTxt){
        subHtTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-250;
        [self keyBoardAppeared:oft];
    }
    //page2
    if(textField==self->labPressureTxt){
        labPressureTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labTempTxt){
        labTempTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->labHumidityTxt){
        labHumidityTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->corFactorTxt){
        corFactorTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->sampTimeTxt){
        sampTimeTxt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->FECO2Txt){
        FECO2Txt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
    if(textField==self->FEO2Txt){
        FEO2Txt.backgroundColor = [UIColor greenColor];
        textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
        int oft=textField.frame.origin.y-190;
        [self keyBoardAppeared:oft];
    }
}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    //move the screen back to the original place
    [self keyBoardDisappeared:0];

    //***** change all to suit inputs *****

    //set int values to the text field inputs
    //from text boxes
    labHumidity       = [labHumidityTxt.text floatValue];
    //labTempC          = [labTempTxt.text floatValue];
    //labTempF          = [labTempTxt.text floatValue];
    //labPressure_mBar  = [labPressureTxt.text floatValue];
    //labPressure_mmHg  = [labPressureTxt.text floatValue];

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
        labPressureTxt.backgroundColor = [UIColor whiteColor];
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
        labTempTxt.text=@"-50.00";
        labTempTxt.backgroundColor = [UIColor yellowColor];
    }

    if (labTempC>60) {
        labTempTxt.textColor=[UIColor redColor];
        labTempC=60.0;
        labTempTxt.text=@"60.00";
        labTempTxt.backgroundColor = [UIColor yellowColor];
    }

    labPressureTxt.textColor=[UIColor blackColor];
    if (labPressure_mmHg<600) {
        labPressureTxt.textColor=[UIColor redColor];
        labPressure_mmHg=600;
        labPressureTxt.text=@"600.00";
        labPressureTxt.backgroundColor = [UIColor yellowColor];
    }

    if (labPressure_mmHg>900) {
        labPressureTxt.textColor=[UIColor redColor];
        labPressure_mmHg=900;
        labPressureTxt.text=@"900.00";
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


-(void) keyBoardAppeared :(int)oft
{
    CGRect frame = self.view.frame;
    //oft= the y of the text field?  make some code to find it
    NSLog(@"oring y = %i",oft);
    [UIView animateWithDuration:1.0
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, -oft, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){

                     }];
}

-(void) keyBoardDisappeared :(int)oft
{
    CGRect frame = self.view.frame;
    //oft= the y of the text field?  make some code to find it

    [UIView animateWithDuration:1.0
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, oft, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
@end
