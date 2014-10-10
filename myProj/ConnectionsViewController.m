//
//  ConnectionsViewController.m
//  myProj
//
//  Created by Rahul Garg on 03/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import "ConnectionsViewController.h"

@interface ConnectionsViewController ()

@end

@implementation ConnectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];
    
    [_Name resignFirstResponder];
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate]; // instantiate the appDelegate object using the sharedApplication class method.
    
    [[_appDelegate mcManager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name]; // call any required public methods of the mcManager object, the setupPeerAndSessionWithDisplayName: method is being called, and as we are in the initialisation of our class, as the display name of our device we specify its actual name.
   
    [[_appDelegate mcManager] advertiseSelf:_Visible_switch.isOn]; // current state of our switch, to either enable or keep nil the advertiser object.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(peerDidChangeStateWithNotification:) name:@"MCDidChangeStateNotification" object:nil]; // observer for notification
    
    _arrConnectedDevices = [[NSMutableArray alloc] init];
    
    [_ConnectedDevices_table setDelegate:self];
    [_ConnectedDevices_table setDataSource:self];
    //(for arrConnectedDevices) in order our table view to respond to everything we want, we must set our class as its delegate and its datasource.


}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}


-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{ // we want the keyboard to be disappeared when the Return button is tapped and the peerID object of the MCManager class to get the name we set to the text field.
    
    [_Name resignFirstResponder];
    
    _appDelegate.mcManager.peerID = nil;
    _appDelegate.mcManager.session = nil;
    _appDelegate.mcManager.browser = nil;
    
    if ([_Visible_switch isOn]) {
        [_appDelegate.mcManager.advertiser stop];
    }
    _appDelegate.mcManager.advertiser = nil;
    
    
    [_appDelegate.mcManager setupPeerAndSessionWithDisplayName:_Name.text];
    [_appDelegate.mcManager setupMCBrowser];
    [_appDelegate.mcManager advertiseSelf:_Visible_switch.isOn];
    
    return YES;
}

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification{ // implementation of private method notification
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    // get two objects from the user info dictionary (peerID and state), and keep the display name of the connected peer to a NSString object.
    
    if (state != MCSessionStateConnecting) {
        if (state == MCSessionStateConnected) {
            [_arrConnectedDevices addObject:peerDisplayName];
            
            [_ConnectedDevices_table reloadData];
            BOOL peersExist = ([[_appDelegate.mcManager.session connectedPeers] count] == 0);
            [_Disconnect_button setEnabled:!peersExist];
            [_Name setEnabled:peersExist];
        }
        else if (state == MCSessionStateNotConnected){
            if ([_arrConnectedDevices count] > 0) {
                int indexOfPeer = [_arrConnectedDevices indexOfObject:peerDisplayName];
                [_arrConnectedDevices removeObjectAtIndex:indexOfPeer];
            }
        }
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{ // table view delegate methods
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ // table view delegate methods
    return [_arrConnectedDevices count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{ // table view delegate methods
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    cell.textLabel.text = [_arrConnectedDevices objectAtIndex:indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //table view delegate methods
    return 50.0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Browse:(id)sender {
    [[_appDelegate mcManager] setupMCBrowser]; // calling of setupMCBrowser public method of the MCManager class.
    [[[_appDelegate mcManager] browser] setDelegate:self];
    [self presentViewController:[[_appDelegate mcManager] browser] animated:YES completion:nil];
}

- (IBAction)Visibility:(id)sender
{
    [_appDelegate.mcManager advertiseSelf:_Visible_switch.isOn];
}

- (IBAction)disconnect:(id)sender
{
    [_appDelegate.mcManager.session disconnect];
    
    _Name.enabled = YES;
    
    [_arrConnectedDevices removeAllObjects];
    [_ConnectedDevices_table reloadData];
}

@end
