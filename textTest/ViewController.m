//
//  ViewController.m
//  textTest
//
//  Created by Lacock, Ty on 10/18/13.
//  Copyright (c) 2013 TWL. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController ()
@property UIPasteboard *pasteboard;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [self.textView becomeFirstResponder];
    [super viewDidLoad];
    
    self.pasteboard = [UIPasteboard generalPasteboard];
    if (self.pasteboard) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Paste?"
                                                          message:@"Would you like to paste your text?"
                                                         delegate:self
                                                cancelButtonTitle:@"Yes"
                                                otherButtonTitles:@"No", nil];
        [message show];
        
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Yes"]) {
        self.textView.text = self.pasteboard.string;
    }
}

- (IBAction)sendMail:(id)sender
{
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    
    [composer setMailComposeDelegate:self];
    [composer setSubject:@"HEY"];
    [composer setMessageBody:self.textView.text isHTML:YES];
    
    [self presentModalViewController:composer animated:YES];
    

}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
