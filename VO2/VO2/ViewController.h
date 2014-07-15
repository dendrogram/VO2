//
//  ViewController.h
//  VO2
//
//  Created by Jon Howell on 14/07/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate, UITextFieldDelegate>
{
    NSDate        *startDate;
    
    NSFileManager *fileMgr;
    NSString      *homeDir;
    NSString      *filename;
    NSString      *filepath;
}

//file ops stuff
@property(nonatomic,retain) NSFileManager *fileMgr;
@property(nonatomic,retain) NSString *homeDir;
@property(nonatomic,retain) NSString *filename;
@property(nonatomic,retain) NSString *filepath;

-(NSString *) GetDocumentDirectory;
-(NSString *) setFilename;
-(void) WriteToStringFile:(NSMutableString *)textToWrite;

@property (nonatomic, copy) NSDate *startDate;

//email stuff
@property (nonatomic, strong) IBOutlet UITextField *subjectNameTxt;

// button press to send the mail
-(IBAction)sendEmail:(id)sender;

@end
