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

- (IBAction)setContact:(id)sender;

@property UIPasteboard *pasteboard;
@property (nonatomic)  MFMailComposeViewController *composer;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [self.textView becomeFirstResponder];
    [super viewDidLoad];
    
    [self newMailSetup];
    [self pasteSetup];
}

- (void)pasteSetup
{
    self.pasteboard = [UIPasteboard generalPasteboard];
    if (![self.pasteboard.string isEqualToString: nil]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Paste?"
                                                          message:@"Would you like to paste your text?"
                                                         delegate:self
                                                cancelButtonTitle:@"Yes"
                                                otherButtonTitles:@"No", nil];
        [message show];
        
    }

}

- (void)newMailSetup
{
    self.composer = [[MFMailComposeViewController alloc] init];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Yes"]) {
        self.textView.text = self.pasteboard.string;
    }
}

- (IBAction)setContact:(id)sender
{
    [self.composer setToRecipients:@[@"tylacock@gmail.com", @"tylacock@fairmontsupply.com"]];
}

- (IBAction)sendMail:(id)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        
        
        [self.composer setMailComposeDelegate:self];
        [self.composer setMessageBody:self.textView.text isHTML:YES];
        
        [self presentViewController:self.composer animated:YES completion:NULL];
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
            self.textView.text = @"";
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.textView becomeFirstResponder];
    [self newMailSetup];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
