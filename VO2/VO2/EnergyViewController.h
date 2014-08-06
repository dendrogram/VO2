//
//  EnergyViewController.h
//  VO2
//
//  Created by Jon Howell on 06/08/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface EnergyViewController: UIViewController
{
    //text views for text display screens
 
    //only outputs to screen, all calculated in results and sent to mySingleton
    UILabel * date;
    UILabel * time;
    UILabel * subject;
    UILabel * height;
    UILabel * mass;
    UILabel * bmi;
    UILabel * expkj;
    UILabel * expcal;
    UILabel * chog;
    UILabel * chokj;
    UILabel * chocal;
    UILabel * fatg;
    UILabel * fatkj;
    UILabel * fatcal;
    UILabel * perfat;
    UILabel * percho;
}

//var label outlets
@property (nonatomic, strong) IBOutlet UILabel * date;
@property (nonatomic, strong) IBOutlet UILabel * time;
@property (nonatomic, strong) IBOutlet UILabel * subject;
@property (nonatomic, strong) IBOutlet UILabel * height;
@property (nonatomic, strong) IBOutlet UILabel * mass;
@property (nonatomic, strong) IBOutlet UILabel * bmi;
@property (nonatomic, strong) IBOutlet UILabel * expkj;
@property (nonatomic, strong) IBOutlet UILabel * expcal;
@property (nonatomic, strong) IBOutlet UILabel * chog;
@property (nonatomic, strong) IBOutlet UILabel * chokj;
@property (nonatomic, strong) IBOutlet UILabel * chocal;
@property (nonatomic, strong) IBOutlet UILabel * fatg;
@property (nonatomic, strong) IBOutlet UILabel * fatkj;
@property (nonatomic, strong) IBOutlet UILabel * fatcal;
@property (nonatomic, strong) IBOutlet UILabel * perfat;
@property (nonatomic, strong) IBOutlet UILabel * percho;

@end
