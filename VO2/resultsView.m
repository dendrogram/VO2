//
//  resultsView.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "resultsView.h"
#import "mySingleton.h" //for global variables
#define kEnergyButton  @"eresults"

//rgb colour setting for boxes
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

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
        VEBTPSlbl,
        VO2lbl,
        VCO2lbl,
        N2lbl,
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
        subBMIlbl,
        corrFaclbl,
        FEO2lbl,
        FECO2lbl,
        labO2lbl,
        labCO2lbl,
        testDate,
        startDate,
        fileMgr,
        homeDir,
        filename,
        filepath,
        emailBtn,
        energyBtn;
        //energyButtonVisible;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //NSLog(@"You moved to a new screen...");
    
    //if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //RecipeDetailViewController *destViewController = segue.destinationViewController;
        //destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
        
        // Hide bottom tab bar in the detail view
        //destViewController.hidesBottomBarWhenPushed = YES;
    //}
}

-(NSString *) setFilename{
    mySingleton *singleton = [mySingleton sharedSingleton];
    NSString *extn = @"csv";
    filename = [NSString stringWithFormat:@"%@.%@", singleton.oldSubjectName, extn];
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
         //(statusMessageLab.text=filepath, [err localizedFailureReason]);
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
    //statusMessageLab.text=@"Saving\nData\nFile.";
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
    statusMessageLab.hidden = YES;
    energyBtn.hidden=YES;
    //set up the plist params
    NSString *pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString *settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    energyButtonVisible     = [defaults boolForKey:kEnergyButton];
}

-(void)viewDidAppear:(BOOL)animated{
    //set up the plist params
    NSString *pathStr               = [[NSBundle mainBundle] bundlePath];
    NSString *settingsBundlePath    = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *defaultPrefsFile      = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *defaultPrefs      = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //bool test2;
    //test2 = [defaults boolForKey:kEnergyButton];
    
    [defaults synchronize];
    energyButtonVisible     = [defaults boolForKey:kEnergyButton];
    
    //NSLog(@"Energy button=%i",energyButtonVisible);
    
    statusMessageLab.hidden = YES;
    energyBtn.hidden=YES;
    
    mySingleton *singleton = [mySingleton sharedSingleton];
    timelbl.backgroundColor  = Rgb2UIColor(255, 255, 200);
    datelbl.backgroundColor  = Rgb2UIColor(255, 255, 200);
    //only if blank date
    // set up link to singleton
    if([datelbl.text isEqualToString: @""]){
        //if blank put in today date
        [self setDateNow:self];
        singleton.testDate       = [NSString stringWithFormat:@"%@",  datelbl.text];
        datelbl.backgroundColor  = [UIColor yellowColor]; //color if was changed
    }
    if([timelbl.text isEqualToString: @""]){
        //if blank put in now time
        [self setTimeNow:self];
        singleton.testTime       = [NSString stringWithFormat:@"%@",  timelbl.text];
        timelbl.backgroundColor  = [UIColor yellowColor];
    }
    
    [self calculateStats];
    
    emailBtn.hidden=NO; //show the button for now
    
    FEO2lbl.backgroundColor  = Rgb2UIColor(255, 255, 200);
    FECO2lbl.backgroundColor = Rgb2UIColor(255, 255, 200);
    VO2lbl.backgroundColor   = Rgb2UIColor(255, 255, 200);
    VCO2lbl.backgroundColor  = Rgb2UIColor(255, 255, 200);
    RERlbl.backgroundColor   = Rgb2UIColor(255, 255, 200);
    subBMIlbl.backgroundColor= Rgb2UIColor(255, 255, 200);
    //timelbl.backgroundColor  = Rgb2UIColor(255, 255, 200);
    //datelbl.backgroundColor  = Rgb2UIColor(255, 255, 200);
    
    //if any errors, hide the email
    
    if ([FEO2lbl.text  floatValue] <= 0.0||[FEO2lbl.text isEqual:@""]||[FEO2lbl.text isEqual:NULL]||isnan([FEO2lbl.text floatValue])) {
        //red if blank
        emailBtn.hidden=YES;
        FEO2lbl.backgroundColor = [UIColor redColor];
    }
    
    if ([FECO2lbl.text  floatValue] <= 0.0||[FECO2lbl.text isEqual:@""]||[FECO2lbl.text isEqual:NULL]||isnan([FECO2lbl.text floatValue])) {
        //red if blank
        emailBtn.hidden=YES;
        FECO2lbl.backgroundColor = [UIColor redColor];
    }
    
    if ([VCO2lbl.text  floatValue] <= 0.0||[VCO2lbl.text isEqual:@""]||[VCO2lbl.text isEqual:NULL]||isnan([VCO2lbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        VCO2lbl.backgroundColor = [UIColor redColor];
    }
    if ([VO2lbl.text  floatValue] <= 0.0||[VO2lbl.text isEqual:@""]||[VO2lbl.text isEqual:NULL]||isnan([VO2lbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        VO2lbl.backgroundColor = [UIColor redColor];
    }
    if ([VO2Kglbl.text  floatValue] <= 0.0||[VO2Kglbl.text isEqual:@""]||[VO2Kglbl.text isEqual:NULL]||isnan([VO2Kglbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        VO2Kglbl.backgroundColor = [UIColor redColor];
    }
    if ([templbl.text isEqual:@""]||[templbl.text isEqual:NULL]||isnan([templbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        templbl.backgroundColor = [UIColor redColor];
    }
    if ([VESTPDlbl.text isEqual:@""]||[VESTPDlbl.text isEqual:NULL]||isnan([VESTPDlbl.text floatValue])||[VESTPDlbl.text floatValue]==INFINITY) {
        //red if negative
        emailBtn.hidden=YES;
        VESTPDlbl.backgroundColor = [UIColor redColor];
    }
    if ([humiditylbl.text isEqual:@""]||[humiditylbl.text isEqual:NULL]||isnan([humiditylbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        humiditylbl.backgroundColor = [UIColor redColor];
    }
    if ([labCO2lbl.text isEqual:@""]||[labCO2lbl.text isEqual:NULL]||isnan([labCO2lbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        labCO2lbl.backgroundColor = [UIColor redColor];
    }
    if ([labO2lbl.text isEqual:@""]||[labO2lbl.text isEqual:NULL]||isnan([labO2lbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        labO2lbl.backgroundColor = [UIColor redColor];
    }
    if ([samptimelbl.text isEqual:@""]||[samptimelbl.text isEqual:NULL]||isnan([samptimelbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        samptimelbl.backgroundColor = [UIColor redColor];
    }
    
    if ([RERlbl.text  floatValue] <= 0.0||[RERlbl.text isEqual:@""]||[RERlbl.text isEqual:NULL]||isnan([RERlbl.text floatValue])) {
        //red if negative
        emailBtn.hidden=YES;
        RERlbl.backgroundColor = [UIColor redColor];
    }
    if ([subBMIlbl.text  floatValue] < 12.0) {
        //red if too low
        subBMIlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subBMIlbl.text  floatValue] > 50.0) {
        //red if too high
        subBMIlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subWtlbl.text  floatValue] <30) {
        //orange low
        subWtlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subWtlbl.text  floatValue] >130) {
        //orange high
        subWtlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subHtlbl.text  floatValue] <=1.0) {
        //orange low
        subHtlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([subHtlbl.text  floatValue] >=1.9) {
        //orange high
        subHtlbl.backgroundColor = [UIColor orangeColor];
    }
    if ([testerlbl.text isEqual:@""]||[testerlbl.text isEqual:NULL]||[testerlbl.text isEqual:@"Me"]) {
        //orange missing
        testerlbl.backgroundColor = [UIColor orangeColor];
    }
    [defaults synchronize];//make sure all are updated
    if ([testerlbl.text isEqual:@"Energy"] || energyButtonVisible == YES) {
        //orange missing
        testerlbl.backgroundColor = [UIColor whiteColor];
        energyBtn.hidden = NO;
    }else{
        testerlbl.backgroundColor = [UIColor yellowColor];
        energyBtn.hidden = YES;}
    
    if ([lablbl.text isEqual:@""]||[lablbl.text isEqual:NULL]) {
        //orange missing
        lablbl.backgroundColor = [UIColor yellowColor];
    }

    if ([pressurelbl.text  floatValue] <=740) {
        //orange low
        pressurelbl.backgroundColor = [UIColor orangeColor];
    }
    if ([pressurelbl.text  floatValue] >=770) {
        //orange high
        pressurelbl.backgroundColor = [UIColor orangeColor];
    }
    if ([templbl.text  floatValue] <=15) {
        //orange low
        templbl.backgroundColor = [UIColor yellowColor];
    }
    if ([templbl.text  floatValue] >=27) {
        //orange high
        templbl.backgroundColor = [UIColor yellowColor];
    }
    if ([samptimelbl.text  floatValue] <30) {
        //orange low
        samptimelbl.backgroundColor = [UIColor yellowColor];
    }
    if ([samptimelbl.text  floatValue] >60) {
        //orange high
        samptimelbl.backgroundColor = [UIColor yellowColor];
    }
    if ([humiditylbl.text  floatValue] <30) {
        //orange low
        humiditylbl.backgroundColor = [UIColor yellowColor];
    }
    if ([humiditylbl.text  floatValue] >75) {
        //orange high
        humiditylbl.backgroundColor = [UIColor yellowColor];
    }
    if ([labO2lbl.text  floatValue] <18) {
        //orange low
        labO2lbl.backgroundColor = [UIColor yellowColor];
    }
    if ([labO2lbl.text  floatValue] >21) {
        //orange high
        labO2lbl.backgroundColor = [UIColor yellowColor];
    }
    if ([labCO2lbl.text  floatValue] <0.02) {
        //orange low
        labCO2lbl.backgroundColor = [UIColor yellowColor];
    }
    if ([labCO2lbl.text  floatValue] >0.1) {
        //orange high
        labCO2lbl.backgroundColor = [UIColor yellowColor];
    }
    if ([N2lbl.text  floatValue] <=65) {
        //orange low
        N2lbl.backgroundColor = [UIColor yellowColor];
    }
    if ([N2lbl.text  floatValue] >=80) {
        //orange high
        N2lbl.backgroundColor = [UIColor yellowColor];
    }
    if ([VEATPSlbl.text  floatValue] <=25) {
        //orange low
        VEATPSlbl.backgroundColor = [UIColor yellowColor];
    }
    if ([VEATPSlbl.text  floatValue] >=35) {
        //orange high
        VEATPSlbl.backgroundColor = [UIColor yellowColor];
    }
    if ([VESTPDlbl.text  floatValue] <=20) {
        //orange low
        VESTPDlbl.backgroundColor = [UIColor yellowColor];
    }
    if ([VESTPDlbl.text  floatValue] >=45) {
        //orange high
        VESTPDlbl.backgroundColor = [UIColor yellowColor];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    statusMessageLab.hidden = YES;
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

// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++
// to edit to suit VO2
// all below to edit - when done delete this line

-(void)calculateStats{
    statusMessageLab.hidden = YES;
    
    //statusMessageLab.text=@"Calculating\nStats\nPlease\nWait...";
    
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
    testerlbl.text      =   singleton.testerName;
    datelbl.text        =   singleton.testDate;
    timelbl.text        =   singleton.testTime;
    lablbl.text         =   singleton.labLocation;
    subWtlbl.text       =   singleton.subWt;
    subHtlbl.text       =   singleton.subHt;
    // templbl.text        =   singleton.labTemp;
    // pressurelbl.text    =   singleton.labPressure_mmHg;
    humiditylbl.text    =   singleton.labHumidity;
    samptimelbl.text    =   singleton.sampTime;
    FEO2lbl.text        =   singleton.feo2;
    FECO2lbl.text       =   singleton.feco2;
    corrFaclbl.text     =   singleton.corrFactor;
    labO2lbl.text       =   singleton.labO2;
    N2lbl.text          =   singleton.n2;
    labCO2lbl.text      =   singleton.labCO2;
    VEATPSlbl.text      =   singleton.veatps;
    
    VESTPDlbl.text      =   @"0.00";
    corrFaclbl.text     =   @"0.00";
    VO2lbl.text         =   @"0.00";
    VCO2lbl.text        =   @"0.00";
    VO2Kglbl.text       =   @"0.00";
    RERlbl.text         =   @"0.00";
    
    labTempC         = [templbl.text     floatValue];
    FECO2            = [FECO2lbl.text    floatValue];
    FEO2             = [FEO2lbl.text     floatValue];
    labPressure_mmHg = [pressurelbl.text floatValue];
    VEATPS           = [VEATPSlbl.text   floatValue];
    subWt            = [subWtlbl.text    floatValue];
    subHt            = [subHtlbl.text    floatValue];
    
    subBMI           = subWt / (subHt*subHt);
    
    sampTime         = [samptimelbl.text floatValue];
    labO2            = [labO2lbl.text    floatValue];
    labCO2           = [labCO2lbl.text   floatValue];
    N2               = [labCO2lbl.text   floatValue];
    labHumidity      = [humiditylbl.text floatValue];
    
    //pressure check
    
    if (singleton.ismmHg==YES) {
        
        labPressure_mmHg  = [singleton.labPressure_mmHg floatValue];
        pressurelbl.text  = [NSString stringWithFormat:@"%.1f",labPressure_mmHg];
        
    } else {
        
        labPressure_mBar  = [singleton.labPressure_mmHg floatValue];
        labPressure_mmHg  = 0.75218 * labPressure_mBar;
        pressurelbl.text  = [NSString stringWithFormat:@"%.1f",labPressure_mmHg];
        singleton.ismmHg  = YES;
        singleton.labPressure_mmHg = pressurelbl.text;
    }
    //temp check
    if (singleton.isDegC  == YES) {
        
        labTempC = [singleton.labTemp floatValue];
        templbl.text      = [NSString stringWithFormat:@"%.1f",labTempC];
        
    } else {
        labTempF          = [singleton.labTemp floatValue];
        labTempC          = 5 * (labTempF - 32) / 9;
        templbl.text      = [NSString stringWithFormat:@"%.1f",labTempC];
        singleton.isDegC  = YES;
        singleton.labTemp = templbl.text;
    }


    //totalDelay=0;

//do the calcs from here:
    //corrFactor
     //corrFactor = (273.0000/(273.0000+labTempC))*((labPressure_mmHg - ((1.0010 * labTempC) - 4.1900)) / 760.0000);
    //NSLog(@"Corr old = %f",corrFactor);
    
    //old// singleton.corrFactor = [NSString stringWithFormat:@"%.4f",corrFactor];
    
    /* correction factor from excel sheet
      (0.880645161290323) * (($E$5 - 47.08) / 760)
     */
    
    /* pre correction factor VeATPS
     ((B8/C8) * 60) * (310 / (273 + D8)) * (($E$5 - (EXP(20.8455 - (5270 / (273 + D8))))) / ($E$5 - 47.08))
     */
    corrFactor1 =  0.880645161290323 * ((labPressure_mmHg - 47.0800) / 760.0000);
    //NSLog(@"Corr pt 1 = %f",corrFactor1);
    
    VEBTPS = (310.0000 / (273.0000 + labTempC)) * ((labPressure_mmHg - (powf(2.71828182846, 20.8455 - (5270.0000 / (273.0000 + labTempC))))) / (labPressure_mmHg - 47.0800));
    
    Float64 precorr = ((VEATPS/sampTime) * 60.0000) * VEBTPS;
    //NSLog(@"VEBTPS vebtps = %f",VEBTPS);
    //NSLog(@"VESTPD = %f",precorr * corrFactor1);
    //NSLog(@"cor fact = %f",VEBTPS * corrFactor1);
    
    corrFactor = VEBTPS * corrFactor1;
    //now make the vebtps the right figure
    VEBTPS = VEBTPS * VEATPS;
    
    //old// singleton.corrFactor = [NSString stringWithFormat:@"%.4f",corrFactor];
    singleton.corrFactor = [NSString stringWithFormat:@"%.15f", corrFactor];
    
    //VESTPD=precorr*corrFactor;
    
    //lab o2 N2 calcs
    //N2 (if adjust formula, change same in calcViewController
    
    Float64 O2;
    
    N2   = 100.0000 - ([singleton.feo2 floatValue] + [singleton.feco2 floatValue]) ;
    singleton.n2 = [NSString stringWithFormat:@"%.2f", N2];
    
    O2   = 20.9300;
    
    
    /* // original code from GR //
     'calculate VEstpd
     VEstpd = (60 * (VEatps * (273 / (273 + TEMP)) * ((Pressure - ((1.001 * TEMP) - 4.19)) / 760))) / SAMPTIME
     VEstpd = Format(Val(VEstpd), "##00.00")
     txtVEstpd.Text = VEstpd
     
     'calculate VO2
     VO2 = 0.01 * (VEstpd * (((100 - (FEO2 + FECO2)) / 79.03) * 20.93) - (VEstpd * FEO2))
     VO2 = Format(Val(VO2), "##00.00")
     txtVO2.Text = VO2
     
     'calculate VCO2
     VCO2 = 0.01 * (VEstpd * FECO2)
     VCO2 = Format(Val(VCO2), "##00.00")
     txtVCO2.Text = VCO2
     
     'calculate VO2kg
     VO2kg = (VO2 * 1000) / Weight
     VO2kg = Format(VO2kg, "##00.00")
     txtVO2kg.Text = VO2kg
     
     'calculate RER
     RER = (VCO2 / VO2)
     RER = Format(RER, "##00.00")
     txtRER.Text = RER
     */
    //vestpd
    //v1//VEstpd = ( 60 * ( VEatps * ( 273      / (273      + TEMP))      * (( Pressure         - (( 1.001  * TEMP)      - 4.19))    / 760))) / SAMPTIME
    
    //v2//VESTPD = ( 60.0000 * ( VEATPS * ( 273.0000 / (273.0000 + labTempC )) * (( labPressure_mmHg - (( 1.0010 * labTempC ) - 4.1900 )) / 760.0000 ))) / sampTime;
    
    VESTPD = precorr*corrFactor1; //v3//
    
    singleton.vestpd = [NSString stringWithFormat:@"%.15f", VESTPD];
    
    //vo2
    //VO2    = 0.01   * (VEstpd * (((100 - (FEO2 + FECO2)) / 79.03) * 20.93) - (VEstpd * FEO2))
    //VO2    = VESTPD * ((N2 * 0.2650) -  FEO2) /100.000;
    //VO2    = 0.0100   * (VESTPD * (((100.0000 - (FEO2 + FECO2)) / 79.0300) * labO2) - (VESTPD * FEO2));
    
    VO2= (VESTPD * (labO2 / 100.0) * ((1.0 - ((FEO2 / 100.0) + (FECO2 / 100.0))) / (1.0 - ((labO2 / 100.0) + (labCO2 / 100))))) - (VESTPD * (FEO2 / 100.0));
    
    singleton.vo2    = [NSString stringWithFormat:@"%.15f", VO2];
    
    //vco2
    //VCO2   = 0.01 * (VEstpd * FECO2)
    //v2//VCO2   = VESTPD * ( FECO2 - 0.04 )/100;
    //VCO2   = VESTPD * ( FECO2 - 0.0400 )/100.0000; //question why 0.04 and not labco2?
    //VCO2   = VESTPD * ( FECO2 - labCO2 )/100.0000; //try?
    
    VCO2 = (VESTPD * (FECO2 / 100.0)) - (VESTPD * (labCO2 / 100.0) * ((1.0 - ((FEO2 / 100.0) + (FECO2 / 100.0))) / (1.0 - ((labO2 / 100.0) + (labCO2 / 100.0)))));
    
    //v3//VCO2   = 0.0100 * (VESTPD * FECO2);
    singleton.vco2   = [NSString stringWithFormat:@"%.15f", VCO2];
    
    //vo2kg
    //VO2kg = ( VO2 * 1000)       / Weight
    VO2Kg   = ( VO2 * 1000.0000 ) / subWt ;
    
    singleton.vo2kg     = [NSString stringWithFormat:@"%.15f", VO2Kg];
    singleton.vebtps    = [NSString stringWithFormat:@"%.15f", VEBTPS];
    
    //rer
    RER    = ( VCO2 / VO2 );
    singleton.rer    = [NSString stringWithFormat:@"%.15f", RER];
    
    subBMIlbl.text      =   [NSString stringWithFormat:@"%.1f", subBMI];
    VEATPSlbl.text      =   [NSString stringWithFormat:@"%.2f",[singleton.veatps floatValue]];
    VESTPDlbl.text      =   [NSString stringWithFormat:@"%.4f",[singleton.vestpd floatValue]];
    VEBTPSlbl.text      =   [NSString stringWithFormat:@"%.4f",[singleton.vebtps floatValue]];
    
    subBMIlbl.text      =  [NSString stringWithFormat:@"%.1f", subBMI];
    
    corrFaclbl.text     =   [NSString stringWithFormat:@"%.4f",[singleton.corrFactor floatValue]];
    VO2lbl.text         =   [NSString stringWithFormat:@"%.4f",[singleton.vo2 floatValue]];
    VCO2lbl.text        =   [NSString stringWithFormat:@"%.4f",[singleton.vco2 floatValue]];
    
    VO2Kglbl.text       =   [NSString stringWithFormat:@"%.4f",[singleton.vo2kg floatValue]];
    RERlbl.text         =   [NSString stringWithFormat:@"%.4f",[singleton.rer floatValue]];
    
    //energies for email
    energyExpend = ([singleton.vo2 floatValue]*15.88)+([singleton.vco2 floatValue] * 4.87);
    singleton.energyExpend=[NSString stringWithFormat:@"%.4f", energyExpend];
    
    //choug
    choug = ([singleton.vco2 floatValue] * singleton.cho412) - ([singleton.vo2 floatValue] * singleton.cho291);
    singleton.chug=[NSString stringWithFormat:@"%.4f", choug];
    
    choukj = (choug * 17.22);
    singleton.chukj=[NSString stringWithFormat:@"%.4f", choukj];
    
    //fatg
    fatug = ([singleton.vo2 floatValue] * singleton.fata)-([singleton.vco2 floatValue] * singleton.fatb);
    singleton.fatg=[NSString stringWithFormat:@"%.4f", fatug];
    
    fatukj = (fatug * 39.06);
    singleton.fatkj=[NSString stringWithFormat:@"%.4f", fatukj];
    
    //% fat %cho
    pfat = fatukj / (energyExpend / 100.0);
    singleton.pfat=[NSString stringWithFormat:@"%.4f", pfat];
    
    pcho = choukj / (energyExpend / 100.0);
    singleton.pcho=[NSString stringWithFormat:@"%.4f", pcho];
    
    //corrFaclbl.text     =   singleton.corrFactor;
    //VO2lbl.text         =   singleton.vo2;
    //VCO2lbl.text        =   singleton.vco2;
    N2lbl.text          =   singleton.n2;
    //VO2Kglbl.text       =   singleton.vo2kg;
    //RERlbl.text         =   singleton.rer;
    
    //Format for file and email outputs
    //put titles and basic params up first
    [singleton.cardReactionTimeResult addObject:@"MMU Cheshire, Exercise and Sport Science, VO2 Application Results"];
    singleton.counter = singleton.counter+1;
    //mmu copyright message 2014 JAH
    [singleton.cardReactionTimeResult addObject:@"(c) 2015 MMU written by Jonathan A. Howell for ESS VO2 App"];
    singleton.counter = singleton.counter+1;
    //mmu version no
    [singleton.cardReactionTimeResult addObject:[NSString stringWithFormat:@"%@",singleton.versionNumber]];
    //[singleton.cardReactionTimeResult addObject:singleton.versionNumber];
    singleton.counter = singleton.counter+1;
    //blank line
    [singleton.cardReactionTimeResult addObject:@" "];
    singleton.counter = singleton.counter+1;
    
    //title line - results one row per data entry
    if (energyButtonVisible==YES||[testerlbl.text isEqual:@"Energy"]) {
        [singleton.cardReactionTimeResult addObject:@"Gas Exchange and Metabolism Results"];
    }else{
        [singleton.cardReactionTimeResult addObject:@"Gas Exchange Results"];
    }
    singleton.counter = singleton.counter+1;
    
    //add enrgies if requested
    if (energyButtonVisible==YES||[testerlbl.text isEqual:@"Energy"]) {
        [singleton.cardReactionTimeResult addObject:@"TestNo., Tester, Subject, Test Date, Test Time, Lab Loc'n, Lab Temp 'C, Lab Press mmHg, Lab Hum %, Sub Ht, Sub Wt, Sub BMI, Samp Time s,FEO2 L, FECO2 L, Lab O2 %, N2 %, VEATPS, VEBTPS, VESTPD, Corr Fac, VO2, VCO2, VO2kg, RER, EExpend, CHOg, CHOkj,FATg,FATkj,CHO%,%Fat"];
    }else{
        [singleton.cardReactionTimeResult addObject:@"TestNo., Tester, Subject, Test Date, Test Time, Lab Loc'n, Lab Temp 'C, Lab Press mmHg, Lab Hum %, Sub Ht, Sub Wt, Sub BMI, Samp Time s,FEO2 L, FECO2 L, Lab O2 %, N2 %, VEATPS, VEBTPS, VESTPD, Corr Fac, VO2, VCO2, VO2kg, RER"];
    }
    singleton.counter = singleton.counter+1;
    // +++++++++++++++++++++++++++
    //loop if rows of results
    //results, one per line upto number of cards
    //for (int y=1; y<singleton.counter+1; y++) {
        //uncomment when formatted
    
        if (energyButtonVisible==YES||[testerlbl.text isEqual:@"Energy"]) {
        myNumbStr = [NSString stringWithFormat:@"%i,%@,%@,%@,%@,%@,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f" ,
                     counter,
                     testerlbl.text,
                     subjectlbl.text,
                     datelbl.text,
                     timelbl.text,
                     lablbl.text,
                     labTempC,
                     labPressure_mmHg,
                     labHumidity,
                     subHt,
                     subWt,
                     subBMI,
                     sampTime,
                     FEO2,
                     FECO2,
                     labO2,
                     N2,
                     VEATPS,
                     VEBTPS,
                     VESTPD,
                     corrFactor,
                     VO2,
                     VCO2,
                     VO2Kg,
                     RER,
                     energyExpend,
                     choug,
                     choukj,
                     fatug,
                     fatukj,
                     pcho,
                     pfat
                     ];
        }else{
            myNumbStr = [NSString stringWithFormat:@"%i,%@,%@,%@,%@,%@,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f,%2.4f" ,
                         counter,
                         testerlbl.text,
                         subjectlbl.text,
                         datelbl.text,
                         timelbl.text,
                         lablbl.text,
                         labTempC,
                         labPressure_mmHg,
                         labHumidity,
                         subHt,
                         subWt,
                         subBMI,
                         sampTime,
                         FEO2,
                         FECO2,
                         labO2,
                         N2,
                         VEATPS,
                         VEBTPS,
                         VESTPD,
                         corrFactor,
                         VO2,
                         VCO2,
                         VO2Kg,
                         RER
                         ];
            }
    
        [singleton.cardReactionTimeResult addObject: myNumbStr];
    singleton.counter = singleton.counter+1;
    //}
    // +++++++++++++++++++++++++++
    
    //blank line
    [singleton.cardReactionTimeResult addObject:@" " ];
    singleton.counter = singleton.counter+1;
    
    //end of data message
    [singleton.cardReactionTimeResult addObject:@"End of results table. " ];
    singleton.counter = singleton.counter+1;
    //blank line
    [singleton.cardReactionTimeResult addObject:@" " ];
    singleton.counter = singleton.counter+1;
    //mmu copyright message
    [singleton.cardReactionTimeResult addObject:@"MMU (c) 2015 VO2 App Jonathan A. Howell SAS Technical Services. " ];
    singleton.counter = singleton.counter+1;
    //version number
    [singleton.cardReactionTimeResult addObject: singleton.versionNumber ];
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
    
    //statusMessageLab.text=@"Waiting\nfor\nNext\nInstruction.";
}
// all above to edit - when done delete this line
// +++++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++++

//mail from button press
-(IBAction)sendEmail:(id)sender {
    statusMessageLab.hidden = NO;
    statusMessageLab.text=@"E-Mail\nResults\nLoading...";
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    [mailComposer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail]){
        [mailComposer setToRecipients:[NSArray arrayWithObjects:singleton.email ,Nil]];
        [mailComposer setSubject:@"Results from VO2 App"];
        //[mailComposer setMessageBody:@"Dear VO2 App User: " isHTML:YES];
        
        [mailComposer setMessageBody: singleton.resultStrings isHTML:NO];
        [mailComposer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];

        [self presentViewController:mailComposer animated:YES completion:^{/*email*/}];

    }else{
        
    } //end of if else to check if mail is able to be sent, send message if not
    //statusMessageLab.text=@"Select\nNext\nTask";
} // end of mail function

//set out mail controller warnings screen
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *) error {
    statusMessageLab.hidden = NO;
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
    //statusMessageLab.text=@"Select\nNext\nTask";
}

//if file name is passed, use...
//- (IBAction)showEmail:(NSString*)file {

- (IBAction)showEmail:(id)sender {
    statusMessageLab.hidden = NO;
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    NSString *emailTitle = [NSString stringWithFormat:@"VO2 App Data for: %@",singleton.oldSubjectName];
    NSString *messageBody = [NSString stringWithFormat:@"The test data for the subject:%@ taken at the date: %@ and time: %@, is attached as a text/csv file.  \n\nThe file is comma separated variable, .csv extension.  \n\nThe data can be read by MS-Excel, then analysed by your own functions. \n\nSent by VO2 App.",singleton.oldSubjectName,singleton.testDate,singleton.testTime];
    //old for testing// NSArray  *toRecipents = [NSArray arrayWithObject:@"j.a.howell@mmu.ac.uk"];
    
    NSArray  *toRecipents = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@", singleton.email,Nil]];

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
