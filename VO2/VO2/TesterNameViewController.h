//
//  TesterNameViewController.h
//  VO2
//
//  Created by Jon Howell on 04/08/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kEmail  @"emailAddress"
#define kTester @"testerName"

@interface TesterNameViewController : UIViewController <UITextFieldDelegate>
{
        UITextField * testerNametxt;
        UITextField * testerEmailtxt;
}
//subject

@property (nonatomic, strong) IBOutlet    UITextField  * testerNametxt;
@property (nonatomic, strong) IBOutlet    UITextField  * testerEmailtxt;

// for calculations and functions
//

@end
