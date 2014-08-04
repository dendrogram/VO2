//
//  subjectViewController.h
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTester @"testerName"

@interface subjectViewController : UIViewController <UITextFieldDelegate>
{
    UITextField   * subWtTxt;
    UITextField   * subHtTxt;
    UITextField   * subjectNameTxt;
    UITextField   * startDateTxt;
    UITextField   * testDateTxt;
    UILabel       * testerNamelbl;
    UILabel       * testerEmaillbl;
}

//subject
@property (nonatomic, strong) IBOutlet UITextField * subWtTxt;
@property (nonatomic, strong) IBOutlet UITextField * subHtTxt;
@property (nonatomic, strong) IBOutlet UITextField * subjectNameTxt;
@property (nonatomic, strong) IBOutlet UITextField * startDateTxt;
@property (nonatomic, strong) IBOutlet UITextField * testDateTxt;
@property (nonatomic, strong) IBOutlet UILabel     * testerNamelbl;
@property (nonatomic, strong) IBOutlet UILabel     * testerEmaillbl;

// for calculations and functions
-(IBAction)setDateNow:(id)sender;
-(IBAction)setTimeNow:(id)sender;
-(IBAction)setEmailTester:(id)sender;
-(IBAction)returnToStepOne:(UIStoryboardSegue *)segue;
@end

