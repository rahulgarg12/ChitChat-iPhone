//
//  ChatViewController.h
//  myProj
//
//  Created by Rahul Garg on 08/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface FirstViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtMessage;
@property (weak, nonatomic) IBOutlet UITextView *tvChat;


- (IBAction)sendMessage:(id)sender;
- (IBAction)cancelMessage:(id)sender;


@end
