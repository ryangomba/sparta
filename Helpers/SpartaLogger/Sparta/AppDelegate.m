//
//  AppDelegate.m
//  Sparta
//
//  Created by Ryan Gomba on 11/15/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize appController;

- (void)dealloc
{
    [appController release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    appController = [[[Sparta alloc] init] retain];
    [appController startLogging];
}

@end
