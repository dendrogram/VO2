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
    //array of card images needed
    UIImageView *card[50];
    
    //text fields for inputs

    IBOutlet UITextField *subjectCodeTxt;
    
    //text views for text displays ie results or help screens
    IBOutlet UITextView  *resultsView;
    IBOutlet UITextView  *resultsViewBorder;
    IBOutlet UITextView  *infoView;
    
    //image views for pictures
    IBOutlet UIImageView *logoImage;
    IBOutlet UIImageView *cardHolder;
    IBOutlet UIImageView *subjectCodeLab;
    IBOutlet UIImageView *cardsLab;
    IBOutlet UIImageView *stimLab;
    IBOutlet UIImageView *respLab;
    IBOutlet UIImageView *settingsLab;
    IBOutlet UIImageView *settingsBG;
    IBOutlet UIImageView *JumpingManLogo;
    
    //labels for various input boxes or messages
    IBOutlet UILabel     *statusMessageLab;
    IBOutlet UILabel     *ms1Lab;
    IBOutlet UILabel     *ms2Lab;
    IBOutlet UILabel     *XbutLab;
    IBOutlet UILabel     *ObutLab;
    IBOutlet UILabel     *versionNumberLab;
    IBOutlet UILabel     *clickMessageLab;
    IBOutlet UIImageView *title1Lab;
    IBOutlet UIImageView *title2Lab;
    
    
    //action buttons for methods
    IBOutlet UIButton    *noBut;
    IBOutlet UIButton    *yesBut;
    IBOutlet UIButton    *startBut;
    IBOutlet UIButton    *newTestBut;
    IBOutlet UIButton    *results;
    IBOutlet UIButton    *hideResultsBut;
    IBOutlet UIButton    *saveDataToEmailBut;
    IBOutlet UIButton    *infoBut;
    IBOutlet UIButton    *newSubjectBut;
    
    IBOutlet UIView      *TachistView;
}
@end

@implementation ViewController

#pragma mark Inits
//************
//****  inits
//************

@synthesize startDate;

@synthesize subjectNameTxt;
@synthesize fileMgr;
@synthesize homeDir;
@synthesize filename;
@synthesize filepath;


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
    
    //set the delegates or text did start/end will not work
    textinput1-rename.delegate = self;
    textinput2-rename.delegate = self;
    //add as many as there are inputs
    
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
        [mailComposer setSubject:@"iPad Restults from Tachistoscope V3.3 App"];
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

- (void)calculateBtn:(id)sender {
    //from text boxes
    module      = [moduleTxt.text floatValue];
    teethWheel  = [wheelTeethTxt.text intValue];
    teethPinion = (leavesPinionSegCtrl.selectedSegmentIndex)+6;
    NSLog(@"teeth pinion=%f",teethPinion);
    
    //constants
    //addendaWheels        = 2.76;
    //addendaPinions678    = 1.71;
    //addendaPinions101216 = 1.61;
    
    //do the calculation
    //(nt + addendum) * module
    odWheelmm  = (addendaWheels + teethWheel)*module;
    
    if (teethPinion<10) {
        odPinionmm  = (addendaPinions678 + teethPinion) * module;
    }else{
        odPinionmm  = (addendaPinions101216 + teethPinion) * module;
    }
    
    //convert to thousandths mm x 100 / 2.54
    odWheelth = odWheelmm * 100 / 2.54;
    odPinionth = odPinionmm * 100 / 2.54;
    
    dp  = 25.4 / module;
    pd  = module * teethWheel;
    pdp = module * teethPinion;
    
    //newStr = [str substringToIndex:8]; //chars to print
    
    //put the results in the labels
    //mm's
    odWheelLbl.text = [[NSString stringWithFormat:@"%f00000",odWheelmm]substringToIndex:6];
    odPinionLbl.text = [[NSString stringWithFormat:@"%f00000",odPinionmm]substringToIndex:6];
    //thou's
    odWheelThLbl.text = [[NSString stringWithFormat:@"%f00000",odWheelth]substringToIndex:6];
    odPinionThLbl.text = [[NSString stringWithFormat:@"%f000",odPinionth]substringToIndex:5];
    dpLbl.text = [[NSString stringWithFormat:@"%f000",dp]substringToIndex:5];
    pdLbl.text = [[NSString stringWithFormat:@"%f000",pd]substringToIndex:5];
    pdpLbl.text = [[NSString stringWithFormat:@"%f000",pdp]substringToIndex:5];
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
    if(textField==self->moduleTxt){
        moduleTxt.backgroundColor = [UIColor greenColor];
        // NSLog(@"module");
    }
    if(textField==self->wheelTeethTxt){
        wheelTeethTxt.backgroundColor = [UIColor greenColor];
        // NSLog(@"teeth");
    }
}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    //***** change all to suit inputs *****
    
    //set int values to the text field inputs
    module = [moduleTxt.text floatValue];
    teethWheel = [wheelTeethTxt.text intValue];
    
    //set all backgrounds to white
    moduleTxt.backgroundColor = [UIColor whiteColor];
    wheelTeethTxt.backgroundColor = [UIColor whiteColor];
    
    //set backgrounds to yellow if had to correct
    moduleTxt.textColor=[UIColor blackColor];
    if (module<0.1) {
        moduleTxt.textColor=[UIColor redColor];
        module=0.1;
        moduleTxt.text=@"0.1";
        moduleTxt.backgroundColor = [UIColor yellowColor];
    }
    if (teethWheel>600) {
        wheelTeethTxt.textColor=[UIColor redColor];
        teethWheel=600;
        wheelTeethTxt.text=@"600";
        wheelTeethTxt.backgroundColor = [UIColor yellowColor];
    }
    if (module>9.0) {
        moduleTxt.textColor=[UIColor redColor];
        module=9.0;
        moduleTxt.text=@"9.0";
        moduleTxt.backgroundColor = [UIColor yellowColor];
    }
    if (teethWheel<4) {
        wheelTeethTxt.textColor=[UIColor redColor];
        teethWheel=4;
        wheelTeethTxt.text=@"4";
        wheelTeethTxt.backgroundColor = [UIColor yellowColor];
    }
    [self calculateBtn:self];
}

@end
