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
    IBOutlet UILabel     * statusMessageLab;
    //text views for text displays ie results or help screens
 
    //only outputs to screen, all calculated in results and sent to mySingleton
    //add one per field
    UILabel * VESTPDlbl;

}

//var label outlets
//add one per field
@property (nonatomic, strong) IBOutlet UILabel * VESTPDlbl;


@end
