//
//  MCHandler.h
//  myProj
//
//  Created by Rahul Garg on 03/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "SecondViewController.h"

@interface MCHandler : NSObject <MCSessionDelegate>

@property (strong, nonatomic) MCPeerID *peerID; //represents the device and it contains various properties needed for the        discovery and session establishment phases

@property (nonatomic, strong) MCSession *session; // represents the session that the current peer (the device that this app will run) will create. Any data exchanging and any communication details are controlled by this object.

@property (nonatomic, strong) MCBrowserViewController *browser; //represents the default UI provided by Apple for browsing for other peers, and we will use it for this purpose.

@property (nonatomic, strong) MCAdvertiserAssistant *advertiser; //it is used from the current peer to advertise itself and make its discovery feasible.


@property (nonatomic, strong) id delegate;

+ sharedSingletonClass; // Singleton class

-(void)setupPeerAndSessionWithDisplayName:(NSString *)displayName;

-(void)setupMCBrowser;

-(void)advertiseSelf:(BOOL)shouldAdvertise;

@end
