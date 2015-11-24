//
//  subjectViewController.h
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subjectViewController : UIViewController <UITextFieldDelegate>
{
    UITextField   * subWtTxt;
    UITextField   * subHtTxt;
    UITextField   * subjectNameTxt;
    UITextField   * testerNameTxt;
    UITextField   * startDateTxt;
    UITextField   * testDateTxt;
}
//subject
@property (nonatomic, strong) IBOutlet UITextField * subWtTxt;
@property (nonatomic, strong) IBOutlet UITextField * subHtTxt;
@property (nonatomic, strong) IBOutlet UITextField * subjectNameTxt;
@property (nonatomic, strong) IBOutlet UITextField * testerNameTxt;
@property (nonatomic, strong) IBOutlet UITextField * startDateTxt;
@property (nonatomic, strong) IBOutlet UITextField * testDateTxt;

// for calculations and functions
-(IBAction)setDateNow:(id)sender;
-(IBAction)setTimeNow:(id)sender;

@end

