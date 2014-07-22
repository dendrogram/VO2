//
//  resultsView.h
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface resultsView : UIViewController <MFMailComposeViewControllerDelegate>
{
    
}

@property (nonatomic, strong) IBOutlet UILabel * VESTPDlbl;
@property (nonatomic, strong) IBOutlet UILabel * VEATPSlbl;
@property (nonatomic, strong) IBOutlet UILabel * RERlbl;
@property (nonatomic, strong) IBOutlet UILabel * VO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * VCO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * datelbl;
@property (nonatomic, strong) IBOutlet UILabel * timelbl;
@property (nonatomic, strong) IBOutlet UILabel * lablbl;
@property (nonatomic, strong) IBOutlet UILabel * testerlbl;
@property (nonatomic, strong) IBOutlet UILabel * subjectlbl;
@property (nonatomic, strong) IBOutlet UILabel * templbl;
@property (nonatomic, strong) IBOutlet UILabel * pressurelbl;
@property (nonatomic, strong) IBOutlet UILabel * humiditylbl;
@property (nonatomic, strong) IBOutlet UILabel * samptimelbl;
@property (nonatomic, strong) IBOutlet UILabel * VO2Kglbl;
@property (nonatomic, strong) IBOutlet UILabel * subHtlbl;
@property (nonatomic, strong) IBOutlet UILabel * subWtlbl;
@property (nonatomic, strong) IBOutlet UILabel * corrFaclbl;
@property (nonatomic, strong) IBOutlet UILabel * FEO2bl;
@property (nonatomic, strong) IBOutlet UILabel * FECO2lbl;

// button press to send the mail
-(IBAction)sendEmail:(id)sender;

@end