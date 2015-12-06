//
//  subjectViewController.h
//  VO2
//
//  Created by Jon Howell on 22/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  6/12/15
//

#import <UIKit/UIKit.h>

@interface subjectViewController : UIViewController <UITextFieldDelegate>
{
    UITextField   * subWtTxt;
    UITextField   * subHtTxt;
    UITextField   * subjectNameTxt;
    UITextField   * testerNameTxt;
    UITextField   * emailTxt;
    UITextField   * startDateTxt;
    UITextField   * testDateTxt;
    BOOL keyboardAnim;
    float keyboardAnimSpeed;
    float keyboardAnimDelay;
}
//subject
@property (nonatomic, strong) IBOutlet UITextField * subWtTxt;
@property (nonatomic, strong) IBOutlet UITextField * subHtTxt;
@property (nonatomic, strong) IBOutlet UITextField * subjectNameTxt;
@property (nonatomic, retain) IBOutlet UITextField * testerNameTxt;
@property (nonatomic, retain) IBOutlet UITextField * emailTxt;
@property (nonatomic, strong) IBOutlet UITextField * startDateTxt;
@property (nonatomic, strong) IBOutlet UITextField * testDateTxt;
//@property (nonatomic) BOOL                              keyboardAnim;
//@property (nonatomic) float                             keyboardAnimSpeed;
//@property (nonatomic) float                             keyboardAnimDelay;

// for calculations and functions
-(IBAction)setDateNow:(id)sender;
-(IBAction)setTimeNow:(id)sender;

@end

