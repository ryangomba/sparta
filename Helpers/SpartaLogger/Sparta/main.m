//
//  main.m
//  Sparta
//
//  Created by Ryan Gomba on 11/15/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    AppDelegate * delegate = [[AppDelegate alloc] init];
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSApplication * application = [NSApplication sharedApplication];
    [application setDelegate:delegate];
    [NSApp run];
    
    [pool drain];
    
    [delegate release];
}
