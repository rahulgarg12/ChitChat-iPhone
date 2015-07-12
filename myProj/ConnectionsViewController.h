//
//  ConnectionsViewController.h
//  myProj
//
//  Created by Rahul Garg on 03/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MCHandler.h"


@interface ConnectionsViewController : UIViewController <MCBrowserViewControllerDelegate, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource> // MCBrowserViewControllerDelegate to handle the browser

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification; // action after notification receives

@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UISwitch *Visible_switch;
@property (weak, nonatomic) IBOutlet UITableView *ConnectedDevices_table;
@property (weak, nonatomic) IBOutlet UIButton *Disconnect_button;

@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;
- (IBAction)Browse:(id)sender;

- (IBAction)Visibility:(id)sender;

- (IBAction)disconnect:(id)sender;

//@property (weak, nonatomic) IBOutlet UITextField *txtMessage;

//@property (weak, nonatomic) IBOutlet UITextView *tvChat;

@end
