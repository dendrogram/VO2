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
@end
