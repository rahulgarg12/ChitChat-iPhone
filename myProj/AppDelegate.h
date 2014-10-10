//
//  AppDelegate.h
//  myProj
//
//  Created by Rahul Garg on 03/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MCManager.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) MCManager *mcManager;

@end
