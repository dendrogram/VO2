//
//  resultsView.m
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import "resultsView.h"
#import "mySingleton.h" //for global variables
#import "math.h"

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
        VEBTPSlbl,
        VISTPDlbl,
        VEATPSlbl,
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
    mySingleton     * singleton = [mySingleton sharedSingleton];

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
    NSDateFormatter *dateFormat     = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString            = [dateFormat stringFromDate:today];
    datelbl.text=dateString;
}

-(void)setTimeNow:(id)sender{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString            = [dateFormatter stringFromDate: currentTime];
    timelbl.text=timeString;
}

-(void)refreshSettings{
    //read settings file on device
    NSUserDefaults * defaults        = [NSUserDefaults standardUserDefaults];
    
    //set up globals
    mySingleton * singleton          = [mySingleton sharedSingleton];
    
    //settingfs and put in globals
    singleton.email                 = [defaults objectForKey:kEmail];
    singleton.testerName            = [defaults objectForKey:kTester];
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

    labTempC         = singleton.labTemp;
    FECO2            = singleton.feco2;
    FEO2             = singleton.feo2;
    labPressure_mmHg = singleton.labPressure_mmHg;
    VEATPS           = singleton.veatps;
    VEBTPS           = singleton.vebtps;
    VISTPD           = singleton.VISTPD;
    subWt            = singleton.subWt;
    subHt            = singleton.subHt;
    sampTime         = singleton.sampTime;
    labO2            = singleton.labO2;
    labCO2           = singleton.labCO2;
    labHumidity      = singleton.labHumidity;

//do the calcs from here:
    
    //lab o2 N2 calcs
    //N2 (if adjust formula, cahnge same in calcViewController
    
    long double N2;

    long double O2;
    
    N2   = 100.00000000f - (labCO2 + labO2) ;

    O2   = labO2;

    //decimal number arithmetic - examples
    /*
    NSDecimalNumber *price1 = [NSDecimalNumber decimalNumberWithString:@"1.23"];
    NSDecimalNumber *price2 = [NSDecimalNumber decimalNumberWithString:@"1.45"];
    NSDecimalNumber *coupon = [NSDecimalNumber decimalNumberWithString:@"6.00"];
    NSDecimalNumber *discount = [NSDecimalNumber decimalNumberWithString:@"5.00"];
    NSDecimalNumber *numProducts = [NSDecimalNumber decimalNumberWithString:@"23.00"];

    NSDecimalNumber *subtotal = [price1 decimalNumberByAdding:price2];
    NSDecimalNumber *afterCoupon = [subtotal decimalNumberBySubtracting:coupon];
    NSDecimalNumber *afterDiscount = [afterCoupon decimalNumberByMultiplyingBy:discount];
    NSDecimalNumber *average = [afterDiscount decimalNumberByDividingBy:numProducts];
    NSDecimalNumber *averageSquared = [average decimalNumberByRaisingToPower:2];
*/

//calc VEATPS first using decimal numbers for accuracy
    /*
    NSDecimalNumber *v60        = [NSDecimalNumber decimalNumberWithString:@"60.000"];
    NSDecimalNumber *veatps     = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",VEATPS]];
    NSDecimalNumber *samptime   = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", sampTime]];
    NSDecimalNumber *pt1        = [v60 decimalNumberByMultiplyingBy:veatps];
    NSDecimalNumber *veatps1    = [pt1 decimalNumberByDividingBy:samptime];

    NSDecimalNumber *v310       = [NSDecimalNumber decimalNumberWithString:@"310.000"];
    NSDecimalNumber *v273       = [NSDecimalNumber decimalNumberWithString:@"273.000"];
    NSDecimalNumber *v4708      = [NSDecimalNumber decimalNumberWithString:@"47.080"];
    NSDecimalNumber *v5270      = [NSDecimalNumber decimalNumberWithString:@"5270.000"];
    NSDecimalNumber *v208455    = [NSDecimalNumber decimalNumberWithString:@"20.8455"];

    NSDecimalNumber *labtempc   = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", labTempC]];
    NSDecimalNumber *labpressuremmhg = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", labPressure_mmHg]];

    NSDecimalNumber *t2         = [v273 decimalNumberByAdding:labtempc];
    NSDecimalNumber *t1         = [v310 decimalNumberByDividingBy:t2];

    NSDecimalNumber *p1a        = [v5270 decimalNumberByDividingBy:t2];
    NSDecimalNumber *p1b        = [v208455 decimalNumberBySubtracting:p1a];

    //NSDecimalNumber *p1c        = [e1  decimalNumberByRaisingToPower:p1b];

    //convert to StringHandle
    NSString *p1c =[p1b stringValue];

    //do maths
    double p1e = exp([p1c doubleValue]);
    //convert back to decimalnumber
    NSString *p1es = [NSString stringWithFormat:@"%f",p1e];
    NSDecimalNumber *p1f    = [NSDecimalNumber decimalNumberWithString:p1es];


    NSDecimalNumber *p1d        = [labpressuremmhg decimalNumberBySubtracting:p1f];

    NSDecimalNumber *p2         = [labpressuremmhg decimalNumberBySubtracting:v4708];

    NSDecimalNumber *p3         = [p1d decimalNumberByDividingBy:p2];
    NSDecimalNumber *vebtps1    = [t1 decimalNumberByMultiplyingBy:veatps1];
    NSDecimalNumber *vebtps     = [vebtps1 decimalNumberByMultiplyingBy:p3];
*/
    //original calcs
    ////long double VEATPS1 = 60.000000f * (VEATPS / sampTime);// ok
    ////long double T1 = 310.000000f / (273.000000f + labTempC);//ok
    ////long double P1 = labPressure_mmHg - (exp(20.845500f - (5270.000000f / (273.000000f + labTempC))));
    ////long double P2 = labPressure_mmHg - 47.080000f;
    ////long double P3 = P1 / P2;
    ////VEBTPS = VEATPS1 * T1 * P3;

    VEBTPS=((VEATPS/sampTime) * 60.00000000f) * (310.00000000f / (273.00000000f + labTempC)) * ((labPressure_mmHg - (expl(20.84550000f - (5270.00000000f / (273.00000000f + labTempC))))) / (labPressure_mmHg - 47.08000000f));

    //decimal value to string to double
    //NSString *ans     = [NSString stringWithFormat:@"%Lf",VEBTPS];
    //VEBTPS = [ans doubleValue];

    corrFactor           = VEBTPS;
    singleton.vebtps     = VEBTPS;
    singleton.corrFactor = VEBTPS;
    VEBTPSlbl.text   = [NSString stringWithFormat:@"%.8Lf",VEBTPS];
    
    //this line ok
    VESTPD = VEBTPS * (0.8806451612903230f * ((labPressure_mmHg - 47.08000000f) / 760.00000000f));
    //do with decimals
    /*
    NSDecimalNumber *v08806        = [NSDecimalNumber decimalNumberWithString:@"0.880645161290323"];
    NSDecimalNumber *v760          = [NSDecimalNumber decimalNumberWithString:@"760.0000"];
    NSDecimalNumber *b1            = [p2 decimalNumberByDividingBy:v760];
    NSDecimalNumber *vestpd        = [b1 decimalNumberByMultiplyingBy:v08806];
    //decimal value to string to double
    NSString *ans1     = [NSString stringWithFormat:@"%@",vestpd];
    VESTPD = [ans1 doubleValue];
    singleton.vestpd = VESTPD;

    //decimals for VIstpd
    NSDecimalNumber *fe02           = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", FEO2]];
    NSDecimalNumber *fec02          = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", FECO2]];
    NSDecimalNumber *labo2          = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", labO2]];
    NSDecimalNumber *labco2         = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", labCO2]];
    NSDecimalNumber *v100           = [NSDecimalNumber decimalNumberWithString:@"100.0000"];
    NSDecimalNumber *v1a            = [fe02 decimalNumberByAdding:fec02];
    NSDecimalNumber *v2a            = [labo2 decimalNumberByAdding:labco2];
    NSDecimalNumber *v1             = [v100 decimalNumberBySubtracting:v1a];
    NSDecimalNumber *v2             = [v100 decimalNumberBySubtracting:v2a];
    NSDecimalNumber *v3             = [v1 decimalNumberByDividingBy:v2];
    NSDecimalNumber *vistpd         = [v3 decimalNumberByMultiplyingBy:vestpd];
    //decimal value to string to double
    NSString *ans3     = [NSString stringWithFormat:@"%@",vistpd];
*/
    // original calc of vistpd
    long double V1        = (100.00000000f - (FEO2 + FECO2));
    long double V2        = (100.00000000f - (labO2 + labCO2));
    VISTPD    = VESTPD * (V1 / V2);
    //VISTPD                  = [ans3 doubleValue];
    singleton.VISTPD        = VISTPD;

    //


    VO2 = (VESTPD * (labO2 / 100.00000000f) * ((100.00000000f - ((FEO2 / 100.00000000f) + (FECO2 / 100.00000000f))) / (100.00000000f - ((labCO2 / 100.00000000f + (labO2 / 100.00000000f)))))) - (VESTPD * (FEO2 / 100.00000000f));
    //VO2 = (VESTPD * (f2) * ((100 - ((f1) + (f4))) / (100 - ((f5 + (f2)))))) - (VESTPD * (f1));

    //
/*

    //f1  = feo2 / 100
        NSDecimalNumber *f1         = [fe02 decimalNumberByDividingBy:v100];
    //f2  = labo2 / 100
        NSDecimalNumber *f2         = [labo2 decimalNumberByDividingBy:v100];
    //f4  = feco2 / 100
        NSDecimalNumber *f4         = [fec02 decimalNumberByDividingBy:v100];
    //f5  = labco2 / 100
        NSDecimalNumber *f5         = [labco2 decimalNumberByDividingBy:v100];

    //g1=f5+f2
        NSDecimalNumber *g1         = [f5 decimalNumberByAdding:f2];
    //g3=100-g1
        NSDecimalNumber *g3         = [v100 decimalNumberBySubtracting:g1];
    //g2=f1+f4
        NSDecimalNumber *g2         = [f1 decimalNumberByAdding:f4];
    //g4=100-g2
        NSDecimalNumber *g4         = [v100 decimalNumberBySubtracting:g2];
    //g5=g3/g4
        NSDecimalNumber *g5         = [g3 decimalNumberByDividingBy:g4];
    //g6=vestpd *f2
        NSDecimalNumber *g6         = [vestpd decimalNumberByMultiplyingBy:f2];
    //g7=g6*g5
        NSDecimalNumber *g7         = [g6 decimalNumberByMultiplyingBy:g5];
    //g0=vestpd*f1
        NSDecimalNumber *g0         = [vestpd decimalNumberByMultiplyingBy:f1];
    //vo2=g7-g0
    //NSDecimalNumber *vo2        = [g7 decimalNumberBySubtracting:g0];

    //NSString *vo2x          = [NSString stringWithFormat:@"%@",vo2];
    //VO2                     = [vo2x doubleValue];
 */
    singleton.vo2           = VO2;

    //


    VCO2 = (VESTPD * (FECO2 / 100.00000000f)) - (VESTPD * (labCO2 / 100.00000000f) * ((100.00000000f - ((FEO2 / 100.00000000f) + (FECO2 / 100.00000000f))) / (100.00000000f - ((labO2 / 100.00000000f) + (labCO2 / 100.00000000f)))));

    //NSString *vco2x         = [NSString stringWithFormat:@"%@",vco2];
    //VCO2                    = [vco2x doubleValue];
    singleton.vco2          = VCO2;

    //
    /*
    NSDecimalNumber *subwt  = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", subWt]];
    NSDecimalNumber *v1000  = [NSDecimalNumber decimalNumberWithString:@"1000.0000"];
    NSDecimalNumber *x1     = [v1000 decimalNumberByMultiplyingBy:vo2];
    NSDecimalNumber *vo2kg  = [x1 decimalNumberByDividingBy:subwt];
*/
    VO2Kg                   = ( VO2 * 1000.00000000f ) / subWt ;
    //NSString *vo2kg1        = [NSString stringWithFormat:@"%@",vo2kg];
    //VO2Kg                   = [vo2kg1 doubleValue];
    singleton.vo2kg         = VO2Kg;

    //
    //NSDecimalNumber *rer    = [vo2 decimalNumberByDividingBy:vo2];

    RER    = ( VCO2 / VO2 );
    //NSString *rer1          = [NSString stringWithFormat:@"%@",rer];
    //RER                     = [rer1 doubleValue];
    singleton.rer           = RER;
    
    //************** energy
    //**
    //** Calc other energy values and results here for mySingleton --> Energy page
    //**

    energyExpenKJ       = (15.880000f * VO2) + (4.870000f * VCO2);
    energyExpenKCal     = energyExpenKJ * 0.239005736f;

    CHOUsage_g_min      = (4.120000f * VCO2) - (2.910000f * VO2);
    CHOUsage_kj_min     = CHOUsage_g_min * 17.220000f;
    CHOUsage_kCal_min   = CHOUsage_kj_min * 0.2390057360f;

    fatUsage_g_min      = (1.689000f * VO2) - (1.68900f * VCO2);
    fatUsage_kj_min     = fatUsage_g_min * 39.060000f;
    fatUsage_kCal_min   = fatUsage_kj_min * 0.2390057360f;

    percentFat          = fatUsage_kj_min / (energyExpenKJ / 100.000000f);
    percentCHO          = CHOUsage_kj_min / (energyExpenKJ / 100.000000f);

    BMI                 = subWt / (subHt * subHt);
    //save the energy results to mySingleton

    singleton.BMI               = BMI;
    singleton.energyExpenKJ     = energyExpenKJ;
    singleton.energyExpenKCal   = energyExpenKCal;
    singleton.CHOUsage_g_min    = CHOUsage_g_min;
    singleton.CHOUsage_kj_min   = CHOUsage_kj_min;
    singleton.CHOUsage_kCal_min = CHOUsage_kCal_min;
    singleton.fatUsage_g_min    = fatUsage_g_min;
    singleton.fatUsage_kj_min   = fatUsage_kj_min;
    singleton.fatUsage_kCal_min = fatUsage_kCal_min;
    singleton.percentFat        = percentFat;
    singleton.percentCHO        = percentCHO;
    //************** energy
    
    VEATPSlbl.text      =   [NSString stringWithFormat:@"%.8Lf", singleton.veatps];
    VESTPDlbl.text      =   [NSString stringWithFormat:@"%.8Lf", singleton.vestpd];
    VEBTPSlbl.text      =   [NSString stringWithFormat:@"%.8Lf", singleton.vebtps];
    VISTPDlbl.text      =   [NSString stringWithFormat:@"%.8Lf", singleton.VISTPD];
    VO2lbl.text         =   [NSString stringWithFormat:@"%.8Lf", singleton.vo2];
    VCO2lbl.text        =   [NSString stringWithFormat:@"%.8Lf", singleton.vco2];
    VO2Kglbl.text       =   [NSString stringWithFormat:@"%.8Lf", singleton.vo2kg];
    RERlbl.text         =   [NSString stringWithFormat:@"%.8Lf", singleton.rer];
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
    [singleton.cardReactionTimeResult addObject:@"."];
    singleton.counter = singleton.counter+1;
    //title line - results one row per data entry
    [singleton.cardReactionTimeResult addObject:@"TestNo., Tester, Subject, Test Date, Test Time, Lab Loc'n, Lab Temp 'C, Lab Press mmHg, Lab Hum %, Sub Ht, Sub Wt, Samp Time s,FEO2 L, FECO2 L, Lab O2 %, VEATPS, VEBTPS, VESTPD, VISTPD, VO2, VCO2, VO2kg, RER"];
    singleton.counter = singleton.counter+1;
    // +++++++++++++++++++++++++++
    //loop if rows of results
    //results, one per line upto number of rows
    //for (int y=1; y<singleton.counter+1; y++) {
        //uncomment when formatted
    
        myNumbStr = [NSString stringWithFormat:@"%i,%@,%@,%@,%@,%@,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf,%.2Lf" ,
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
                     VEBTPS,
                     VESTPD,
                     VISTPD,
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
    [singleton.cardReactionTimeResult addObject:@"." ];
    singleton.counter = singleton.counter+1;
    
    //end of data message
    [singleton.cardReactionTimeResult addObject:@"End of test data. " ];
    singleton.counter = singleton.counter+1;
    //blank line
    [singleton.cardReactionTimeResult addObject:@"." ];
    singleton.counter = singleton.counter+1;
    //mmu copyright message
    [singleton.cardReactionTimeResult addObject:@"MMU (c) 2014 VO2 App Jonathan A. Howell SAS Technical Services. " ];
    singleton.counter = singleton.counter+1;
    //blank line
    [singleton.cardReactionTimeResult addObject:@"."];
    singleton.counter = singleton.counter+1;
    [singleton.cardReactionTimeResult addObject:@".."];
    singleton.counter = singleton.counter+1;
    [singleton.cardReactionTimeResult addObject:@"..."];
    singleton.counter = singleton.counter+1;

    //examples for future
    
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
    int i=0;
    //for(i=0; i< (singleton.counter); i++)
        i=0;// temporary force value zero
    //{
        element = [singleton.cardReactionTimeResult objectAtIndex: i];
        [printString appendString:[NSString stringWithFormat:@"\n%@", element]];
    //}
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

    // P              resent mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}


@end
