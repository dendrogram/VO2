//
//  calcsViewController.h
//  VO2
//
//  Created by Jon Howell on 23/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calcsViewController : UIViewController{
    UILabel * FEO2lbl;
    UILabel * FECO2lbl;
    UILabel * labO2lbl;
    UILabel * n2lbl;
    UILabel * hypoxic02;
}
@property (nonatomic, strong) IBOutlet UILabel * FEO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * FECO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * labO2lbl;
@property (nonatomic, strong) IBOutlet UILabel * n2lbl;
@property (nonatomic, strong) IBOutlet UILabel * hypoxic02;
@end
