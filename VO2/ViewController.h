//
//  ViewController.h
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  Updated and improved 24/11/15
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

{
    IBOutlet UILabel     * versionNumberLab;
    UITabBarController   * tabBar;
}

@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UITabBarController * tabBar;

@end