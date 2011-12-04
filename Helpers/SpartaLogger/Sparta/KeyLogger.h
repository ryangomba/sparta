//
//  KeyLogger.h
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

@interface KeyLogger : NSObject {
    NSString *buffer;
}

@property (nonatomic, retain) NSString *buffer;

CGEventRef myCGEventCallback(CGEventTapProxy proxy, CGEventType type,
                             CGEventRef event, void *refcon);

- (void)startKeyLogger;
- (void)fillBuffer:(UniChar)c;
- (void)clearBuffer;
- (void)parseWord:(NSString *)word;

@end
