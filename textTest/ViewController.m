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

@interface ViewController () <MFMailComposeViewControllerDelegate>
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
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
        
        [composer setMailComposeDelegate:self];
        [composer setSubject:@"HEY"];
        [composer setMessageBody:self.textView.text isHTML:YES];
        
        [self presentViewController:composer animated:YES completion:NULL];
    }
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
