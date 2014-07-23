//
//  calcsViewController.h
//  VO2
//
//  Created by Jon Howell on 23/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calcsViewController : UIViewController{
    UILabel * line1;
    UILabel * line2;
    UILabel * line3;
    UILabel * line4;
    UILabel * line5;
}
@property (nonatomic, strong) IBOutlet UILabel * line1;
@property (nonatomic, strong) IBOutlet UILabel * line2;
@property (nonatomic, strong) IBOutlet UILabel * line3;
@property (nonatomic, strong) IBOutlet UILabel * line4;
@property (nonatomic, strong) IBOutlet UILabel * line5;
@end
