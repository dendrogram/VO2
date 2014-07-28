//
//  emailViewController.h
//  VO2
//
//  Created by Jon Howell on 24/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface emailViewController : UIViewController
{
    IBOutlet UITextView * resultsView;
    IBOutlet UITextView * resultsViewBorder;
}
@property (nonatomic, strong) IBOutlet UITextView * resultsView;

@end
