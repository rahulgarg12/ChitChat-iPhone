//
//  MCManager.m
//  myProj
//
//  Created by Rahul Garg on 03/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import "MCManager.h"

@implementation MCManager

-(id)init{                          // initialise the class
    self = [super init];
    
    if (self) {
        _peerID = nil; // peerid object
        _session = nil; // session object
        _browser = nil; // browser object
        _advertiser = nil; // advertiser object
    }
    
    return self;
}

-(void)setupPeerAndSessionWithDisplayName:(NSString *)displayName{ // public method implementation
    _peerID = [[MCPeerID alloc] initWithDisplayName:displayName];
    
    _session = [[MCSession alloc] initWithPeer:_peerID];
    _session.delegate = self;
}

-(void)setupMCBrowser{ // public method implementation
    _browser = [[MCBrowserViewController alloc] initWithServiceType:@"chat-files" session:_session];
}

-(void)advertiseSelf:(BOOL)shouldAdvertise{ // public method implementation
                                            // for toggling the advertising feature of the device. We added a UISwitch object for making our peer visible/invisible to others.
    if (shouldAdvertise) {
        _advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:@"chat-files"
                                                           discoveryInfo:nil
                                                                 session:_session];
        [_advertiser start];
    }
    else{
        [_advertiser stop];
        _advertiser = nil;
    }
}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state  // delegate methods of MCSessionDelegate protocol.
{
    NSDictionary *dict = @{@"peerID": peerID, @"state" : [NSNumber numberWithInt:state]}; //
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCDidChangeStateNotification" object:nil userInfo:dict]; // for displaying notifications whenever state is changed.
    
    switch (state) {
        case MCSessionStateConnected:
            NSLog(@"Connected: {0}", peerID.displayName);
            break;
        case MCSessionStateConnecting:
            NSLog(@"Connecting: {0}", peerID.displayName);
            break;
        case MCSessionStateNotConnected:
            NSLog(@"Not Connected: {0}", peerID.displayName);
            break;
    }
}


-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID  // delegate methods of MCSessionDelegate protocol. Post a notification to know about the peer state changing, and along with the notification
{
    NSDictionary *dict = @{@"data": data, @"peerID": peerID};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCDidReceiveDataNotification" object:nil userInfo:dict]; //post a notification and dict as its user info directory.
}


-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress   // delegate methods of MCSessionDelegate protocol.

{
    
}


-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error   // delegate methods of MCSessionDelegate protocol.

{
    
}


-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID   // delegate methods of MCSessionDelegate protocol.

{
    
}

@end
