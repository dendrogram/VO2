//
//  subjectViewController.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "subjectViewController.h"
#import "mySingleton.h" //for global variables

@interface subjectViewController ()

{
    //array result lines
    //NSString * resultLine[50];
    
    //text fields for inputs
    
    //IBOutlet UITextField * subjectCodeTxt;
    
    //text views for text displays ie results or help screens
    //IBOutlet UITextView  * resultsView;
    //IBOutlet UITextView  * resultsViewBorder;
    //IBOutlet UITextView  * infoView;
    
    //image views for pictures -edit, not really needed
    //IBOutlet UIImageView * logoImage;
    //labels for email messages
    //IBOutlet UILabel     * statusMessageLab;
    
}
@end

@implementation subjectViewController

#pragma mark Inits
//************
//****  inits
//************

@synthesize
//dates
//startDateVar,
//testDateVar,
startDateTxt,
testDateTxt,

//subject
subjectNameTxt,
testerNameTxt,
subHtTxt,
subWtTxt;

//file
//fileMgr,
//homeDir,
//filename,
//filepath,

//lab
//labLocationTxt,
//labTempTxt,
//abPressureTxt,
//labHumidityTxt,
//calc
//corFactorTxt,

//sample gas
//sampTimeTxt,
//FECO2Txt,
//FEO2Txt,

//switches
//pressureChange,
//tempChange,

//labels for units
//press,
//degc
//;
//end

/*-(NSString *) setFilename{
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSString *extn = @"csv";
    //add unique dientifier to sub name, eg date and time
    
    filename = [NSString stringWithFormat:@"%@_%@_%@.%@", singleton.subjectName,singleton.testDate,singleton.testTime, extn];
    
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

//Create a new file
-(void)WriteToStringFile:(NSMutableString *)textToWrite{
    filepath = [[NSString alloc] init];
    //NSError *err;
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    //check if file exists
    //int fileCounter = 0;
    //BOOL fileExists = TRUE;
    //if([NSFileManager defaultManager] fileExistsAtPath:filepath) {
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
     
     }
}

 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
 //   NSURL *url = [NSURL URLWithString:@"http://www.ess.mmu.ac.uk/"];
 //   NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webview loadRequest:request];
    
    //look for switch changs on pressure and temperature
//    [self.pressureChange addTarget:self
//                            action:@selector(pressureChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.tempChange addTarget:self
 //                       action:@selector(tempChanged:) forControlEvents:UIControlEventValueChanged];
    
    //set the delegates or text did start/end will not work
    
    startDateTxt.delegate = self;
    testDateTxt.delegate = self;
    //subject
    subjectNameTxt.delegate = self;
    testerNameTxt.delegate = self;
    subHtTxt.delegate = self;
    subWtTxt.delegate = self;
    //lab
//    labLocationTxt.delegate = self;
//    labTempTxt.delegate = self;
//    labPressureTxt.delegate = self;
//    labHumidityTxt.delegate = self;
    //calc
//    corFactorTxt.delegate = self;
    //sample gas
//    sampTimeTxt.delegate = self;
//    FECO2Txt.delegate = self;
//    FEO2Txt.delegate = self;
    
    //initialise
//    labTempC=22;
//    labTempF=68;
//    labPressure_mmHg=760;
//    labPressure_mBar=1010.4;
    
}

/*
//Pressure switch changed, so recalculate and update textfield
- (void)pressureChanged:(UISwitch *)switchState
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    if ([switchState isOn]) {
        press.text=@"mmHg";
        labPressure_mmHg = 0.75218 * [labPressureTxt.text floatValue];
        labPressure_mBar = labPressure_mmHg / 0.75218;
        labPressureTxt.text = [NSString stringWithFormat:@"%.2f",labPressure_mmHg];
        
        singleton.labPressure_mmHg=[NSString stringWithFormat:@"%.2f",labPressure_mmHg];
        NSLog( @"Pressure mmHg %f",labPressure_mmHg);
        
    } else {
        press.text=@"mBar";
        labPressure_mBar = [labPressureTxt.text floatValue] / 0.75218;
        labPressure_mmHg = 0.75218 * labPressure_mBar;
        labPressureTxt.text = [NSString stringWithFormat:@"%.2f",labPressure_mBar];
        
        singleton.labPressure_mmHg=[NSString stringWithFormat:@"%.2f",labPressure_mmHg];
        NSLog( @"Pressure mBar %f",labPressure_mBar);
    }
}
//temperature switch changed, so recalculate and update textfield
- (void)tempChanged:(UISwitch *)switchState
{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    if ([switchState isOn]) {
        degc.text=@"'C";
        labTempC = 5 * ([labTempTxt.text floatValue] - 32) / 9;
        labTempF = (9 * labTempC / 5 ) + 32;
        labTempTxt.text = [NSString stringWithFormat:@"%.2f",labTempC];
        
        singleton.labTemp=[NSString stringWithFormat:@"%.2f",labTempC];
        NSLog( @"temp %f 'C",labTempC);
        
    } else {
        degc.text=@"'F";
        labTempF = (9 * [labTempTxt.text floatValue] / 5 ) + 32;
        labTempC = 5 * (labTempF - 32) / 9;
        labTempTxt.text = [NSString stringWithFormat:@"%.2f",labTempF];
        
        singleton.labTemp=[NSString stringWithFormat:@"%.2f",labTempC];
        NSLog( @"temp %f 'F",labTempF);
    }
}
//Fahrenheit to Celsius:
//Celsius = (5 ÷ 9) × (Fahrenheit - 32)
//Celsius to Fahrenheit:
//Fahrenheit = (9 ÷ 5) × Celsius + 32
//--------------------------------


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
*/

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

/*
- (void)calculateGasses:(id)sender {
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    //from text boxes
    labHumidity       = [labHumidityTxt.text floatValue];
    singleton.labHumidity=[NSString stringWithFormat:@"%f",labHumidity];
    
    labTempC          = [labTempTxt.text floatValue];
    singleton.labTemp=[NSString stringWithFormat:@"%f",labTempC];
    
    //labTempF          = [labTempTxt.text floatValue];
    
    //labPressure_mBar  = [labPressureTxt.text floatValue];
    
    labPressure_mmHg  = [labPressureTxt.text floatValue];
    singleton.labPressure_mmHg=[NSString stringWithFormat:@"%f",labPressure_mmHg];
    
    subHt             = [subHtTxt.text floatValue];
    singleton.subHt=[NSString stringWithFormat:@"%f",subHt];
    
    subWt             = [subWtTxt.text floatValue];
    singleton.subWt=[NSString stringWithFormat:@"%f",subWt];
    
    //email address
    NSString * emailTxt = @"j.a.howell@mmu.ac.uk";
    
    //do the calculations
    //VEsptd
    
    VESTPD = (60 *(VEATPS * ( 273 / (273 + labTempC)) * ((labPressure_mmHg - ((1.001 * labTempC) - 4.19)) / 760))) / sampTime;
    singleton.vestpd = [NSString stringWithFormat:@"%.2f", VESTPD];
    
    //VO2
    VO2 = 0.01 * (VESTPD * ((( 100 - (FEO2 + FECO2)) / 79.03 ) * 20.93) - (VESTPD * FEO2));
    singleton.vo2= [NSString stringWithFormat:@"%.2f", VO2];
    
    //VCO2
    VCO2 = 0.01 * (VESTPD * FECO2);
    singleton.vco2= [NSString stringWithFormat:@"%.2f", VCO2];
    
    //VCO2Kg
    VO2Kg = (VO2 * 1000) / subWt;
    singleton.vo2kg= [NSString stringWithFormat:@"%.2f", VO2Kg];
    
    
    //newStr = [str substringToIndex:8]; //chars to print
    
    //put the results in the labels
    //mm's
    //odWheelLbl.text = [[NSString stringWithFormat:@"%f00000",odWheelmm]substringToIndex:6];
    [self updateResults:self];
}
*/

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
    //if(textField==self->labLocationTxt){
    //    labLocationTxt.backgroundColor = [UIColor greenColor];
    //    textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y), textField.frame.size.width, textField.frame.size.height);
    //    int oft=textField.frame.origin.y-250;
    //    [self keyBoardAppeared:oft];
    //}
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
    /*
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
     */
}

-(void)textFieldDidEndEditing:(UITextField *) textField {
    
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    //move the screen back to the original place
    [self keyBoardDisappeared:0];
    
    //***** change all to suit inputs *****
    
    //set int values to the text field inputs
    //from text boxes
    //labHumidity       = [labHumidityTxt.text floatValue];
    //labTempC          = [labTempTxt.text floatValue];
    //labTempF          = [labTempTxt.text floatValue];
    //labPressure_mBar  = [labPressureTxt.text floatValue];
    //labPressure_mmHg  = [labPressureTxt.text floatValue];
    
    //subHt             = [subHtTxt.text floatValue];
    //subWt             = [subWtTxt.text floatValue];
    
    //set all backgrounds to white
    
    startDateTxt.backgroundColor   = [UIColor whiteColor];
    testDateTxt.backgroundColor    = [UIColor whiteColor];
    subjectNameTxt.backgroundColor = [UIColor whiteColor];
    testerNameTxt.backgroundColor  = [UIColor whiteColor];
    subHtTxt.backgroundColor       = [UIColor whiteColor];
    subWtTxt.backgroundColor       = [UIColor whiteColor];
    //labLocationTxt.backgroundColor = [UIColor whiteColor];
    //labTempTxt.backgroundColor     = [UIColor whiteColor];
    //labPressureTxt.backgroundColor = [UIColor whiteColor];
    //labHumidityTxt.backgroundColor = [UIColor whiteColor];
    //corFactorTxt.backgroundColor   = [UIColor whiteColor];
    //sampTimeTxt.backgroundColor    = [UIColor whiteColor];
    //FECO2Txt.backgroundColor       = [UIColor whiteColor];
    //FEO2Txt.backgroundColor        = [UIColor whiteColor];
    
    //set backgrounds to yellow/red if had to correct
    /*
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
    
    if (labPressure_mmHg>1000) {
        labPressureTxt.textColor=[UIColor redColor];
        labPressure_mmHg=1000;
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
    
    [self updateResults:self];
    
    if(textField==self->testerNameTxt){
        //save to singleton
        singleton.testerName=testerNameTxt.text;
    }
    if(textField==self->testDateTxt){
        singleton.testDate=testDateTxt.text;
    }
    if(textField==self->startDateTxt){
        singleton.testTime=startDateTxt.text;
    }
    //if(textField==self->labLocationTxt){
    //    singleton.labLocation=labLocationTxt.text;
    //}
    if(textField==self->subjectNameTxt){
        singleton.subjectName=subjectNameTxt.text;
    }
    if(textField==self->subWtTxt){
        singleton.subWt=subWtTxt.text;
    }
    if(textField==self->subHtTxt){
        singleton.subHt=subHtTxt.text;
    }
    //page2
    
    if(textField==self->labPressureTxt){
        //aways mmHg
        
        singleton.labPressure_mmHg=labPressureTxt.text;
    }
    if(textField==self->labTempTxt){
        //always 'C
        singleton.labTemp=labTempTxt.text;
    }
    if(textField==self->labHumidityTxt){
        singleton.labHumidity=labHumidityTxt.text;
    }
    if(textField==self->corFactorTxt){
        singleton.corrFactor=corFactorTxt.text;
    }
    if(textField==self->sampTimeTxt){
        singleton.sampTime=sampTimeTxt.text;
    }
    if(textField==self->FECO2Txt){
        singleton.feco2=FECO2Txt.text;
    }
    if(textField==self->FEO2Txt){
        singleton.feo2=FEO2Txt.text;
    }
    
    
    //calculate results and display
    //[self calculateGasses:self];*/

    // set up link to singleton
    
    singleton.subjectName  = subjectNameTxt.text;
    singleton.testerName   = testerNameTxt.text;
    singleton.subWt        = subWtTxt.text;
    singleton.subHt        = subHtTxt.text;
    singleton.testDate     = testDateTxt.text;
    singleton.testTime     = startDateTxt.text;
    singleton.feo2         = subjectNameTxt.text;
    singleton.feco2        = testerNameTxt.text;
    
//    singleton.corrFactor   = corFactorTxt.text;
    
//    singleton.labLocation  = labLocationTxt.text;
//    singleton.testerName   = testerNameTxt.text;
//    singleton.labTemp      = labTempTxt.text;
//    singleton.labHumidity  = labHumidityTxt.text;
//    singleton.labPressure_mmHg   = labPressureTxt.text;
//    singleton.sampTime     = sampTimeTxt.text;
    
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
    // set up link to singleton
    mySingleton *singleton = [mySingleton sharedSingleton];
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
    singleton.subjectName  = subjectNameTxt.text;
    singleton.testerName   = testerNameTxt.text;
    singleton.testDate     = testDateTxt.text;
    singleton.testTime     = startDateTxt.text;
    singleton.subWt        = subWtTxt.text;
    singleton.subHt        = subHtTxt.text;
    singleton.feo2         = subjectNameTxt.text;
    singleton.feco2        = testerNameTxt.text;
}
@end